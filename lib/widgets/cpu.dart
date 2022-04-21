import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bar/palette.dart';
import 'package:flutter_bar/widgets/base.dart';

class CpuWidget extends StatefulWidget {
  const CpuWidget({Key? key}) : super(key: key);

  final icon = Icons.memory;

  @override
  State<CpuWidget> createState() => _CpuWidgetState();
}

class _CpuWidgetState extends State<CpuWidget> {
  final _streamController = StreamController<double>();
  late String _vendor;

  @override
  void initState() {
    super.initState();
    File f = File("/proc/cpuinfo");
    List<String> lines = f.readAsLinesSync();

    String vendorId = lines[1].substring("vendor_id	: ".length);
    switch (vendorId) {
      case "GenuineIntel":
        _vendor = "Intel";
        break;
      case "AuthenticAMD":
        _vendor = "AMD";
        break;
      case " KVMKVMKVM  ":
        _vendor = "KVM";
        break;
      case "TCGTCGTCGTCG":
        _vendor = "QEMU";
        break;
      default:
        _vendor = vendorId;
    }

    _loadCpuData();
  }

  void _loadCpuData() async {
    final f = File("/proc/stat");
    String line = "";
    double percent = 0.0;

    int idle, total, idlePrev = 0, totalPrev = 0;

    Timer.periodic(const Duration(seconds: 1), (timer) async {
      Stream<String> linesStream =
          f.openRead().transform(utf8.decoder).transform(const LineSplitter());

      line = await linesStream.first;
      List<int> values = line
          .substring("cpu  ".length)
          .split(" ")
          .map((e) => int.parse(e))
          .toList();

      idle = values[3];
      total = values.reduce((x, y) => x + y);

      int dTotal = idle - idlePrev;
      int dLoad = total - totalPrev;

      idlePrev = idle;
      totalPrev = total;

      percent = 100.0 * (1.0 - dTotal / dLoad);
      _streamController.add(percent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseButtonWidget(
        backgroundColor: Palette.leftWidgetsBackground,
        onPressed: () {},
        child: StreamBuilder(
            stream: _streamController.stream,
            builder: (context, AsyncSnapshot<double?> snapshot) {
              if (snapshot.hasData) {
                double percent = snapshot.data!;
                return BaseContentWidget(
                    icon: widget.icon,
                    text: "$_vendor: ${percent.toStringAsFixed(2)}%",
                    color: Palette.foreground);
              } else {
                return const Text("Error");
              }
            }));
  }
}

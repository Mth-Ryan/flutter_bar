import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bar/palette.dart';
import 'package:flutter_bar/widgets/base.dart';

class MemoryWidget extends StatefulWidget {
  const MemoryWidget({Key? key}) : super(key: key);

  final icon = Icons.memory;

  @override
  State<MemoryWidget> createState() => _MemoryWidgetState();
}

class _MemoryWidgetState extends State<MemoryWidget> {
  final _streamController = StreamController<int>();

  int _meminfoStart = 0; // meminfo data column start
  int _meminfoEnd = 0; // meminfo data column end

  @override
  void initState() {
    super.initState();

    File f = File("/proc/meminfo");
    String firstLine = f.readAsLinesSync()[0];
    for (var rune in firstLine.runes) {
      if (rune > 47 && rune < 58) {
        _meminfoEnd++;
      } else {
        _meminfoStart++;
      }
    }
    _meminfoStart -= " kB".length;
    _meminfoEnd += _meminfoStart + 1;

    _loadMemoryData();
  }

  void _loadMemoryData() async {
    final f = File("/proc/meminfo");
    List<String> lines = [];
    int usedMemory = 0;

    Timer.periodic(const Duration(seconds: 1), (timer) async {
      Stream<String> linesStream = f
          .openRead()
          .transform(utf8.decoder)
          .transform(const LineSplitter())
          .take(5);
      await for (final line in linesStream) {
        lines.add(line);
      }

      List<int> values = lines.map((line) {
        return int.parse(line.substring(_meminfoStart, _meminfoEnd));
      }).toList();

      //            total        free        buffers     cached
      usedMemory = values[0] - (values[1] + values[3] + values[4]);
      _streamController.add(usedMemory);

      lines = [];
    });
  }

  // Convert kB to GB
  double _convert(int memory) {
    return memory / pow(1024, 2);
  }

  @override
  Widget build(BuildContext context) {
    return BaseButtonWidget(
        backgroundColor: Palette.leftWidgetsBackground,
        onPressed: () {},
        child: StreamBuilder(
            stream: _streamController.stream,
            builder: (context, AsyncSnapshot<int?> snapshot) {
              if (snapshot.hasData) {
                double usedMemory = _convert(snapshot.data!);
                return BaseContentWidget(
                    icon: widget.icon,
                    text: "${usedMemory.toStringAsFixed(2)} GB",
                    color: Palette.leftForeground);
              } else {
                return const Text("Error");
              }
            }));
  }
}

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bar/palette.dart';
import 'base.dart';

class SystemWidget extends StatefulWidget {
  const SystemWidget({Key? key}) : super(key: key);
  @override
  State<SystemWidget> createState() => _SystemWidgetState();
}

class _SystemWidgetState extends State<SystemWidget> {
  late String _id;
  IconData _icon = CupertinoIcons.f_cursive_circle_fill;
  String _distro = "Linux";

  @override
  void initState() {
    super.initState();

    final idRegex = RegExp(r'^ID=');
    final f = File("/etc/os-release");
    if (f.existsSync()) {
      _id = f
          .readAsLinesSync()
          .firstWhere((e) => idRegex.hasMatch(e))
          .split("=")[1];
      _distro = "${_id[0].toUpperCase()}${_id.substring(1)}";
      // TODO: get icon from id;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseButtonWidget(
        backgroundColor: Palette.systemBackground,
        onPressed: () {},
        child: BaseContentWidget(
            color: Palette.leftForeground, icon: _icon, text: _distro));
  }
}

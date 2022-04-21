import 'package:flutter/cupertino.dart';
import 'package:flutter_bar/palette.dart';
import 'package:flutter_bar/widgets/base.dart';

class DesktopWidget extends StatefulWidget {
  DesktopWidget({Key? key}) : super(key: key);

  final icon = CupertinoIcons.desktopcomputer;
  final dektopList = <String>["I", "II", "III", "IV", "V"];

  @override
  State<DesktopWidget> createState() => _DesktopWidgetState();
}

class _DesktopWidgetState extends State<DesktopWidget> {
  int _desktopIndex = 0;

  void _changeIndex() {
    setState(() {
      if (_desktopIndex == widget.dektopList.length - 1) {
        _desktopIndex = 0;
      } else {
        _desktopIndex += 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseButtonWidget(
        backgroundColor: Palette.leftWidgetsBackground,
        onPressed: _changeIndex,
        child: BaseContentWidget(
            color: Palette.leftForeground,
            icon: widget.icon,
            text: widget.dektopList[_desktopIndex]));
  }
}

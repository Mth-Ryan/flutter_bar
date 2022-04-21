import 'package:flutter/cupertino.dart';
import 'package:flutter_bar/palette.dart';
import 'package:flutter_bar/widgets/base.dart';

class BatteryWidget extends StatefulWidget {
  BatteryWidget({Key? key}) : super(key: key);

  final List<IconData> icons = [
    CupertinoIcons.battery_0,
    CupertinoIcons.battery_25,
    CupertinoIcons.battery_75_percent,
    CupertinoIcons.battery_full
  ];

  @override
  State<BatteryWidget> createState() => _BatteryWidgetState();
}

class _BatteryWidgetState extends State<BatteryWidget> {
  int _level = 100;
  bool _charging = false;

  IconData _getIcon() {
    if (_level < 25) {
      return widget.icons[0];
    } else if (_level < 75) {
      return widget.icons[1];
    } else if (_level < 98) {
      return widget.icons[2];
    } else {
      return widget.icons[3];
    }
  }

  bool _isCritical() {
    return _level < 25 && !_charging;
  }

  @override
  Widget build(BuildContext context) {
    return BaseButtonWidget(
        backgroundColor: _isCritical()
            ? Palette.batteryWidgetCriticalBackground
            : Palette.batteryWidgetBackground,
        onPressed: () {
          setState(() {
            if (_level < 25) {
              _level = 100;
            } else {
              _level -= 25;
            }
          });
        },
        child: BaseContentWidget(
            color: Palette.rightForeground,
            icon: _getIcon(),
            text: "$_level%"));
  }
}

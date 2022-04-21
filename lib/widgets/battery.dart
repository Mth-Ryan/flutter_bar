import 'dart:async';
import 'dart:io';
import 'package:collection/collection.dart';
import 'package:battery_plus/battery_plus.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bar/palette.dart';
import 'package:flutter_bar/utils/color.dart';
import 'package:flutter_bar/widgets/base.dart';

class BatteryWidget extends StatefulWidget {
  BatteryWidget({Key? key}) : super(key: key);

  final IconData chargeIndicator = CupertinoIcons.bolt_fill;
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
  bool _hasBattery = false;
  late Stream<BatteryState> _bateryStateStream;
  final _capacityStreamController = StreamController<int>();

  @override
  void initState() {
    super.initState();
    final dirRegex = RegExp(r'^BAT+[0-9]');
    final powerSupply = Directory("/sys/class/power_supply");

    FileSystemEntity? batFolder = powerSupply
        .listSync()
        .firstWhereOrNull((e) => dirRegex.hasMatch(e.path.split("/").last));

    if (batFolder != null) {
      _hasBattery = true;
      final bat = Battery();

      _bateryStateStream = bat.onBatteryStateChanged;
      _getBatteryCapacity(bat);
    }
  }

  void _getBatteryCapacity(Battery bat) async {
    Timer.periodic(const Duration(seconds: 2), (_) async {
      int capacity = await bat.batteryLevel;
      _capacityStreamController.add(capacity);
    });
  }

  IconData _getIcon(int capacity) {
    if (capacity < 25) {
      return widget.icons[0];
    } else if (capacity < 75) {
      return widget.icons[1];
    } else if (capacity < 98) {
      return widget.icons[2];
    } else {
      return widget.icons[3];
    }
  }

  Color _getForegroundColor(int capacity) {
    return (capacity > 25)
        ? Palette.rightForeground
        : Palette.batteryWidgetCriticalForeground;
  }

  @override
  Widget build(BuildContext context) {
    if (!_hasBattery) {
      return Container();
    } else {
      return StreamBuilder(
          stream: _bateryStateStream,
          builder: (stateContext, AsyncSnapshot<BatteryState?> stateSnapshot) {
            if (stateSnapshot.hasData) {
              Widget chargingIndicator =
                  (stateSnapshot.data! == BatteryState.charging)
                      ? Row(children: [
                          const SizedBox(width: 8),
                          Icon(widget.chargeIndicator,
                              size: 15,
                              color: ColorUtils.scale(
                                  Palette.batteryWidgetBackground, 0.11))
                        ])
                      : Container();

              return BaseButtonWidget(
                  backgroundColor: Palette.batteryWidgetBackground,
                  onPressed: () {},
                  child: Row(
                    children: [
                      StreamBuilder(
                          stream: _capacityStreamController.stream,
                          builder: (capacityContext,
                              AsyncSnapshot<int?> capacitySnapshot) {
                            if (capacitySnapshot.hasData) {
                              int capacity = capacitySnapshot.data!;
                              return BaseContentWidget(
                                  icon: _getIcon(capacity),
                                  text: "$capacity%",
                                  color: _getForegroundColor(capacity));
                            } else {
                              return BaseContentWidget(
                                  icon: widget.icons[0],
                                  text: "Error",
                                  color:
                                      Palette.batteryWidgetCriticalForeground);
                            }
                          }),
                      chargingIndicator,
                    ],
                  ));
            } else {
              return Container();
            }
          });
    }
  }
}

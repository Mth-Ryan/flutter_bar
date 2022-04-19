import 'package:flutter/material.dart';
import 'package:flutter_bar/widgets/audio.dart';
import 'package:flutter_bar/widgets/battery.dart';
import 'package:flutter_bar/widgets/clock.dart';
import 'package:flutter_bar/widgets/cpu.dart';
import 'package:flutter_bar/widgets/desktop.dart';
import 'package:flutter_bar/widgets/memory.dart';
import 'package:flutter_bar/widgets/network.dart';
import 'package:flutter_bar/widgets/system.dart';
import 'palette.dart';

class Bar extends StatelessWidget {
  const Bar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Palette.background,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // Left
            Row(
              children: <Widget>[
                SystemWidget(),
                DesktopWidget(),
                CpuWidget(),
                MemoryWidget(),
              ],
            ),
            // Right
            Row(
              children: <Widget>[
                AudioWidget(),
                NetworkWidget(),
                BatteryWidget(),
                const ClockWidget()
              ],
            ),
          ],
        ));
  }
}

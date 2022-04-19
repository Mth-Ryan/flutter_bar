import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bar/palette.dart';
import 'package:flutter_bar/widgets/base.dart';

class MemoryWidget extends StatefulWidget {
  const MemoryWidget({Key? key}) : super(key: key);

  final icon = Icons.memory;
  final double totalMemory = 8.58993459e9;

  @override
  State<MemoryWidget> createState() => _MemoryWidgetState();
}

class _MemoryWidgetState extends State<MemoryWidget> {
  final _unities = {"MB": pow(1024, 2), "GB": pow(1024, 3)};
  final _currentUnity = "MB";

  double _freeMemory = 0.0;

  double _convert(double memory) {
    return memory / _unities[_currentUnity]!;
  }

  @override
  Widget build(BuildContext context) {
    final double _usedMemory = _convert(widget.totalMemory - _freeMemory);
    return BaseButtonWidget(
        backgroundColor: Palette.leftWidgetsBackground,
        onPressed: () {
          // Todo Change unity
          setState(() {
            _freeMemory += pow(1024.0, 2);
          });
        },
        child: BaseContentWidget(
            color: Palette.foreground,
            icon: widget.icon,
            text: "${_usedMemory.toStringAsFixed(2)} $_currentUnity"));
  }
}

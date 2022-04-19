import 'dart:ffi';

import 'package:flutter/material.dart';

class BaseButtonWidget extends StatelessWidget {
  const BaseButtonWidget(
      {Key? key,
      required this.backgroundColor,
      required this.onPressed,
      required this.child})
      : super(key: key);

  final Color backgroundColor;
  final Function() onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.resolveWith((states) => backgroundColor)),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}

class BaseContentWidget extends StatelessWidget {
  const BaseContentWidget(
      {Key? key, required this.icon, required this.text, required this.color})
      : super(key: key);

  final Color color;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(icon, color: color, size: 15.0),
        const SizedBox(width: 8),
        Text(text, style: TextStyle(color: color))
      ],
    );
  }
}

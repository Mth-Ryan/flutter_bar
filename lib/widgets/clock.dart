import 'package:flutter/cupertino.dart';
import 'package:flutter_bar/palette.dart';
import 'package:flutter_bar/widgets/base.dart';

enum _ClockFormat { full, hour }

class ClockWidget extends StatefulWidget {
  const ClockWidget({Key? key}) : super(key: key);

  final icon = CupertinoIcons.alarm;

  @override
  State<ClockWidget> createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget> {
  DateTime _date = DateTime.now();
  _ClockFormat _format = _ClockFormat.hour;

  void _changeFormat() {
    setState(() {
      _format = (_format == _ClockFormat.hour)
          ? _ClockFormat.full
          : _ClockFormat.hour;
    });
  }

  String _getDate() {
    String format(int num) {
      String str = num.toString();
      if (str.length == 1) {
        return "0" + str;
      }
      return str;
    }

    String hour = "${format(_date.hour)}:${format(_date.minute)}";
    if (_format == _ClockFormat.hour) {
      return hour;
    } else {
      return "${format(_date.month)}/${format(_date.day)}/${_date.year}, " +
          hour;
    }
  }

  void _updateTime() async {
    while (true) {
      setState(() {
        _date = DateTime.now();
      });
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    _updateTime();
    return BaseButtonWidget(
        backgroundColor: Palette.clockWidgetBackground,
        onPressed: _changeFormat,
        child: BaseContentWidget(
            color: Palette.background, icon: widget.icon, text: _getDate()));
  }
}

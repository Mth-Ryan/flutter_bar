import 'dart:async';

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
  final _streamControler = StreamController<DateTime>();
  late _ClockFormat _format;

  @override
  void initState() {
    super.initState();

    _format = _ClockFormat.hour;
    _loadDate();
  }

  void _loadDate() async {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      _streamControler.add(DateTime.now());
    });
  }

  void _changeFormat() {
    setState(() {
      _format = (_format == _ClockFormat.hour)
          ? _ClockFormat.full
          : _ClockFormat.hour;
    });
  }

  String _formatDate(DateTime date) {
    String format(int num) {
      String str = num.toString();
      if (str.length == 1) {
        return "0" + str;
      }
      return str;
    }

    String hour = "${format(date.hour)}:${format(date.minute)}";
    if (_format == _ClockFormat.hour) {
      return hour;
    } else {
      return "${format(date.month)}/${format(date.day)}/${date.year}, " + hour;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseButtonWidget(
        backgroundColor: Palette.clockWidgetBackground,
        onPressed: _changeFormat,
        child: StreamBuilder(
            stream: _streamControler.stream,
            builder: (context, AsyncSnapshot<DateTime?> snapshot) {
              if (snapshot.hasData) {
                DateTime date = snapshot.data!;
                return BaseContentWidget(
                    icon: widget.icon,
                    text: _formatDate(date),
                    color: Palette.background);
              } else {
                return const Text("Error");
              }
            }));
  }
}

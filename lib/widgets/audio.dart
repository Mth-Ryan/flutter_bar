import 'package:flutter/cupertino.dart';
import 'package:flutter_bar/palette.dart';
import 'package:flutter_bar/widgets/base.dart';

enum _WidgetState { control, playingNow }

class AudioWidget extends StatefulWidget {
  AudioWidget({Key? key}) : super(key: key);

  final List<IconData> volumeIcons = [
    CupertinoIcons.volume_off,
    CupertinoIcons.volume_down,
    CupertinoIcons.volume_up
  ];

  final IconData PlayIcon = CupertinoIcons.music_note;

  @override
  State<AudioWidget> createState() => _AudioWidgetState();
}

class _AudioWidgetState extends State<AudioWidget> {
  _WidgetState _state = _WidgetState.control;
  int _volume = 100;
  String _playingNow = "Pink Floyd - Time";

  IconData _getVolumeIcon() {
    if (_volume == 0) {
      return widget.volumeIcons[0];
    } else if (_volume <= 50) {
      return widget.volumeIcons[1];
    } else {
      return widget.volumeIcons[2];
    }
  }

  Widget _getContent() {
    switch (_state) {
      case _WidgetState.control:
        return BaseContentWidget(
            icon: _getVolumeIcon(),
            text: "$_volume%",
            color: Palette.rightForeground);
      case _WidgetState.playingNow:
        return BaseContentWidget(
            icon: widget.PlayIcon,
            text: _playingNow,
            color: Palette.rightForeground);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseButtonWidget(
        backgroundColor: Palette.audioWidgetBackground,
        onPressed: () {
          setState(() {
            _state = (_state == _WidgetState.control)
                ? _WidgetState.playingNow
                : _WidgetState.control;
          });
        },
        child: _getContent());
  }
}

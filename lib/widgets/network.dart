import 'package:flutter/cupertino.dart';
import 'package:flutter_bar/palette.dart';
import 'package:flutter_bar/widgets/base.dart';

enum _ConnectionType { wired, wifi, disconnected }

class NetworkWidget extends StatefulWidget {
  NetworkWidget({Key? key}) : super(key: key);

  final Map<_ConnectionType, IconData> icons = {
    _ConnectionType.wired: CupertinoIcons.antenna_radiowaves_left_right,
    _ConnectionType.wifi: CupertinoIcons.wifi,
    _ConnectionType.disconnected: CupertinoIcons.wifi_slash
  };

  @override
  State<NetworkWidget> createState() => _NetworkWidgetState();
}

class _NetworkWidgetState extends State<NetworkWidget> {
  _ConnectionType _status = _ConnectionType.wifi;

  String _getStatusContent() {
    if (_status == _ConnectionType.disconnected) {
      return "Disconnected";
    }

    const String ssid = "NetworkExample";

    return ssid;
  }

  @override
  Widget build(BuildContext context) {
    return BaseButtonWidget(
        backgroundColor: Palette.networkWidgetBackground,
        onPressed: () {},
        child: BaseContentWidget(
            color: Palette.background,
            icon: widget.icons[_status]!,
            text: _getStatusContent()));
  }
}

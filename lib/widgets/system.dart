import 'package:flutter/cupertino.dart';
import 'base.dart';
import '../palette.dart';

class SystemWidget extends StatelessWidget {
  SystemWidget({Key? key}) : super(key: key);

  final distro = "Fedora";
  final icon = CupertinoIcons.f_cursive_circle_fill;

  @override
  Widget build(BuildContext context) {
    return BaseButtonWidget(
        backgroundColor: Palette.systemBackground,
        onPressed: () {},
        child: BaseContentWidget(
            color: Palette.foreground, icon: icon, text: distro));
  }
}

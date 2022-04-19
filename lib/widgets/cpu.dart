import 'package:flutter/cupertino.dart';
import 'package:flutter_bar/palette.dart';
import 'package:flutter_bar/widgets/base.dart';

class CpuWidget extends StatelessWidget {
  const CpuWidget({Key? key}) : super(key: key);

  final icon = CupertinoIcons.wrench;
  final name = "Intel i5";

  @override
  Widget build(BuildContext context) {
    return BaseButtonWidget(
        backgroundColor: Palette.leftWidgetsBackground,
        onPressed: () {},
        child: BaseContentWidget(
            color: Palette.foreground, icon: icon, text: name));
  }
}

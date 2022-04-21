import 'package:flutter/widgets.dart';

class ColorUtils {
  static Color scale(Color source, double percent) {
    double factor = 1 + percent;
    int apply(int a) => (a * factor).round();

    int r = apply(source.red);
    int g = apply(source.green);
    int b = apply(source.blue);

    return Color.fromARGB(source.alpha, r, g, b);
  }
}

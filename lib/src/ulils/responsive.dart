import 'package:flutter/widgets.dart';
import 'dart:math' as math;


class Responsive {
  final double height, width, inch;

  Responsive({@required this.height = 0.0, @required this.width = 0.0, @required this.inch = 0.0});

  factory Responsive.of(BuildContext context){
    final MediaQueryData data = MediaQuery.of(context);
    final size = data.size;

    final inch = math.sqrt(math.pow(size.width, 2) + math.pow(size.height, 2));
    return Responsive(width: size.width, height: size.height, inch: inch);
  }

  double wd(double percent){
    return this.width * percent / 100;
  }

  double hg(double percent){
    return this.height * percent / 100;
  }

  double ip(double percent){
    return this.inch * percent / 100;
  }
}
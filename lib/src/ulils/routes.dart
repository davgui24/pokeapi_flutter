

import 'package:flutter/material.dart';
import 'package:pokemon/pages/home.dart';

Map<String, Widget Function(BuildContext)> routes() {
  return {
     'home': (BuildContext context) => Home(),
  };
}
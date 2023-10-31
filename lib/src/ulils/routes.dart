

import 'package:flutter/material.dart';
import 'package:pokemon/pages/detail_of_item.dart';
import 'package:pokemon/pages/home.dart';

Map<String, Widget Function(BuildContext)> routes() {
  return {
     'home': (BuildContext context) => Home(),
     'detail_of_item': (BuildContext context) => DetailOfItem(),
  };
}
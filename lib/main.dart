import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pokemon/src/ulils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'POKEAPI',
        debugShowCheckedModeBanner: false,
        builder: EasyLoading.init(),
        initialRoute: 'home',
        routes: routes(),
      );
  }
}
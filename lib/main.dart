import 'package:flutter/material.dart';
import 'bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Bar',
      theme: ThemeData(),
      home: const MainBar(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainBar extends StatelessWidget {
  const MainBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Bar();
  }
}

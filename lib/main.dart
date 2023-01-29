import 'package:clean_architecture_forcast_weather/locator.dart';
import 'package:flutter/material.dart';

import 'core/main_wrapper.dart';

void main() async {
  await setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Forcast Weather',
      home: MainWrapper(),
    );
  }
}

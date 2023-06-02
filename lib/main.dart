import 'package:animation_examples/ui/data_backup/data_backup_screen.dart';
import 'package:flutter/material.dart';

import 'ui/bank_screen.dart';
import 'ui/flight_app/flight_app_screen.dart';
import 'ui/main_bounce_tab_bar.dart';
import 'ui/movie_app/src/movies/movie_app.dart';
import 'ui/multiple_card_flow/multiple_card_flow_screen.dart';
import 'ui/radial_progress/radial_progress_widget.dart';
import 'ui/tween_animation_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Canvas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, brightness: Brightness.dark),
      home: const MyHomeScreen(),
    );
  }
}

class MyHomeScreen extends StatelessWidget {
  const MyHomeScreen({super.key});

  final title1 = 'Tween Animation Builder';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Animations'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(40),
          children: [
            ElevatedButton(
                onPressed: () {
                  push(context, TweenAnimationScreen(title: title1));
                },
                child: const Text('Tween Animation Builder')),
            ElevatedButton(
                onPressed: () {
                  push(context, const MainBounceTabBar());
                },
                child: const Text('Main Bounce Tab Bar')),
            ElevatedButton(
                onPressed: () {
                  push(context, const BankScreen());
                },
                child: const Text('Bank App')),
            ElevatedButton(
                onPressed: () {
                  push(context, const DataBackupScreen());
                },
                child: const Text('Data Backup')),
            ElevatedButton(
                onPressed: () {
                  push(context, const FlightHomeApp());
                },
                child: const Text('Flight App')),
            ElevatedButton(
                onPressed: () {
                  push(context, const MultipleCardFlow());
                },
                child: const Text('Multiple Card Flow')),
            ElevatedButton(
                onPressed: () {
                  push(context, const MovieApp());
                },
                child: const Text('Movie App')),
                 ElevatedButton(
                onPressed: () {
                  push(context, const RadialProgressWidget());
                },
                child: const Text('Radial Progress'))
          ],
        ));
  }

  void push(BuildContext context, Widget child) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => child,
        ));
  }
}

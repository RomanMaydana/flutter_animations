
import 'package:flutter/material.dart';

import 'ui/tween_animation_scree.dart';
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
                  push(context,
                       TweenAnimationScreen(title: title1));
                },
                child: const Text('Tween Animation Builder')),
            // ElevatedButton(
            //     onPressed: () {
            //       push(context, const CanvasRenderObjectSample());
            //     },
            //     child: const Text('Canvas RenderObject Sample')),
            // ElevatedButton(
            //     onPressed: () {
            //       push(context, const CanvasCustomPaintSample());
            //     },
            //     child: const Text('Canvas CustomPaint')),
            // ElevatedButton(
            //     onPressed: () {
            //       push(context, const CanvasPerformanceSample());
            //     },
            //     child: const Text('Canvas Performance')),
            // ElevatedButton(
            //     onPressed: () {
            //       push(context, const TalkInteractivePage());
            //     },
            //     child: const Text('Talk Interactive Page')),
            // ElevatedButton(
            //     onPressed: () {
            //       push(context, const AnimatedDonutChart());
            //     },
            //     child: const Text('Animated Donut Chart')),
            // ElevatedButton(
            //     onPressed: () {
            //       push(context, const ParticlesAnimationScreen());
            //     },
            //     child: const Text('Particles animation'))
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

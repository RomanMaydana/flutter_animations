import 'package:flutter/material.dart';

class FlightRoutes extends StatelessWidget {
  const FlightRoutes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            left: 0.0,
            top: 0.0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.25,
            child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xffe04148), Color(0xffd85774)])),
            ),
          ),
          const Positioned(
              top: 20,
              left: 10,
              child: BackButton(
                color: Colors.white,
              )),
          Positioned(
              left: 10,
              right: 10,
              top: MediaQuery.of(context).size.height * 0.15,
              child: const Column(
                children: [
                  RouteItem(
                    duration: Duration(milliseconds: 400),
                  ),
                  RouteItem(
                    duration: Duration(milliseconds: 600),
                  ),
                  RouteItem(
                    duration: Duration(milliseconds: 800),
                  ),
                  RouteItem(
                    duration: Duration(milliseconds: 1000),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}

class RouteItem extends StatelessWidget {
  const RouteItem({super.key, required this.duration});
  final Duration duration;
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween(begin: 1.0, end: 0.0),
      curve: Curves.decelerate,
      duration: duration,
      builder: (context, value, child) {
        return Transform.translate(
            offset: Offset(0.0, MediaQuery.of(context).size.height * value),
            child: child!);
      },
      child: const Card(
        child: Padding(
          padding: EdgeInsets.all(18.0),
          child: Row(
            children: [
              Expanded(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Sahara',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'SHE',
                    style: TextStyle(fontSize: 24, color: Colors.grey),
                  ),
                ],
              )),
              Expanded(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.flight,
                    color: Colors.red,
                  ),
                  Text(
                    'SE2341',
                    style: TextStyle(fontSize: 1),
                  )
                ],
              )),
              Expanded(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Macao',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'SHE',
                    style: TextStyle(fontSize: 24, color: Colors.grey),
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}

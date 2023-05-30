import 'package:flutter/material.dart';

import 'flight_form.dart';
import 'flight_time_line.dart';

enum FlightView { form, timeline }

class FlightHomeApp extends StatefulWidget {
  const FlightHomeApp({super.key});

  @override
  State<FlightHomeApp> createState() => _FlightHomeAppState();
}

class _FlightHomeAppState extends State<FlightHomeApp> {
  FlightView flightView = FlightView.form;

  @override
  Widget build(BuildContext context) {
    final headerHight = MediaQuery.of(context).size.height * 0.32;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                height: headerHight,
                left: 0,
                right: 0,
                child: const DecoratedBox(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xffe04148), Color(0xffd85774)])),
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Text(
                          'Air Asia',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            HeaderButton(title: 'one way', selected: false),
                            HeaderButton(title: 'round', selected: false),
                            HeaderButton(title: 'multicity', selected: true)
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                  left: 10,
                  right: 10,
                  top: headerHight / 2,
                  bottom: 0,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Expanded(
                                child:
                                    TabButton(title: 'Flight', selected: true)),
                            Expanded(
                                child:
                                    TabButton(title: 'Train', selected: false)),
                            Expanded(
                                child:
                                    TabButton(title: 'Bus', selected: false)),
                          ],
                        ),
                        Expanded(
                            child: flightView == FlightView.form
                                ? FlightForm(
                                    onTap: _onflightPressed,
                                  )
                                : const FlightTimeLine())
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void _onflightPressed() {
    setState(() {
      flightView = FlightView.timeline;
    });
  }
}

class TabButton extends StatelessWidget {
  const TabButton({super.key, required this.title, required this.selected});
  final String title;
  final bool selected;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              title,
              style: TextStyle(color: selected ? Colors.black : Colors.grey),
            ),
          ),
          if (selected)
            Container(
              height: 1,
              color: Colors.red,
            )
        ],
      ),
    );
  }
}

class HeaderButton extends StatelessWidget {
  const HeaderButton({super.key, required this.title, required this.selected});

  final String title;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: selected ? Colors.white : null,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 13),
        child: Center(
          child: Text(
            title.toUpperCase(),
            style: TextStyle(color: selected ? Colors.red : Colors.white),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class FlightForm extends StatelessWidget {
  const FlightForm({super.key, required this.onTap});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
         const Row(
            children: [
              Icon(
                Icons.flight_takeoff,
                color: Colors.red,
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: TextField(
                decoration: InputDecoration(labelText: 'From'),
              ))
            ],
          ),
         const  SizedBox(
            height: 10,
          ),
         const Row(
            children: [
              Icon(
                Icons.flight_land,
                color: Colors.red,
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: TextField(
                decoration: InputDecoration(labelText: 'To'),
              ))
            ],
          ),
          const Spacer(),
          FloatingActionButton(onPressed: onTap, backgroundColor: Colors.red, child: const Icon(Icons.multiline_chart),)
        ],
      ),
    );
  }
}

import 'package:animation_examples/ui/multiple_card_flow/multiple_card_flow_screen.dart';
import 'package:animation_examples/ui/multiple_card_flow/place.dart';
import 'package:flutter/material.dart';

class MultipleCardFlowDetails extends StatelessWidget {
  const MultipleCardFlowDetails({super.key, required this.city});

  final City city;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          const Positioned.fill(child:  DecoratedBox(decoration: BoxDecoration(
            gradient: backgroundGradient
          ))),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: CityWidget(city: city, padding: const EdgeInsets.only(left: 40, top: 40),)),
                Expanded(
                  flex: 5,
                  child: ListView.builder(
                    itemCount: city.reviews.length,
                    itemBuilder: (_, index) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: ReviewWidget(review: city.reviews[index]));
                  },))
              ],
            ),
          ),
          const Positioned(
            left: 20,
            top: 20,
            child: BackButton())
        ],
      ),
    );
  }
}
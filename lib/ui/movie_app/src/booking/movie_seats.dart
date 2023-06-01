import 'package:animation_examples/ui/movie_app/core/data/models/movies.dart';
import 'package:animation_examples/ui/movie_app/src/booking/movie_seat_sectin.dart';
import 'package:flutter/material.dart';

class MovieSeates extends StatelessWidget {
  const MovieSeates({super.key, required this.seats});
  final List<List<Seat>> seats;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            for(int i =0; i < 3; i++)
              MovieSeatSection(seats: seats[i], isFront: true)
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
             for(int i = 3; i < 6; i++)
              MovieSeatSection(seats: seats[i], isFront: true)
          ],
        )
      ],
    );
  }
}
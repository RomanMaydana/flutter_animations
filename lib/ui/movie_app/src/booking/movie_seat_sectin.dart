import 'package:animation_examples/ui/movie_app/core/data/models/movies.dart';
import 'package:flutter/material.dart';

import 'movie_seat_box.dart';

class MovieSeatSection extends StatelessWidget {
  const MovieSeatSection({super.key, required this.seats, required this.isFront});
  final List<Seat> seats;
  final bool isFront;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: isFront ? 16 : 20,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, mainAxisSpacing: 8, crossAxisSpacing: 8),
          itemBuilder: (_, index) {
            final seat = seats[index];
            return MovieSeatBox(seat: seat);
          },),
    );
  }
}

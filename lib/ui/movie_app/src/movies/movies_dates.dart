import 'package:animation_examples/ui/movie_app/src/booking/movie_date_card.dart';
import 'package:flutter/material.dart';

import '../../core/data/models/movies.dart';

class MovieDates extends StatefulWidget {
  const MovieDates({super.key, required this.dates});
  final List<MovieDate> dates;
  @override
  State<MovieDates> createState() => _MovieDatesState();
}

class _MovieDatesState extends State<MovieDates> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      clipBehavior: Clip.none,
      itemCount: widget.dates.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: (){
            setState(() {
              _selectedIndex = index;
            });
          },
          child: MovieDateCard(date: widget.dates[index], isSelected: index == _selectedIndex));
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 10,
      ),
    );
  }
}
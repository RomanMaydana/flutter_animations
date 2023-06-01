// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animation_examples/ui/movie_app/core/constants/constants.dart';
import 'package:flutter/material.dart';

import 'package:animation_examples/ui/movie_app/core/data/models/movies.dart';

class MovieSeatBox extends StatefulWidget {
  const MovieSeatBox({
    Key? key,
    required this.seat,
  }) : super(key: key);
  final Seat seat;

  @override
  State<MovieSeatBox> createState() => _MovieSeatBoxState();
}

class _MovieSeatBoxState extends State<MovieSeatBox> {
  @override
  Widget build(BuildContext context) {
    final color = widget.seat.isHidden
        ? Colors.white
        : widget.seat.isOcuppied
            ? Colors.black
            : widget.seat.isSelected
                ? AppColors.primaryColor
                : Colors.grey.shade200;
    return GestureDetector(
      onTap: (){
        setState(() {
          widget.seat.isSelected = !widget.seat.isSelected;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(3)),
      ),
    );
  }
}

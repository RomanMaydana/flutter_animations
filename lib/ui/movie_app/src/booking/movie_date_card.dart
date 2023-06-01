import 'package:animation_examples/ui/movie_app/core/constants/constants.dart';
import 'package:animation_examples/ui/movie_app/core/data/models/movies.dart';
import 'package:flutter/material.dart';

class MovieDateCard extends StatelessWidget {
  const MovieDateCard({super.key, required this.date, required this.isSelected});
  final MovieDate date;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        color: isSelected? AppColors.primaryColor: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: AppColors.primaryColor
        )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('${date.day} ${date.month}', style: TextStyle(
            color: isSelected? Colors.white70: AppColors.primaryColor
          ),),
          const SizedBox(
            height: 5,
          ),
          Text(date.hour, style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isSelected? Colors.white : AppColors.primaryColor
          ),)
        ],
      ),
    );

  }
}
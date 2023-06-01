import 'package:animation_examples/ui/movie_app/core/constants/constants.dart';
import 'package:flutter/material.dart';

import '../../core/data/models/movies.dart';
import '../booking/booking_page.dart';

class BookButton extends StatelessWidget {
  const BookButton({super.key, required this.movie});
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        const transitionDuration = Duration(milliseconds: 200);

        Navigator.of(context).push(PageRouteBuilder(
          transitionDuration: transitionDuration,
          reverseTransitionDuration: transitionDuration,
          pageBuilder: (_, animation, __) {
          return FadeTransition(opacity: animation, child: BookingPage(movie: movie),);
        },));
      },
      child: Container(
        height: 60 ,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(20)
        ),
        // child: ,
      ),
    );
  }
}
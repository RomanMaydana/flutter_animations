import 'package:animation_examples/ui/movie_app/core/data/models/movies.dart';
import 'package:animation_examples/ui/movie_app/src/animations/opacity_tween.dart';
import 'package:animation_examples/ui/movie_app/src/animations/sliode_up_tween.dart';
import 'package:animation_examples/ui/movie_app/src/movie/movie_info_table_item.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_text_styles.dart';
import 'book_button.dart';
import 'movie_card.dart';
import 'movie_stars.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({super.key, required this.movie});
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final height = constraints.maxHeight;
      final width = constraints.maxWidth;
      return Scaffold(
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
                top: height * -0.1,
                width: width,
                height: height * 0.6,
                child: Hero(
                    tag: movie.image, child: MovieCard(image: movie.image))),
            Positioned(
                height: height * 0.5,
                width: width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Hero(
                        tag: movie.name,
                        child: Material(
                          type: MaterialType.transparency,
                          child: Text(
                            movie.name.toUpperCase(),
                            style: AppTextStyles.movieNameTextStyle,
                          ),
                        ),
                      ),
                      OpacityTween(
                      begin: 0.0,
                        child: SlideUpTween(
                          begin: const Offset(-30, 30),
                          child: MovieStars(stars: movie.stars))),

                      const SizedBox(
                        height: 20,
                      ),
                      OpacityTween(
                        child: SlideUpTween(
                          begin: const Offset(0, 200),
                          child: Text(
                            movie.description,
                            style: AppTextStyles.movieDescriptionStyle
                                .copyWith(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      OpacityTween(
                        child: SlideUpTween(
                          begin: const Offset(0, 200),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MovieInfoTableItem(
                                  title: 'Type', content: movie.type),
                              MovieInfoTableItem(
                                  title: 'Hour', content: '${movie.hours} Hour'),
                              MovieInfoTableItem(
                                  title: 'Director', content: movie.director),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )),
            const Positioned(
                top: 40,
                left: 20,
                child: OpacityTween(
                  child: BackButton(
                    color: Colors.white,
                  ),
                )),

            Positioned(
              bottom: height * 0.03,
              height: height * 0.07,
              width: width * 0.7,
              child: OpacityTween(
                
                child: SlideUpTween(
                  begin: const Offset(-30, 60),
                  child: BookButton(
                    movie: movie
                  ),
                ),
              )),
            Positioned(
              bottom: height * 0.05,
              child: const OpacityTween(
                child:  SlideUpTween(
                  begin:  Offset(-30, 60),
                  child: IgnorePointer(
                    child: Text('Book Ticket', style: AppTextStyles.bookButtonTextStyle,),
                  ),
                ),
              ))
          ],
        ),
      );
    });
  }
}

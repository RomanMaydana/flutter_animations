import 'dart:ui';

import 'package:animation_examples/ui/movie_app/core/constants/constants.dart';
import 'package:animation_examples/ui/movie_app/core/data/data.dart';
import 'package:flutter/material.dart';

import '../movie/movie_page.dart';

class MoviesView extends StatefulWidget {
  const MoviesView({super.key});

  @override
  State<MoviesView> createState() => _MoviesViewState();
}

class _MoviesViewState extends State<MoviesView> {
  late final PageController _movieCardPageController;
  late final PageController _movieDetailPageController;
  double _movieCardPage = 0.0;
  double _movieDetailsPage = 0.0;
  int _movieCardIndex = 0;
  final _showMovieDetails = ValueNotifier<bool>(true);

  @override
  void initState() {
    _movieCardPageController = PageController(viewportFraction: 0.77);
    _movieCardPageController.addListener(_movieCardPageListener);

    _movieDetailPageController = PageController();
    _movieDetailPageController.addListener(_movieDetailsPercentListener);

    super.initState();
  }

  @override
  void dispose() {
    _movieCardPageController.removeListener(_movieCardPageListener);
    _movieCardPageController.dispose();
    _movieDetailPageController.removeListener(_movieDetailsPercentListener);
    _movieDetailPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;
        final width = constraints.maxWidth;
        return Column(
          children: [
            const Spacer(),
            SizedBox(
              height: height * 0.6,
              child: PageView.builder(
                controller: _movieCardPageController,
                clipBehavior: Clip.none,
                itemCount: movies.length,
                onPageChanged: (page) {
                  _movieDetailPageController.animateToPage(
                    page,
                    duration: const Duration(milliseconds: 550),
                    curve: Curves.decelerate,
                  );
                },
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  final progress = (_movieCardPage - index);
                  final scale = lerpDouble(1, 0.8, progress.abs())!;
                  final isScrolling = _movieCardPageController
                      .position.isScrollingNotifier.value;
                  final isCurrentPage = index == _movieCardIndex;
                  final isFirstPage = index == 0;
                  // if(isFirstPage){
                  //   print(scale);
                  //   print('${progress.abs()} progress.abs()');
                  // }
                  return GestureDetector(
                    onTap: () {
                      _showMovieDetails.value = !_showMovieDetails.value;

                      const transitionDuration = Duration(milliseconds: 550);

                      Navigator.of(context).push(PageRouteBuilder(
                        transitionDuration: transitionDuration,
                        reverseTransitionDuration: transitionDuration,
                        pageBuilder: (context, animation, _) => FadeTransition(
                          opacity: animation,
                          child: MoviePage(movie: movie),
                        ),
                      ));
                      
                      Future.delayed(transitionDuration, () {
                        _showMovieDetails.value = !_showMovieDetails.value;
                      });
                    },
                    child: Transform.scale(
                      alignment: Alignment.lerp(
                          Alignment.topLeft, Alignment.center, -progress),
                      scale: isScrolling && isFirstPage ? 1 - progress : scale,
                      child: Center(
                        child: Hero(
                          tag: movie.image,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            transform: Matrix4.identity()
                              ..translate(isCurrentPage ? 0.0 : -20.0,
                                  isCurrentPage ? 0.0 : 60.0),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(movie.image),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(70),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 25,
                                      offset: const Offset(0, 25))
                                ]),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const Spacer(),
            SizedBox(
              height: height * 0.3,
              child: PageView.builder(
                controller: _movieDetailPageController,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: movies.length,
                itemBuilder: (_, index) {
                  final movie = movies[index];
                  final opacity = (index - _movieDetailsPage).clamp(0.0, 1.0);

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                    child: Opacity(
                      opacity: 1 - opacity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                          ValueListenableBuilder<bool>(
                            valueListenable: _showMovieDetails,
                            builder: (_, value, child) {
                              return Visibility(visible: value, child: child!);
                            },
                            child: Text(
                              movie.actors.join(', '),
                              style: AppTextStyles.movieDetails,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }

  void _movieCardPageListener() {
    setState(() {
      _movieCardPage = _movieCardPageController.page!;
      _movieCardIndex = _movieCardPageController.page!.round();
    });
  }

  void _movieDetailsPercentListener() {
    setState(() {
      _movieDetailsPage = _movieDetailPageController.page!;
    });
  }
}

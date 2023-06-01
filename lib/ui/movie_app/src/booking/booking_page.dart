import 'package:animation_examples/ui/movie_app/core/constants/constants.dart';
import 'package:animation_examples/ui/movie_app/core/data/models/movies.dart';
import 'package:animation_examples/ui/movie_app/src/animations/booking_page_animation_controller.dart';
import 'package:animation_examples/ui/movie_app/src/animations/custom_animated_opacity.dart';
import 'package:animation_examples/ui/movie_app/src/biometric/custom_biometrics_page.dart';
import 'package:animation_examples/ui/movie_app/src/booking/movie_app_bar.dart';
import 'package:animation_examples/ui/movie_app/src/booking/movie_seat_type_legend.dart';
import 'package:animation_examples/ui/movie_app/src/booking/movie_seats.dart';
import 'package:animation_examples/ui/movie_app/src/movies/movies_dates.dart';
import 'package:flutter/material.dart';

import 'movie_teather_screen.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key, required this.movie});
  final Movie movie;

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage>
    with TickerProviderStateMixin {
  late final BookingPageAnimationController _controller;

  @override
  void initState() {
    _controller = BookingPageAnimationController(
        buttonController: AnimationController(
            vsync: this, duration: const Duration(milliseconds: 750)),
        contentController: AnimationController(
            vsync: this, duration: const Duration(milliseconds: 750)));
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _controller.buttonController.forward();
      await _controller.buttonController.reverse();
      await _controller.contentController.forward();
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final height = constraints.maxHeight;
        final width = constraints.maxWidth;
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: CustomAnimatedOpacity(
                animation: _controller.topOpacityAnimation,
                child: MovieAppBar(title: widget.movie.name)),
          ),
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Positioned(
                  width: width,
                  height: height * 0.85,
                  child: Column(
                    children: [
                      const Spacer(),
                      CustomAnimatedOpacity(
                        animation: _controller.topOpacityAnimation,
                        child: SizedBox(
                          height: height * 0.075,
                          child: MovieDates(dates: widget.movie.dates),
                        ),
                      ),
                      const Spacer(),
                      CustomAnimatedOpacity(
                        animation: _controller.topOpacityAnimation,
                        child: SizedBox(
                          height: height * 0.2,
                          width: width,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: MovieTeatherScreen(
                              image: widget.movie.image,
                              maxWidth: width,
                              maxHeight: height,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      CustomAnimatedOpacity(
                          animation: _controller.topOpacityAnimation,
                          child: MovieSeates(seats: widget.movie.seats)),
                      const Spacer(),
                      CustomAnimatedOpacity(
                          animation: _controller.topOpacityAnimation,
                          child: const MovieSeatTypeLegend()),
                      const Spacer(
                        flex: 20,
                      ),
                    ],
                  )),
              Positioned(
                  bottom: 0,
                  child: AnimatedBuilder(
                    animation: _controller.buttonController,
                    builder: (_, __) {
                      final size = _controller
                          .buttonSizeAnimation(Size(width * 0.7, height * 0.07),
                              Size(width * 1.2, height * 1.1))
                          .value;

                      final margin = _controller
                          .buttonMarginAnimation(height * 0.03)
                          .value;

                      return GestureDetector(
                        onTap: () {
                          // const transitionDuration =
                          //     Duration(milliseconds: 400);

                          // Navigator.of(context).push(PageRouteBuilder(
                          //   transitionDuration: transitionDuration,
                          //   reverseTransitionDuration: transitionDuration,
                          //   pageBuilder: (_, animation, __) {
                          //     return FadeTransition(
                          //       opacity: animation,
                          //       child: const CustomBiometricsPage(),
                          //     );
                          //   },
                          // ));
                        },
                        child: Container(
                          height: size.height,
                          width: size.width,
                          margin: EdgeInsets.only(bottom: margin),
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      );
                    },
                  )),
              Positioned(
                  bottom: height * 0.05,
                  child: const IgnorePointer(
                    child: Text(
                      'Buy Ticket',
                      style: AppTextStyles.bookButtonTextStyle,
                    ),
                  ))
            ],
          ),
        );
      },
    );
  }
}

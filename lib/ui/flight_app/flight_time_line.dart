import 'package:flutter/material.dart';

import 'flight_routes.dart';

const _airplaneSize = 30.0;
const _dotSize = 15.0;
const _cardAnimationDuration = 100;

class FlightTimeLine extends StatefulWidget {
  const FlightTimeLine({super.key});

  @override
  State<FlightTimeLine> createState() => _FlightTimeLineState();
}

class _FlightTimeLineState extends State<FlightTimeLine> {
  bool animated = false;
  bool animateCards = false;
  bool animateButton = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initAnimation();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;

    return LayoutBuilder(builder: (context, constraints) {
      final center = constraints.maxWidth / 2 - _dotSize / 2;
      return Stack(
        children: [
          AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              left: constraints.maxWidth / 2 - _airplaneSize / 2,
              top: animated ? 20 : constraints.maxHeight - _airplaneSize - 10,
              bottom: 0.0,
              child: const AircraftAndLine()),
          AnimatedPositioned(
              duration: const Duration(milliseconds: 600),
              left: center,
              top: animated ? 80 : constraints.maxHeight,
              child: TimelineDot(
                selected: true,
                displayCar: animateCards,
                delay: const Duration(milliseconds: _cardAnimationDuration),
              )),
          AnimatedPositioned(
              duration: const Duration(milliseconds: 800),
              right: center,
              top: animated ? 140 : constraints.maxHeight,
              child: TimelineDot(
                left: false,
                displayCar: animateCards,
                delay: const Duration(milliseconds: _cardAnimationDuration * 2),
              )),
          AnimatedPositioned(
              duration: const Duration(milliseconds: 1000),
              left: center,
              top: animated ? 200 : constraints.maxHeight,
              child: TimelineDot(
                displayCar: animateCards,
                delay: const Duration(milliseconds: _cardAnimationDuration * 3),
              )),
          AnimatedPositioned(
              duration: const Duration(milliseconds: 1200),
              right: center,
              top: animated ? 260 : constraints.maxHeight,
              child: TimelineDot(
                selected: true,
                left: false,
                displayCar: animateCards,
                delay: const Duration(milliseconds: _cardAnimationDuration * 4),
              )),
          if (animateButton)
            Align(
              alignment: Alignment.bottomCenter,
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 500),
                builder: (__, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: child,
                  );
                },
                child: FloatingActionButton(
                  backgroundColor: Colors.red,
                  onPressed: _onRoutesPressed,
                  child: const Icon(Icons.check),
                ),
              ),
            ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: FloatingActionButton(
          //     backgroundColor: Colors.red,
          //     onPressed: initAnimation,
          //     child: const Icon(Icons.check),
          //   ),
          // ),
        ],
      );
    });
  }

  void _onRoutesPressed() async {
    Navigator.push(context, PageRouteBuilder(
      pageBuilder: (_, animation1, __) {
        return FadeTransition(
          opacity: animation1,
          child: const FlightRoutes(),
        );
      },
    ));
  }

  void initAnimation() async {
    setState(() {
      animated = !animated;
    });
    await Future.delayed(const Duration(milliseconds: 1200));
    setState(() {
      animateCards = true;
    });

    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      animateButton = true;
    });
  }
}

class AircraftAndLine extends StatelessWidget {
  const AircraftAndLine({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _airplaneSize,
      child: Column(
        children: [
          const Icon(
            Icons.flight,
            color: Colors.red,
            size: _airplaneSize,
          ),
          Expanded(
              child: Container(
            width: 5,
            color: Colors.grey[300],
          ))
        ],
      ),
    );
  }
}

class TimelineDot extends StatefulWidget {
  const TimelineDot(
      {super.key,
      this.selected = false,
      this.displayCar = false,
      this.left = true,
      required this.delay});
  final bool selected;
  final bool displayCar;
  final bool left;
  final Duration delay;

  @override
  State<TimelineDot> createState() => _TimelineDotState();
}

class _TimelineDotState extends State<TimelineDot> {
  bool animated = false;

  void _animatedWidthDelay() async {
    if (widget.displayCar) {
      await Future.delayed(widget.delay);
      setState(() {
        animated = true;
      });
    }
  }

  @override
  void didUpdateWidget(covariant TimelineDot oldWidget) {
    _animatedWidthDelay();
    super.didUpdateWidget(oldWidget);
  }

  Widget _buildCard() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: _cardAnimationDuration),
      builder: (context, value, child) {
        return Transform.scale(
            alignment:
                !widget.left ? Alignment.centerRight : Alignment.centerLeft,
            scale: value,
            child: child!);
      },
      child: Container(
        color: Colors.grey[200],
        padding: const EdgeInsets.all(20),
        child: const Text('JFK + QRY'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (widget.displayCar && !widget.left) ...[
          _buildCard(),
          Container(
            width: 10,
            height: 1,
            color: Colors.grey[400],
          ),
        ],
        Container(
          height: _dotSize,
          width: _dotSize,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey[300]!,
            ),
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: CircleAvatar(
              backgroundColor: widget.selected ? Colors.red : Colors.green,
            ),
          ),
        ),
        if (widget.displayCar && widget.left) ...[
          Container(
            width: 10,
            height: 1,
            color: Colors.grey[400],
          ),
          _buildCard()
        ]
      ],
    );
  }
}

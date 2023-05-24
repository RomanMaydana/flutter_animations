import 'package:flutter/material.dart';

class MainBounceTabBar extends StatefulWidget {
  const MainBounceTabBar({super.key});

  @override
  State<MainBounceTabBar> createState() => _MainBounceTabBarState();
}

class _MainBounceTabBarState extends State<MainBounceTabBar> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _currentIndex,
        children: [
          Container(
            color: Colors.red,
          ),
          Container(
            color: Colors.yellow,
          ),
          Container(
            color: Colors.black,
          ),
          Container(
            color: Colors.cyan,
          ),
        ],
      ),
      bottomNavigationBar: BounceTabBar(
        backgroundColor: Colors.purple,
        items: const [
          Icon(Icons.person_outline),
          Icon(Icons.print),
          Icon(Icons.signal_cellular_no_sim),
          Icon(Icons.speaker_notes),
     
        ],
        onTapChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}


class BounceTabBar extends StatefulWidget {
  const BounceTabBar(
      {super.key,
      this.backgroundColor = Colors.red,
      required this.items,
      required this.onTapChanged,
      this.initialIndex = 0, this.movement = 200.0});

  final Color backgroundColor;
  final List<Widget> items;
  final ValueChanged<int> onTapChanged;
  final int initialIndex;
  final double movement;
  @override
  State<BounceTabBar> createState() => _BounceTabBarState();
}

class _BounceTabBarState extends State<BounceTabBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animTabBarIn;
  late Animation _animTabBarOut;
  late Animation _animCircleItem;
  late Animation _animElevationIn;
  late Animation _animElevationOut;

  late int _currentIndex = widget.initialIndex;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));
    _animTabBarIn =
        CurveTween(curve: const Interval(0.1, 0.6, curve: Curves.decelerate))
            .animate(_controller);
    _animTabBarOut =
        CurveTween(curve: const Interval(0.6, 1, curve: Curves.bounceOut))
            .animate(_controller);

    _animCircleItem =
        CurveTween(curve: const Interval(0.0, 0.3)).animate(_controller);

    _animElevationIn =
        CurveTween(curve: const Interval(0.3, 0.5, curve: Curves.decelerate))
            .animate(_controller);
    _animElevationOut =
        CurveTween(curve: const Interval(0.55, 1.0, curve: Curves.bounceOut))
            .animate(_controller);
    
    _controller.forward(from: 1.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double currentWidth = width;
    double currentElevation = 0.0;
    return SizedBox(
      height: kBottomNavigationBarHeight,
      child: AnimatedBuilder(
          animation: _controller,
          builder: (_, __) {
            // print(
            //     ' (movement* ${_animTabBarIn.value}) + (movement * ${_animTabBarOut.value})');
            currentWidth = width -
                (widget.movement * _animTabBarIn.value) +
                (widget.movement * _animTabBarOut.value);
            currentElevation = -widget.movement * _animElevationIn.value +
                (widget.movement - kBottomNavigationBarHeight / 4) *
                    _animElevationOut.value;
            return Center(
              child: Container(
                width: currentWidth,
                decoration: BoxDecoration(
                    color: widget.backgroundColor,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(20))),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(widget.items.length, (index) {
                      final child = widget.items[index];
                      final innerWidget = CircleAvatar(
                            radius: 30,
                            foregroundColor: Colors.white,
                            backgroundColor: widget.backgroundColor,
                            child: child);
                      if (_currentIndex == index) {
                        return Expanded(
                          child: CustomPaint(
                            foregroundPainter: _CircleItemPainter(
                            progress: _animCircleItem.value),
                            child: Transform.translate(
                          offset: Offset(0.0, currentElevation),
                          child: innerWidget,
                            ),
                          ),
                        );
                      } else {
                        return Expanded(
                          child: GestureDetector(
                            onTap: () {
                              widget.onTapChanged(index);
                              setState(() {
                                _currentIndex = index;
                              });
                              _controller.forward(from: 0.0);
                            },
                            child: innerWidget,
                          ),
                        );
                      }
                    })),
              ),
            );
          }),
    );
  }
}

class _CircleItemPainter extends CustomPainter {
  _CircleItemPainter({required this.progress});
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = 20.0 * progress;
    const strokeWidth = 10.0;
    final currentStrokeWidth = strokeWidth * (1 - progress);

    if (progress < 1.0) {
      canvas.drawCircle(
          center,
          radius,
          Paint()
            ..color = Colors.black
            ..style = PaintingStyle.stroke
            ..strokeWidth = currentStrokeWidth);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

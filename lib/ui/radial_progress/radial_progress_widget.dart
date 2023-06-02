import 'package:animation_examples/ui/radial_progress/particle.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'dart:ui';
class RadialProgressWidget extends StatefulWidget {
  const RadialProgressWidget({super.key});

  @override
  State<RadialProgressWidget> createState() => _RadialProgressWidgetState();
}

class _RadialProgressWidgetState extends State<RadialProgressWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _particleController;
  final particles = List<Particle>.generate(
      200, (index) => Particle(radialSize + thickness / 2));
  @override
  void initState() {
    const duration = Duration(milliseconds: 2000);
    _controller = AnimationController(
      vsync: this,
      duration: duration,
      reverseDuration: duration,
    );
    _particleController = AnimationController(
      vsync: this,
      duration: duration,
      reverseDuration: duration,
    );

    _controller.forward().whenComplete(() {
      _particleController
          .forward()
          .whenComplete(() => _particleController.repeat());
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter:
            RadialProgressPainter(_controller, _particleController, particles),
        child: const SizedBox.expand(),
      ),
    );
  }
}

const radialSize = 100.0;
const thickness = 10.0;
const textStyle =
    TextStyle(color: Colors.red, fontSize: 50, fontWeight: FontWeight.bold);

const col1 = Color(0xff110f14);
const col2 = Color(0xff2a2732);
const col3 = Color(0xff3c393f);
const col4 = Color(0xff6047f5);
const col5 = Color(0xffa3b0ef);

class RadialProgressPainter extends CustomPainter {
  RadialProgressPainter(this.animation, this.particleAnimation, this.particles)
      : super(repaint: Listenable.merge([animation, particleAnimation]));
  final Animation<double> animation;
  final Animation<double> particleAnimation;
  final List<Particle> particles;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

   drawBackground(canvas, center, size.height / 2);

    final rect = Rect.fromCenter(
        center: center, width: 2 * radialSize, height: 2 * radialSize);
    drawGuide(canvas, center, radialSize);
    drawArc(canvas, rect);
    drawTextCentered(canvas, center, (animation.value * 100).toInt().toString(),
        textStyle, radialSize * 2);
    if (particleAnimation.value > 0) {
      drawParticles(canvas, center);
    }
  }

  void drawBackground(Canvas canvas, Offset center, double extent){
    final rect = Rect.fromCenter(center: center, width: extent, height: extent);
    final bgPaint = Paint()
    ..shader = const RadialGradient(colors: [col1, col2]).createShader(rect)
    ..style = PaintingStyle.fill;

    canvas.drawPaint(bgPaint);

  }

  void drawParticles(Canvas canvas, Offset center) {
    final paint = Paint();
    for (var particle in particles) {
      final centerParticle =
          polarToCartesian(particle.orbit, particle.theta) + center;
      paint.color = particle.color.withOpacity(particle.opacity);
      canvas.drawCircle(centerParticle, 1.0, paint);
      particle.update();
    }
  }

  void drawGuide(Canvas canvas, Offset center, double radius) {
    final paint = Paint()
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke
      ..color = Colors.grey.shade400;
    canvas.drawCircle(center, radius, paint);
  }

  void drawArc(Canvas canvas, Rect rect) {

    final fgPaint = Paint()
    ..strokeWidth = thickness
    .. style = PaintingStyle.stroke
    ..shader = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [col4, col5],
      tileMode: TileMode.mirror
      ).createShader(rect);
    final startAngle = vector.radians(-90);
    final sweepAngle = vector.radians(360.0 * animation.value);

    canvas.drawArc(rect, startAngle, sweepAngle, false, fgPaint);
  }

  Size drawTextCentered(Canvas canvas, Offset position, String text,
      TextStyle style, double maxWidth) {
    final tp = measureText(text, style, maxWidth, TextAlign.center);
    tp.paint(canvas, position + Offset(-tp.width / 2, -tp.height / 2));
    return tp.size;
  }

  TextPainter measureText(
      String text, TextStyle style, double maxWidth, TextAlign alignment) {
    final span = TextSpan(text: text, style: style);
    final tp = TextPainter(
        text: span, textAlign: alignment, textDirection: TextDirection.ltr);
    tp.layout(minWidth: 0, maxWidth: maxWidth);
    return tp;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

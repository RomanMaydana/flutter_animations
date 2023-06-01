import 'package:flutter/material.dart';

class MovieTeatherScreen extends StatelessWidget {
  const MovieTeatherScreen(
      {super.key,
      required this.image,
      required this.maxWidth,
      required this.maxHeight});

  final String image;
  final double maxWidth;
  final double maxHeight;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          decoration: BoxDecoration(
              image:
                  DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(15)),
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(0.8),
          transformAlignment: Alignment.topCenter,
        ),
        Positioned(
          height: maxHeight * 0.03,
          width: maxWidth * 0.5,
          bottom: maxHeight * 0.025,
          child: CustomPaint(
            painter: TeatherSeparation(),
          ),
        )
      ],
    );
  }
}

class TeatherSeparation extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    final paint = Paint()
    ..color = Colors.grey.shade200
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.5;

    final path = Path()
    ..moveTo(0, height)
    ..quadraticBezierTo(width*0.44, height * 0.57, width * 0.5, height * 0.6)
    ..quadraticBezierTo(width * 0.66,height*0.57 , width, height);

    canvas.drawPath(path, paint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

}
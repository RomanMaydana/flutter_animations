import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'data_backup_screen.dart';

class DataBackupCloudScreen extends AnimatedWidget {
  const DataBackupCloudScreen({super.key, required Animation endingAnimation})
      : super(listenable: endingAnimation);

  Animation<double> get animation => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    return animation.value > 0
        ? Positioned.fill(
            child: SafeArea(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomPaint(
                    foregroundPainter: _DataBackupCompletedPainter(animation),
                    child: const SizedBox(
                      height: 150,
                      width: 150,
                    ),
                  ),
                )),
                const SizedBox(
                  height: 60,
                ),
                Expanded(
                  child: TweenAnimationBuilder(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 400),
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,
                          child: Transform.translate(
                              offset: Offset(0.0, 50 * (1 - value)),
                              child: child),
                        );
                      },
                      child: Column(
                        children: [
                          const Text(
                            'data has succesfully\nuploaded',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          const Spacer(),
                          OutlinedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                    color: Colors.grey.withOpacity(0.5)),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 40),
                                child: Text(
                                  'OK',
                                  style: TextStyle(color: mainDataBackupColor),
                                ),
                              )),
                          const SizedBox(
                            height: 40,
                          )
                        ],
                      )),
                ),
              ],
            )),
          )
        : const SizedBox.shrink();
  }
}

class _DataBackupCompletedPainter extends CustomPainter {

  _DataBackupCompletedPainter(this.animation): super(repaint: animation);

  final Animation<double> animation;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = mainDataBackupColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final circlePath = Path();
    circlePath.addArc(
        Rect.fromCenter(center: Offset(size.width / 2, size.height / 2), width:size. width, height: size.height),
        vector.radians(-90.0),
        vector.radians(360*animation.value));
    
    final leftLine = size.width * 0.2;
    final rightLine = size.width * 0.3;

    final leftPercent = animation.value > 0.5 ? 1.0: animation.value / 0.5;
    final rightPercent = animation.value < 0.5 ? 0.0 : (animation.value - 0.5)/0.5;

    canvas.save();
    canvas.translate(size.width / 3, size.height / 2);
    canvas.rotate(vector.radians(-45));
    canvas.drawLine(Offset.zero, Offset(0.0, leftLine* leftPercent), paint);
    canvas.drawLine(Offset(0.0, leftLine), Offset(rightLine* rightPercent, leftLine), paint);
    canvas.restore();

    canvas.drawPath(circlePath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

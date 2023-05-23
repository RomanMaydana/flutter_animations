import 'package:flutter/material.dart';

class TweenAnimationScreen extends StatefulWidget {
  const TweenAnimationScreen({super.key, required this.title});
  final String title;

  @override
  State<TweenAnimationScreen> createState() => _TweenAnimationScreenState();
}

class _TweenAnimationScreenState extends State<TweenAnimationScreen> {
  int _counter = 0;
  int? _oldCounter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          key: Key(_counter.toString()),
          duration: const Duration(seconds: 2),
          builder: (context, value, _) {
            return Stack(
              children: [
                if (_oldCounter != null)
                  Opacity(
                    opacity: 1 - value,
                    child: Transform.translate(
                      offset: Offset(50 * value, 0),
                      child: Text(
                        _oldCounter.toString(),
                        style: const TextStyle(
                            fontSize: 80, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(-50 * (1 - value), 0),
                    child: Text(
                      _counter.toString(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 80,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _oldCounter = _counter;
          setState(() {
            _counter++;
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

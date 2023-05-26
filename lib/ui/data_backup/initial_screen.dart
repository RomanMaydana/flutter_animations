import 'package:animation_examples/ui/data_backup/data_backup_screen.dart';
import 'package:flutter/material.dart';

const _duration = Duration(milliseconds: 500);

enum DataBackupState {
  initial,
  start,
  end,
}

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key, required this.onAnimationStarted, required this.progressAnimation});
  final VoidCallback onAnimationStarted;
  final Animation<double> progressAnimation;
  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  DataBackupState _currentState = DataBackupState.initial;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Expanded(
              flex: 3,
              child: Text(
                'Cloud Storage',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.black),
              ),
            ),
            if (_currentState == DataBackupState.end)
              Expanded(
                flex: 2,
                child: TweenAnimationBuilder(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: _duration,
                  builder: (_, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                          offset: Offset(0.0, 50 * value), child: child),
                    );
                  },
                  child:  Column(
                    children: [
                      const Text(
                        'uploading files',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w300,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                          child: FittedBox(
                        child: Padding(
                          padding:const  EdgeInsets.only(bottom: 20),
                          child: ProgressCounter(
                            animation: widget.progressAnimation,
                          ),
                        ),
                      ))
                    ],
                  ),
                ),
              ),
            if (_currentState != DataBackupState.end)
              Expanded(
                flex: 2,
                child: TweenAnimationBuilder(
                  tween: Tween(
                      begin: 1.0,
                      end:
                          _currentState != DataBackupState.initial ? 0.0 : 1.0),
                  duration: _duration,
                  onEnd: () {
                    setState(() {
                      _currentState = DataBackupState.end;
                    });
                  },
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                          offset: Offset(0.0, 50 * value), child: child),
                    );
                  },
                  child: const Column(
                    children: [
                      Text(
                        'last backup:',
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('28 may 2023',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 20))
                    ],
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AnimatedSwitcher(
                duration: _duration,
                child: _currentState == DataBackupState.initial
                    ? SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: mainDataBackupColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15))),
                            onPressed: () {
                              setState(() {
                                _currentState = DataBackupState.start;
                              });
                              widget.onAnimationStarted();
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Text(
                                'Create Backup',
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                      )
                    : OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.grey.withOpacity(0.5)),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 40),
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: mainDataBackupColor),
                          ),
                        )),
              ),
            ),
            const SizedBox(
              height: 25,
            )
          ],
        ),
      ),
    );
  }
}

class ProgressCounter extends AnimatedWidget {
  const ProgressCounter({super.key, required Animation<double> animation}) : super(listenable: animation);

  double get value => (listenable as Animation).value;

  @override
  Widget build(BuildContext context) {
    return  Text(
      '${(value*100).truncate().toString()}%',
      style: const TextStyle(color: Colors.black),
    );
  }
}

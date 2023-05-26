import 'package:animation_examples/ui/data_backup/data_backup_cloud.dart';
import 'package:animation_examples/ui/data_backup/data_backup_completed_screen.dart';
import 'package:animation_examples/ui/data_backup/initial_screen.dart';
import 'package:flutter/material.dart';

const mainDataBackupColor = Color(0xff5113AA);
const secondaryDataBackupColor = Color(0xffBC53FA);
const backgroundColor = Color(0xfffce7fe);

class DataBackupScreen extends StatefulWidget {
  const DataBackupScreen({super.key});

  @override
  State<DataBackupScreen> createState() => _DataBackupScreenState();
}

class _DataBackupScreenState extends State<DataBackupScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;
  late Animation<double> _cloudOutAnimation;
  late Animation<double> _endingAnimation;
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 7));

    _progressAnimation = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.65),
    );

    _cloudOutAnimation = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.7, 0.85, curve: Curves.easeOut),
    );
    _endingAnimation = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.8, 1.0, curve: Curves.decelerate),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          InitialScreen(
            onAnimationStarted: () {
              _animationController.forward();
            },
            progressAnimation: _progressAnimation,
          ),
          DataBackupCloud(
            progressAnimation: _progressAnimation,
            cloudOutAnimation: _cloudOutAnimation,
          ),
          DataBackupCloudScreen(
            endingAnimation: _endingAnimation,
          )
        ],
      ),
    );
  }
}

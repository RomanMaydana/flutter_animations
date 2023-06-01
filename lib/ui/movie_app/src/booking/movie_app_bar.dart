import 'package:flutter/material.dart';

class MovieAppBar extends StatelessWidget {
  const MovieAppBar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
    );
  }
}
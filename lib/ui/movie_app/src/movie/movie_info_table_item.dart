import 'package:animation_examples/ui/movie_app/core/constants/constants.dart';
import 'package:flutter/material.dart';

class MovieInfoTableItem extends StatelessWidget {
  const MovieInfoTableItem({super.key, required this.title, required this.content});
  final String title;
  final String content;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(padding: const EdgeInsets.only(bottom: 10),
          child: Text(title, style: AppTextStyles.infoTitleStyle,), 
        ),
        Text(content, style: AppTextStyles.infoContentStyle,)
      ],
    );
  }
}
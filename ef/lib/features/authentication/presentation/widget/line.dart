import 'package:flutter/material.dart';

class Line extends StatelessWidget {
  final Color start;
  final Color end;
  const Line({super.key, required this.start, required this.end});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      height: 2,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [start, end],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

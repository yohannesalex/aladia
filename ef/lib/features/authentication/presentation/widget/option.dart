import 'package:flutter/material.dart';

class Option extends StatelessWidget {
  final text;
  final icon;
  const Option({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 20,
        ),
        Image.asset(
          icon,
          width: 20,
          height: 20,
        ),
        const SizedBox(
          width: 15,
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: 16, color: Theme.of(context).colorScheme.primary),
        )
      ],
    );
  }
}

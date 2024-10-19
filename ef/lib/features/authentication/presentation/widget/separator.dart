import 'package:ef/features/authentication/presentation/widget/line.dart';
import 'package:flutter/material.dart';

class Separator extends StatelessWidget {
  const Separator({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Line(
              start: Theme.of(context).colorScheme.background,
              end: Theme.of(context).colorScheme.primary),
        ),
        const SizedBox(width: 20),
        Text(
          "Or",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Theme.of(context).colorScheme.primary),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Line(
              start: Theme.of(context).colorScheme.primary,
              end: Theme.of(context).colorScheme.background),
        ),
      ],
    );
  }
}

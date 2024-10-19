import 'package:flutter/material.dart';

class LoginError extends StatelessWidget {
  final String text;
  const LoginError({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            text,
            style: const TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }
}

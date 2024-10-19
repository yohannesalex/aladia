import 'package:ef/features/authentication/presentation/widget/button.dart';
import 'package:ef/features/authentication/presentation/widget/option.dart';
import 'package:flutter/material.dart';

class SigninOptions extends StatelessWidget {
  const SigninOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Button(
            widget: Option(
                text: "Sign in with Google", icon: "assets/icons/google.png")),
        SizedBox(
          height: 30,
        ),
        Button(
          widget: Option(
            icon: "assets/icons/facebook.png",
            text: "Sign in with Facebook",
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Button(
            widget: Option(
          icon: "assets/icons/apple.png",
          text: "Sign in with Apple",
        ))
      ],
    );
  }
}

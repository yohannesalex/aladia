import 'package:ef/features/authentication/presentation/widget/button.dart';
import 'package:ef/features/authentication/presentation/widget/error.dart';
import 'package:ef/features/authentication/presentation/widget/input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/theme.dart';
import '../provider/auth_provider.dart';
import '../provider/theme_provider.dart';

class Email extends StatefulWidget {
  const Email({super.key});

  @override
  State<Email> createState() => _EmailState();
}

class _EmailState extends State<Email> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Column(
      children: [
        Text(
          "Enter your email",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.primary),
        ),
        const SizedBox(height: 30),
        SizedBox(
          width: 350,
          height: 50,
          child: Input(
            obscure: false,
            icon: const Icon(
              Icons.email,
              color: Color.fromARGB(255, 83, 83, 83),
            ),
            text: "E-mail",
            controller: emailController,
          ),
        ),
        authProvider.emailError != ""
            ? LoginError(text: authProvider.emailError)
            : const SizedBox.shrink(),
        const SizedBox(height: 20),
        SizedBox(
          width: 350,
          height: 50,
          child: Input(
              icon: const Icon(
                Icons.lock,
                color: Color.fromARGB(255, 83, 83, 83),
              ),
              text: "Password",
              controller: passwordController,
              obscure: true),
        ),
        authProvider.passwordError != ""
            ? LoginError(text: authProvider.passwordError)
            : const SizedBox.shrink(),
        authProvider.connectionError != ""
            ? LoginError(text: authProvider.connectionError)
            : const SizedBox.shrink(),
        authProvider.serverError != ""
            ? LoginError(text: authProvider.serverError)
            : const SizedBox.shrink(),
        const SizedBox(height: 15),
        authProvider.success != ""
            ? Text(
                authProvider.success,
                style: const TextStyle(color: Colors.blue, fontSize: 18),
              )
            : const SizedBox.shrink(),
        const SizedBox(height: 15),
        SizedBox(
          width: 350,
          height: 50,
          child: Button(
            onTap: () {
              authProvider.login(
                emailController.text,
                passwordController.text,
              );
            },
            widget: authProvider.isLoading
                ? CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Provider.of<ThemeProvider>(context).themeData ==
                            lightMode
                        ? Colors.black
                        : Colors.white,
                  )
                : Text(
                    "Enter",
                    style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.primary),
                  ),
          ),
        )
      ],
    );
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/theme.dart';
import '../provider/theme_provider.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      width: 500,
      height: 160,
      child: Stack(
        children: [
          Positioned.fill(
            top: 50,
            left: -80,
            child: Align(
              alignment: Alignment.topCenter,
              child: Transform.rotate(
                angle: 0.5,
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 10.0,
                    sigmaY: 10.0,
                  ),
                  child: Opacity(
                    opacity: Provider.of<ThemeProvider>(context, listen: false)
                                .themeData ==
                            lightMode
                        ? 0.9
                        : 0.6,
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Provider.of<ThemeProvider>(context, listen: false)
                                          .themeData ==
                                      lightMode
                                  ? Colors.white
                                  : const Color.fromARGB(255, 219, 218, 218),
                              const Color.fromARGB(255, 232, 231, 231),
                              Provider.of<ThemeProvider>(context, listen: false)
                                          .themeData ==
                                      lightMode
                                  ? const Color.fromARGB(255, 205, 200, 200)
                                  : const Color.fromARGB(255, 232, 231, 231),
                              Provider.of<ThemeProvider>(context, listen: false)
                                          .themeData ==
                                      lightMode
                                  ? const Color.fromARGB(255, 205, 200, 200)
                                  : const Color.fromARGB(255, 232, 231, 231),
                              Provider.of<ThemeProvider>(context, listen: false)
                                          .themeData ==
                                      lightMode
                                  ? const Color.fromARGB(255, 205, 200, 200)
                                  : const Color.fromARGB(255, 219, 218, 218)
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Provider.of<ThemeProvider>(context,
                                            listen: false)
                                        .themeData ==
                                    lightMode
                                ? const Color.fromARGB(255, 209, 203, 203)
                                : const Color.fromARGB(255, 236, 233, 233),
                            blurRadius: 15,
                            offset: const Offset(6, 6),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          Positioned.fill(
            top: 50,
            right: -25,

            // Position this next to the first container
            child: Align(
              alignment: Alignment.topCenter,
              child: Transform.rotate(
                angle:
                    0.5, // Adjust the angle for tilting the container (radians)

                child: Opacity(
                  opacity: Provider.of<ThemeProvider>(context, listen: false)
                              .themeData ==
                          lightMode
                      ? 1
                      : 0.6,
                  child: Container(
                    color: const Color.fromARGB(255, 209, 206, 206),
                    height: 5,
                    width: double.maxFinite,
                  ),
                ),
              ),
            ),
          ),

          // Second tilted container (next to the previous one)

          // Foreground content (higher z-index)
          Row(
            children: [
              const SizedBox(width: 10), // Add spacing to the left
              Expanded(
                child: Image.asset(
                  "assets/app_icon.png",
                  height: 140,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Welcome to Aladia,",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      width: 160,
                      child: Text(
                        "Create or access your account from here",
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

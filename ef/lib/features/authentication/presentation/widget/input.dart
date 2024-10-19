import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/theme.dart';
import '../provider/theme_provider.dart';

class Input extends StatefulWidget {
  final TextEditingController controller;
  final Icon icon;
  final String text;
  final bool obscure;

  const Input(
      {super.key,
      required this.controller,
      required this.icon,
      required this.text,
      required this.obscure});

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        label: Row(
          children: [
            widget.icon,
            const SizedBox(
              width: 10,
            ),
            Text(
              widget.text,
              style: const TextStyle(
                  color: Color.fromARGB(255, 83, 83, 83),
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide:
              BorderSide.none, // Remove the border for the focused state
        ),

        fillColor: Theme.of(context)
            .colorScheme
            .tertiary, // Set background color to light grey
        filled: true,
      ),
      style: TextStyle(
        color: Provider.of<ThemeProvider>(context, listen: false).themeData ==
                lightMode
            ? Colors.white
            : Colors.black,
      ), // Change text color to white
      cursorColor:
          Provider.of<ThemeProvider>(context, listen: false).themeData ==
                  lightMode
              ? Colors.white
              : Colors.black,
    );
  }
}

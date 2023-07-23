import 'package:flutter/material.dart';

class ButtonOption extends StatelessWidget {
  ButtonOption(
      {required this.option, required this.color, required this.onPressed});
  final String option;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            option,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

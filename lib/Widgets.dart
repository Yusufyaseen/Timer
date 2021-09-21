import 'package:flutter/material.dart';

class ProductivityButton extends StatelessWidget {
  final Color color;
  final String text;
  final VoidCallback onPressed;
  ProductivityButton({
    @required this.color,
    @required this.text,
    @required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(0, 40),
        primary: this.color,
        onPrimary: Colors.white,
      ),
      child: Text(
        this.text,
      ),
      onPressed: this.onPressed,
    );
  }
}

class SettingsButton extends StatelessWidget {
  final Color color;
  final String text;
  final String settings;
  final int value;
  final Function callback;
  SettingsButton(
      this.color, this.text, this.value, this.settings, this.callback);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: this.color,
        onPrimary: Colors.white,
      ),
      child: Text(
        this.text,
        style: TextStyle(fontSize: 17),
      ),
      onPressed: () => this.callback(this.settings, this.value),
    );
  }
}

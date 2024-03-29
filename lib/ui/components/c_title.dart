import 'package:flutter/material.dart';

class CTitle extends StatelessWidget {
  const CTitle(this.title);
  
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          fontSize: 26.0, fontWeight: FontWeight.bold, fontFamily: 'Oswald'),
    );
  }
}

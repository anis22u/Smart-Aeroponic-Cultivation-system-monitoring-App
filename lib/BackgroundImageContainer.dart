import 'package:flutter/material.dart';

class BackgroundImageContainer extends StatelessWidget {
  final Widget child;
  const BackgroundImageContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/back.jpg"), // Replace with your image path
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}

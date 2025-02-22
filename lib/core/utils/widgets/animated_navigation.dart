import 'package:flutter/material.dart';

class AnimatedNavigation {
  static void navigateWithSlide(BuildContext context, Widget page,
      {Duration duration = const Duration(milliseconds: 600)}) {
    Navigator.of(context).push(PageRouteBuilder(
      transitionDuration: duration, // Set the duration here
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(-1.0, 0.0); // Start from the right
        const end = Offset.zero; // End at the center
        const curve = Curves.easeInOut;

        var tween = Tween<Offset>(begin: begin, end: end)
            .chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    ));
  }
}

import 'package:flutter/material.dart';

class CynxPageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  CynxPageRoute({
    required this.page,
  }) : super(
          transitionDuration:
              const Duration(milliseconds: 450),
          reverseTransitionDuration:
              const Duration(milliseconds: 350),
          pageBuilder: (
            context,
            animation,
            secondaryAnimation,
          ) {
            return page;
          },
          transitionsBuilder: (
            context,
            animation,
            secondaryAnimation,
            child,
          ) {
            final curvedAnimation =
                CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
              reverseCurve: Curves.easeInCubic,
            );

            final slideAnimation =
                Tween<Offset>(
              begin: const Offset(0.06, 0),
              end: Offset.zero,
            ).animate(curvedAnimation);

            return FadeTransition(
              opacity: curvedAnimation,
              child: SlideTransition(
                position: slideAnimation,
                child: child,
              ),
            );
          },
        );
}
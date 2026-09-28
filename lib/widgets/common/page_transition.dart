import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class CynxPageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  CynxPageRoute({
    required this.page,
  }) : super(
          transitionDuration:
              const Duration(milliseconds: 450),

          reverseTransitionDuration:
              const Duration(milliseconds: 350),

          // Keep the route itself dark so there is
          // never a white frame during the transition.
          opaque: true,

          pageBuilder: (
            context,
            animation,
            secondaryAnimation,
          ) {
            return ColoredBox(
              color: AppColors.background,
              child: page,
            );
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
            ).animate(
              curvedAnimation,
            );

            return ColoredBox(
              color: AppColors.background,
              child: FadeTransition(
                opacity: curvedAnimation,
                child: SlideTransition(
                  position: slideAnimation,
                  child: child,
                ),
              ),
            );
          },
        );
}
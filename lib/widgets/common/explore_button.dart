import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class ExploreButton extends StatefulWidget {
  const ExploreButton({super.key});

  @override
  State<ExploreButton> createState() => _ExploreButtonState();
}

class _ExploreButtonState extends State<ExploreButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,

      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },

      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),

        width: 285,
        height: 42,

        decoration: BoxDecoration(
          color: isHovered
              ? AppColors.primary
              : Colors.transparent,

          border: Border.all(
            color: AppColors.primary,
            width: 1.5,
          ),

          borderRadius: BorderRadius.circular(25),
        ),

        child: const Center(
          child: Text(
            'EXPLORE THE SYNC',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}
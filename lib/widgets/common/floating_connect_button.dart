import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class FloatingConnectButton extends StatefulWidget {
  final VoidCallback onPressed;

  const FloatingConnectButton({
    super.key,
    required this.onPressed,
  });

  @override
  State<FloatingConnectButton> createState() =>
      _FloatingConnectButtonState();
}

class _FloatingConnectButtonState
    extends State<FloatingConnectButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedScale(
          scale: _isHovered ? 1.05 : 1.0,
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOutCubic,
            width: 142,
            height: 52,
            decoration: BoxDecoration(
              color: _isHovered
                  ? AppColors.primary.withValues(alpha: 0.92)
                  : AppColors.primary,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(
                    alpha: _isHovered ? 0.42 : 0.28,
                  ),
                  blurRadius: _isHovered ? 26 : 20,
                  spreadRadius: _isHovered ? 2 : 0,
                ),
              ],
            ),
            child: const Center(
              child: Text(
                "Let's talk →",
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.1,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
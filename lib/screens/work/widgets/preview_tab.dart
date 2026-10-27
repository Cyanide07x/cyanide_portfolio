import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';

class PreviewTab extends StatefulWidget {
  final String title;
  final bool isActive;
  final double height;
  final bool isMobile;
  final VoidCallback onTap;

  const PreviewTab({
    super.key,
    required this.title,
    required this.isActive,
    required this.height,
    required this.isMobile,
    required this.onTap,
  });

  @override
  State<PreviewTab> createState() => _PreviewTabState();
}

class _PreviewTabState extends State<PreviewTab> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final bool active = widget.isActive;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        if (!widget.isMobile) {
          setState(() {
            _hovered = true;
          });
        }
      },
      onExit: (_) {
        if (!widget.isMobile) {
          setState(() {
            _hovered = false;
          });
        }
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          height: widget.height,
          decoration: BoxDecoration(
            color: active
                ? AppColors.primary.withValues(
                    alpha: _hovered ? 0.28 : 0.18,
                  )
                : _hovered
                    ? const Color(0xFF181114)
                    : const Color(0xFF100B0D),
            border: Border.all(
              color: active
                  ? AppColors.primary
                  : _hovered
                      ? AppColors.primary.withValues(alpha: 0.35)
                      : AppColors.white.withValues(alpha: 0.10),
            ),
            borderRadius: BorderRadius.circular(
              widget.isMobile ? 8 : 10,
            ),
          ),
          child: Center(
            child: Text(
              widget.title,
              style: TextStyle(
                color: active
                    ? AppColors.white
                    : _hovered
                        ? AppColors.white
                        : AppColors.mutedDark,
                fontSize: widget.isMobile ? 12 : 13,
                fontWeight: active ? FontWeight.w700 : FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

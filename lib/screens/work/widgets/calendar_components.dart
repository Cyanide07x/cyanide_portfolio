import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';

class WeekDay extends StatelessWidget {
  final String label;

  const WeekDay({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: Color(0xFF555055),
            fontSize: 9,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class MonthButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isMobile;

  const MonthButton({
    super.key,
    required this.icon,
    required this.onTap,
    required this.isMobile,
  });

  @override
  State<MonthButton> createState() => _MonthButtonState();
}

class _MonthButtonState extends State<MonthButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
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
          duration: const Duration(milliseconds: 140),
          width: widget.isMobile ? 24 : 28,
          height: widget.isMobile ? 24 : 28,
          decoration: BoxDecoration(
            color: _hovered
                ? AppColors.primary.withValues(alpha: 0.18)
                : const Color(0xFF0D0D0D),
            border: Border.all(
              color: _hovered
                  ? AppColors.primary.withValues(alpha: 0.45)
                  : AppColors.white.withValues(alpha: 0.08),
            ),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(
            widget.icon,
            color: AppColors.mutedDark,
            size: widget.isMobile ? 14 : 16,
          ),
        ),
      ),
    );
  }
}

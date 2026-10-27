import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';

class TechTag extends StatelessWidget {
  final String text;

  const TechTag({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.white.withValues(
            alpha: 0.10,
          ),
        ),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.white,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

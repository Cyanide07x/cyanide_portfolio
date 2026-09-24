import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../theme/app_colors.dart';
import '../../widgets/common/explore_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {

  // =========================================================
  // POSITION SETTINGS
  // Change these values to move the elements
  // =========================================================

  // LOGO POSITION
  static const double logoX = 0;
  static const double logoY = -60;

  // CORNER DESIGN POSITION
  static const double cornerRight = -40;
  static const double cornerBottom = -80;

  // EXPLORE BUTTON POSITION
  static const double buttonX = 0;
  static const double buttonY = 260;

  // =========================================================
  // ANIMATIONS
  // =========================================================

  late AnimationController _controller;

  late Animation<double> _logoScaleAnimation;
  late Animation<double> _cornerRightAnimation;
  late Animation<double> _cornerBottomAnimation;

  @override
  void initState() {
    super.initState();

    // =======================================================
    // MAIN ANIMATION CONTROLLER
    // =======================================================

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    // =======================================================
    // LOGO ZOOM-IN
    // =======================================================

    _logoScaleAnimation = Tween<double>(
      begin: 0.2,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.0,
          0.7,
          curve: Curves.easeOutCubic,
        ),
      ),
    );

    // =======================================================
    // CORNER DESIGN - START FROM BOTTOM RIGHT
    // =======================================================

    _cornerRightAnimation = Tween<double>(
      begin: -300,
      end: cornerRight,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.25,
          1.0,
          curve: Curves.easeOutCubic,
        ),
      ),
    );

    _cornerBottomAnimation = Tween<double>(
      begin: -350,
      end: cornerBottom,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.25,
          1.0,
          curve: Curves.easeOutCubic,
        ),
      ),
    );

    // START ANIMATION
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: Stack(
        children: [

          // ===================================================
          // CORNER POLYGONS
          // ===================================================

          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Positioned(
                right: _cornerRightAnimation.value,
                bottom: _cornerBottomAnimation.value,
                child: child!,
              );
            },
            child: SvgPicture.asset(
              'assets/images/logos/corner_decorations.svg',
              width: 300,
            ),
          ),

          // ===================================================
          // CYNX LOGO + TAGLINE
          // ===================================================

          AnimatedBuilder(
            animation: _logoScaleAnimation,
            builder: (context, child) {
              return Center(
                child: Transform.translate(
                  offset: const Offset(
                    logoX,
                    logoY,
                  ),
                  child: Transform.scale(
                    scale: _logoScaleAnimation.value,
                    child: child,
                  ),
                ),
              );
            },
            child: SvgPicture.asset(
              'assets/images/logos/cynx_logo.svg',
              width: 600,
            ),
          ),

          // ===================================================
          // EXPLORE BUTTON
          // ===================================================

          Center(
            child: Transform.translate(
              offset: const Offset(
                buttonX,
                buttonY,
              ),
              child: const ExploreButton(),
            ),
          ),
        ],
      ),
    );
  }
}
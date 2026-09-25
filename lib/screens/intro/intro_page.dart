import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../theme/app_colors.dart';
import '../../widgets/common/explore_button.dart';
import '../home/home_page.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage>
    with SingleTickerProviderStateMixin {

  // =========================================================
  // DESKTOP POSITION SETTINGS
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
  // MOBILE POSITION SETTINGS
  // =========================================================

  // LOGO POSITION
  static const double mobileLogoX = 0;
  static const double mobileLogoY = -30;

  // CORNER DESIGN POSITION
  static const double mobileCornerRight = -25;
  static const double mobileCornerBottom = -30;

  // EXPLORE BUTTON POSITION
  static const double mobileButtonX = 0;
  static const double mobileButtonY = 190;

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
    // CORNER DESIGN - RIGHT
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

    // =======================================================
    // CORNER DESIGN - BOTTOM
    // =======================================================

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
    return LayoutBuilder(
      builder: (context, constraints) {

        final double screenWidth = constraints.maxWidth;

        // =====================================================
        // RESPONSIVE BREAKPOINT
        // =====================================================

        final bool isMobile = screenWidth < 600;

        // =====================================================
        // RESPONSIVE LOGO SIZE
        // =====================================================

        final double logoWidth = isMobile
            ? screenWidth * 0.88
            : 600;

        // =====================================================
        // RESPONSIVE CORNER SIZE
        // =====================================================

        final double cornerWidth = isMobile
            ? screenWidth * 0.60
            : 300;

        // =====================================================
        // RESPONSIVE POSITIONS
        // =====================================================

        final double currentLogoX =
            isMobile ? mobileLogoX : logoX;

        final double currentLogoY =
            isMobile ? mobileLogoY : logoY;

        final double currentCornerRight =
            isMobile ? mobileCornerRight : cornerRight;

        final double currentCornerBottom =
            isMobile ? mobileCornerBottom : cornerBottom;

        final double currentButtonX =
            isMobile ? mobileButtonX : buttonX;

        final double currentButtonY =
            isMobile ? mobileButtonY : buttonY;

        return Scaffold(
          backgroundColor: AppColors.background,

          body: Stack(
            children: [

              // =================================================
              // CORNER POLYGONS
              // =================================================

              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Positioned(
                    right: _cornerRightAnimation.value +
                        (currentCornerRight - cornerRight),
                    bottom: _cornerBottomAnimation.value +
                        (currentCornerBottom - cornerBottom),
                    child: child!,
                  );
                },
                child: SvgPicture.asset(
                  'assets/images/logos/corner_decorations.svg',
                  width: cornerWidth,
                ),
              ),

              // =================================================
              // CYNX LOGO + TAGLINE
              // =================================================

              AnimatedBuilder(
                animation: _logoScaleAnimation,
                builder: (context, child) {
                  return Center(
                    child: Transform.translate(
                      offset: Offset(
                        currentLogoX,
                        currentLogoY,
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
                  width: logoWidth,
                ),
              ),

              // =================================================
              // EXPLORE BUTTON
              // =================================================

              Center(
                child: Transform.translate(
                  offset: Offset(
                    currentButtonX,
                    currentButtonY,
                  ),
                  child: Transform.scale(
                    scale: isMobile ? 0.82 : 1.0,
                    child: GestureDetector(
                      onTap: () {
                       Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
            ),
          );
        },
                      child: const ExploreButton(),
                  ),
                ),
              ),
              ),
            ],
          ),
        );
      },
    );
  }
}
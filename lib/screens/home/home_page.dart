import 'dart:async';

import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../widgets/common/portfolio_header.dart';
import '../../widgets/common/portfolio_footer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final String _fullText =
      'Design and code, out of phase on purpose.';

  String _displayedText = '';

  Timer? _typingTimer;

  int _currentIndex = 0;

  late AnimationController _cursorController;

  @override
  void initState() {
    super.initState();

    _startTypingAnimation();

    // Cursor blinking animation
    _cursorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
  }

  // =========================
  // TYPING ANIMATION
  // =========================

  void _startTypingAnimation() {
    _typingTimer = Timer.periodic(
      const Duration(milliseconds: 55),
      (timer) {
        if (_currentIndex < _fullText.length) {
          setState(() {
            _displayedText =
                _fullText.substring(0, _currentIndex + 1);

            _currentIndex++;
          });
        } else {
          timer.cancel();
        }
      },
    );
  }

  @override
  void dispose() {
    _typingTimer?.cancel();
    _cursorController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const PortfolioHeader(
            activePage: 'Home',
          ),

          Expanded(
            child: SingleChildScrollView(
              child: _buildIntroSection(context),
            ),
          ),

          const PortfolioFooter(),
        ],
      ),
    );
  }

  // =========================
  // INTRO / HERO SECTION
  // =========================

  Widget _buildIntroSection(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 700;

        return Padding(
          padding: EdgeInsets.only(
            left: isMobile ? 24 : 40,
            right: isMobile ? 24 : 40,
            top: isMobile ? 55 : 58,
            bottom: isMobile ? 70 : 90,
          ),
          child: Align(
            alignment: Alignment.center,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isMobile ? 600 : 1200,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // =========================
                  // LABEL
                  // =========================

                  Text(
                    '# What we do',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: isMobile ? 16 : 18,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.2,
                    ),
                  ),

                  SizedBox(
                    height: isMobile ? 24 : 26,
                  ),

                  // =========================
                  // TYPING HEADING
                  // =========================

                  AnimatedBuilder(
                    animation: _cursorController,
                    builder: (context, child) {
                      final double opacity =
                          _cursorController.value;

                      return RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: _displayedText,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: isMobile ? 30 : 38,
                                height: 1.12,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.5,
                              ),
                            ),

                            // Blinking cursor
                            TextSpan(
                              text: '|',
                              style: TextStyle(
                                color: AppColors.primary
                                    .withValues(alpha: opacity),
                                fontSize: isMobile ? 30 : 38,
                                height: 1.12,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  SizedBox(
                    height: isMobile ? 24 : 26,
                  ),

                  // =========================
                  // DESCRIPTION
                  // =========================

                  Text(
                    "I'm a Flutter developer working under the name CYNX — "
                    "just starting out, building cross-platform apps with "
                    "an eye for product design and brand. I like projects "
                    "where something is misaligned and there's room to "
                    "bring it back into sync.",
                    style: TextStyle(
                      color: const Color(0xFFB0A8AC),
                      fontSize: isMobile ? 17 : 21,
                      height: 1.55,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
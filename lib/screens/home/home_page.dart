import 'dart:async';

import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../widgets/common/portfolio_header.dart';
import '../../widgets/common/portfolio_footer.dart';
import '../../widgets/common/reactive_polygon.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  // =========================
  // MOUSE POSITION
  // =========================

  Offset? _mousePosition;

  // =========================
  // TYPING TEXT
  // =========================

  final String _fullText =
      'Design and code, out of phase on purpose.';

  String _displayedText = '';

  Timer? _typingTimer;

  int _currentIndex = 0;

  // =========================
  // CURSOR ANIMATION
  // =========================

  late AnimationController _cursorController;

  @override
  void initState() {
    super.initState();

    _startTypingAnimation();

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

  // =========================
  // BUILD
  // =========================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // =========================
          // HEADER
          // =========================

          const PortfolioHeader(
            activePage: 'Home',
          ),

          // =========================
          // PAGE CONTENT
          // =========================

          Expanded(
            child: SingleChildScrollView(
              child: _buildIntroSection(context),
            ),
          ),

          // =========================
          // FOOTER
          // =========================

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
        final double width = constraints.maxWidth;

        // =========================
        // RESPONSIVE BREAKPOINTS
        // =========================

        final bool isMobile = width < 700;

        final bool isTablet =
            width >= 700 && width < 1100;

        // =========================
        // RESPONSIVE PADDING
        // =========================

        final double horizontalPadding = isMobile
            ? 24
            : isTablet
                ? 32
                : 40;

        // =========================
        // POLYGON SIZE
        // =========================

        final double polygonSize = isMobile
            ? 150
            : isTablet
                ? 240
                : 340;

        // =========================
        // POLYGON POSITION
        // =========================

        final double polygonRight = isMobile
            ? -10
            : isTablet
                ? -20
                : -40;

        final double polygonTop = isMobile
            ? 0
            : isTablet
                ? 50
                : 80;

        // =========================
        // TEXT POSITION
        // =========================

        final double textTopPadding = isMobile
            ? 150
            : isTablet
                ? 50
                : 58;

        // =========================
        // FONT SIZES
        // =========================

        final double headingSize = isMobile
            ? 30
            : isTablet
                ? 34
                : 38;

        final double descriptionSize = isMobile
            ? 17
            : isTablet
                ? 19
                : 21;

        // The actual width of the Stack after
        // horizontal padding.
        final double interactionWidth =
            width - (horizontalPadding * 2);

        // Approximate interaction height.
        // This is only used to calculate the
        // direction of polygon movement.
        final double interactionHeight =
            isMobile ? 500 : 400;

        // Keep polygon centered when the mouse
        // hasn't entered the hero yet.
        final Offset currentMousePosition =
            _mousePosition ??
                Offset(
                  interactionWidth / 2,
                  interactionHeight / 2,
                );

        return SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(
              left: horizontalPadding,
              right: horizontalPadding,
              top: textTopPadding,
              bottom: isMobile ? 70 : 90,
            ),
            child: MouseRegion(
              cursor: SystemMouseCursors.basic,

              // =========================
              // MOUSE TRACKING
              // =========================

              onHover: (event) {
                setState(() {
                  _mousePosition = event.localPosition;
                });
              },

              onExit: (_) {
                setState(() {
                  _mousePosition = null;
                });
              },

              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // =====================================================
                  // REACTIVE POLYGON
                  // =====================================================

                  Positioned(
                    right: polygonRight,
                    top: polygonTop,
                    child: IgnorePointer(
                      child: SizedBox(
                        width: polygonSize,
                        height: polygonSize,
                        child: ReactivePolygon(
                          mousePosition: currentMousePosition,
                          areaSize: Size(
                            interactionWidth,
                            interactionHeight,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // =====================================================
                  // TEXT CONTENT
                  // =====================================================

                  Align(
                    alignment: Alignment.centerLeft,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: isMobile
                            ? double.infinity
                            : isTablet
                                ? width * 0.90
                                : 1200,
                      ),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          // =========================
                          // LABEL
                          // =========================

                          Text(
                            '# What we do',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize:
                                  isMobile ? 16 : 18,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.2,
                            ),
                          ),

                          SizedBox(
                            height:
                                isMobile ? 22 : 26,
                          ),

                          // =========================
                          // TYPING HEADING
                          // =========================

                          AnimatedBuilder(
                            animation:
                                _cursorController,
                            builder:
                                (context, child) {
                              final double opacity =
                                  _cursorController.value;

                              return RichText(
                                text: TextSpan(
                                  children: [
                                    // Typed text
                                    TextSpan(
                                      text:
                                          _displayedText,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            headingSize,
                                        height: 1.12,
                                        fontWeight:
                                            FontWeight.w800,
                                        letterSpacing:
                                            -0.5,
                                      ),
                                    ),

                                    // Blinking cursor
                                    TextSpan(
                                      text: '|',
                                      style: TextStyle(
                                        color: AppColors
                                            .primary
                                            .withValues(
                                          alpha: opacity,
                                        ),
                                        fontSize:
                                            headingSize,
                                        height: 1.12,
                                        fontWeight:
                                            FontWeight.w800,
                                        letterSpacing:
                                            -0.5,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),

                          SizedBox(
                            height:
                                isMobile ? 22 : 26,
                          ),

                          // =========================
                          // DESCRIPTION
                          // =========================

                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: isMobile
                                  ? double.infinity
                                  : isTablet
                                      ? width * 0.82
                                      : 1100,
                            ),
                            child: Text(
                              "I'm a Flutter developer working "
                              "under the name CYNX — just "
                              "starting out, building "
                              "cross-platform apps with an eye "
                              "for product design and brand. "
                              "I like projects where something "
                              "is misaligned and there's room "
                              "to bring it back into sync.",
                              style: TextStyle(
                                color:
                                    const Color(0xFFB0A8AC),
                                fontSize:
                                    descriptionSize,
                                height: 1.55,
                                fontWeight:
                                    FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
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
import 'dart:async';

import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../widgets/common/portfolio_footer.dart';
import '../../widgets/common/portfolio_header.dart';
import '../../widgets/common/reactive_polygon.dart';

class HomePage extends StatelessWidget {
  final bool showHeader;
  final bool embedded;

  const HomePage({
    super.key,
    this.showHeader = true,
    this.embedded = false,
  });

  @override
  Widget build(BuildContext context) {
    // PortfolioShell owns scrolling, header and footer.
    if (embedded) {
      return _buildIntroSection(context);
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          if (showHeader) const PortfolioHeader(activePage: 'Home'),
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
        final double width = constraints.maxWidth;

        // =========================
        // RESPONSIVE BREAKPOINTS
        // =========================

        final bool isMobile = width < 700;
        final bool isTablet = width >= 700 && width < 1100;

        // =========================
        // RESPONSIVE PADDING
        // =========================

        final double horizontalPadding = isMobile
            ? 24
            : isTablet
                ? 50
                : 90;

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
            ? 36
            : isTablet
                ? 48
                : 58;

        final double descriptionSize = isMobile ? 17 : 18;

        // The actual width of the Stack after horizontal padding.
        final double interactionWidth = width - (horizontalPadding * 2);

        // Approximate interaction height.
        final double interactionHeight = isMobile ? 500 : 400;

        return SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(
              left: horizontalPadding,
              right: horizontalPadding,
              top: textTopPadding,
              bottom: isMobile ? 70 : 90,
            ),
            child: _HomeHeroPointerLayer(
              polygonSize: polygonSize,
              polygonRight: polygonRight,
              polygonTop: polygonTop,
              interactionWidth: interactionWidth,
              interactionHeight: interactionHeight,
              child: Align(
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // =========================
                      // LABEL
                      // =========================
                      const Text(
                        '# What we do',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.5,
                        ),
                      ),

                      SizedBox(
                        height: isMobile ? 22 : 26,
                      ),

                      // =========================
                      // TYPING HEADING
                      // =========================
                      _HomeTypingHeading(
                        headingSize: headingSize,
                      ),

                      SizedBox(
                        height: isMobile ? 22 : 26,
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
                            color: AppColors.muted,
                            fontSize: descriptionSize,
                            height: 1.7,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// =========================
// HERO POINTER LAYER
// =========================

class _HomeHeroPointerLayer extends StatefulWidget {
  final double polygonSize;
  final double polygonRight;
  final double polygonTop;
  final double interactionWidth;
  final double interactionHeight;
  final Widget child;

  const _HomeHeroPointerLayer({
    required this.polygonSize,
    required this.polygonRight,
    required this.polygonTop,
    required this.interactionWidth,
    required this.interactionHeight,
    required this.child,
  });

  @override
  State<_HomeHeroPointerLayer> createState() => _HomeHeroPointerLayerState();
}

class _HomeHeroPointerLayerState extends State<_HomeHeroPointerLayer> {
  late final ValueNotifier<Offset?> _mousePositionNotifier;

  @override
  void initState() {
    super.initState();
    _mousePositionNotifier = ValueNotifier<Offset?>(null);
  }

  @override
  void dispose() {
    _mousePositionNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Offset defaultMousePosition = Offset(
      widget.interactionWidth / 2,
      widget.interactionHeight / 2,
    );

    return MouseRegion(
      cursor: SystemMouseCursors.basic,
      onHover: (event) {
        _mousePositionNotifier.value = event.localPosition;
      },
      onExit: (_) {
        _mousePositionNotifier.value = null;
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // =====================================================
          // REACTIVE POLYGON
          // =====================================================
          Positioned(
            right: widget.polygonRight,
            top: widget.polygonTop,
            child: IgnorePointer(
              child: SizedBox(
                width: widget.polygonSize,
                height: widget.polygonSize,
                child: ValueListenableBuilder<Offset?>(
                  valueListenable: _mousePositionNotifier,
                  builder: (context, mousePosition, _) {
                    return ReactivePolygon(
                      mousePosition: mousePosition ?? defaultMousePosition,
                      areaSize: Size(
                        widget.interactionWidth,
                        widget.interactionHeight,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          // =====================================================
          // TEXT CONTENT (Isolated from hover rebuilds)
          // =====================================================
          widget.child,
        ],
      ),
    );
  }
}

// =========================
// TYPING HEADING
// =========================

class _HomeTypingHeading extends StatefulWidget {
  final double headingSize;

  const _HomeTypingHeading({
    required this.headingSize,
  });

  @override
  State<_HomeTypingHeading> createState() => _HomeTypingHeadingState();
}

class _HomeTypingHeadingState extends State<_HomeTypingHeading> {
  final String _fullText = 'Design and code, out of phase on purpose.';

  String _displayedText = '';
  Timer? _typingTimer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _startTypingAnimation();
  }

  void _startTypingAnimation() {
    _typingTimer = Timer.periodic(
      const Duration(milliseconds: 55),
      (timer) {
        if (_currentIndex < _fullText.length) {
          setState(() {
            _displayedText = _fullText.substring(0, _currentIndex + 1);
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          // Typed text
          TextSpan(
            text: _displayedText,
            style: TextStyle(
              color: AppColors.white,
              fontSize: widget.headingSize,
              height: 1.05,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),

          // Blinking cursor isolated in its own widget
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: _BlinkingCursor(
              headingSize: widget.headingSize,
            ),
          ),
        ],
      ),
    );
  }
}

// =========================
// BLINKING CURSOR
// =========================

class _BlinkingCursor extends StatefulWidget {
  final double headingSize;

  const _BlinkingCursor({
    required this.headingSize,
  });

  @override
  State<_BlinkingCursor> createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<_BlinkingCursor>
    with SingleTickerProviderStateMixin {
  late final AnimationController _cursorController;

  @override
  void initState() {
    super.initState();
    _cursorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _cursorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _cursorController,
      builder: (context, _) {
        return Text(
          '|',
          style: TextStyle(
            color: AppColors.primary.withValues(
              alpha: _cursorController.value,
            ),
            fontSize: widget.headingSize,
            height: 1.05,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        );
      },
    );
  }
}

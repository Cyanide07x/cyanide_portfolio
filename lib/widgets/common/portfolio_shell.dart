
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../screens/home/home_page.dart';
import '../../screens/work/work_page.dart';
import '../../screens/about/about_page.dart';
import '../../screens/contact/contact_page.dart';
import 'portfolio_header.dart';
import 'floating_connect_button.dart';
import 'portfolio_footer.dart';

class PortfolioShell extends StatefulWidget {
  final String initialPage;

  const PortfolioShell({
    super.key,
    this.initialPage = 'Home',
  });

  @override
  State<PortfolioShell> createState() => _PortfolioShellState();
}

class _PortfolioShellState extends State<PortfolioShell> {
  final ScrollController _scrollController = ScrollController();

  final Map<String, GlobalKey> _sectionKeys = {
    'Home': GlobalKey(),
    'Work': GlobalKey(),
    'About': GlobalKey(),
    'Contact': GlobalKey(),
  };

  static const List<String> _pages = [
    'Home',
    'Work',
    'About',
    'Contact',
  ];

  // Adjust these values to tune the layout.
  static const double _headerOffset = 120;
  static const double _sectionSpacing = 230;
  static const double _footerHideThreshold = 140;

  late String _activePage;
  bool _showFloatingButton = true;
  bool _isAnimatingToSection = false;

  @override
  void initState() {
    super.initState();

    _activePage = _pages.contains(widget.initialPage)
        ? widget.initialPage
        : 'Home';

    _scrollController.addListener(_handleScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _activePage != 'Home') {
        _changePage(_activePage);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    if (!_scrollController.hasClients) return;

    final position = _scrollController.position;
    final remaining =
        position.maxScrollExtent - position.pixels;

    String visiblePage = 'Home';

    for (final page in _pages) {
      final sectionContext = _sectionKeys[page]?.currentContext;

      if (sectionContext == null) continue;

      final renderObject = sectionContext.findRenderObject();

      if (renderObject is! RenderBox || !renderObject.hasSize) {
        continue;
      }

      final top = renderObject.localToGlobal(Offset.zero).dy;

      if (top <= _headerOffset) {
        visiblePage = page;
      }
    }

    // Avoid updating the header repeatedly while navigating
    // programmatically. The scroll position still updates normally.
    if (_isAnimatingToSection) {
      final shouldShowDuringAnimation =
          remaining > _footerHideThreshold &&
          _activePage != 'Contact';

      if (shouldShowDuringAnimation != _showFloatingButton) {
        setState(() {
          _showFloatingButton = shouldShowDuringAnimation;
        });
      }
      return;
    }

    final shouldShow =
        remaining > _footerHideThreshold &&
        visiblePage != 'Contact';

    if (visiblePage != _activePage ||
        shouldShow != _showFloatingButton) {
      setState(() {
        _activePage = visiblePage;
        _showFloatingButton = shouldShow;
      });
    }
  }

  Future<void> _changePage(String page) async {
    if (!_scrollController.hasClients) return;

    final sectionContext = _sectionKeys[page]?.currentContext;

    if (sectionContext == null) return;

    if (mounted) {
      setState(() {
        _activePage = page;
        _showFloatingButton = page != 'Contact';
      });
    }

    final renderObject = sectionContext.findRenderObject();

    if (renderObject is! RenderBox || !renderObject.hasSize) {
      return;
    }

    final top = renderObject.localToGlobal(Offset.zero).dy;

    final target = (_scrollController.offset + top - _headerOffset)
        .clamp(
          0.0,
          _scrollController.position.maxScrollExtent,
        );

    _isAnimatingToSection = true;

    try {
      await _scrollController.animateTo(
        target,
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeOutCubic,
      );
    } finally {
      _isAnimatingToSection = false;

      if (mounted) {
        _handleScroll();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.sizeOf(context).width >= 700;

    final shouldDisplayButton =
        isDesktop &&
        _activePage != 'Contact' &&
        _showFloatingButton;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Column(
            children: [
              PortfolioHeader(
                activePage: _activePage,
                onPageChanged: (page) => _changePage(page),
              ),

              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // HOME
                      Container(
                        key: _sectionKeys['Home'],
                        child: const HomePage(
                          embedded: true,
                        ),
                      ),

                      const SizedBox(height: _sectionSpacing),

                      // WORK
                      Container(
                        key: _sectionKeys['Work'],
                        child: const WorkPage(
                          embedded: true,
                        ),
                      ),

                      const SizedBox(height: _sectionSpacing),

                      // ABOUT
                      Container(
                        key: _sectionKeys['About'],
                        child: const AboutPage(
                          embedded: true,
                        ),
                      ),

                      const SizedBox(height: _sectionSpacing),

                      // CONTACT
                      Container(
                        key: _sectionKeys['Contact'],
                        child: const ContactPage(
                          embedded: true,
                        ),
                      ),

                      // One footer at the bottom of the entire page.
                      const PortfolioFooter(),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Floating Connect button (desktop only).
          if (isDesktop)
            Positioned(
              right: 30,
              bottom: 28,
              child: IgnorePointer(
                ignoring: !shouldDisplayButton,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 180),
                  opacity: shouldDisplayButton ? 1.0 : 0.0,
                  child: AnimatedSlide(
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeOutCubic,
                    offset: shouldDisplayButton
                        ? Offset.zero
                        : const Offset(0, 1.5),
                    child: FloatingConnectButton(
                      onPressed: () => _changePage('Contact'),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

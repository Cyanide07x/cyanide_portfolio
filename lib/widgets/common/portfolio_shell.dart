import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../screens/home/home_page.dart';
import '../../screens/work/work_page.dart';
import '../../screens/about/about_page.dart';
import '../../screens/contact/contact_page.dart';
import 'portfolio_header.dart';
import 'floating_connect_button.dart';

class PortfolioShell extends StatefulWidget {
  final String initialPage;

  const PortfolioShell({
    super.key,
    this.initialPage = 'Home',
  });

  @override
  State<PortfolioShell> createState() =>
      _PortfolioShellState();
}

class _PortfolioShellState
    extends State<PortfolioShell> {
  late String _activePage;

  final Map<String, Widget> _pages = {};

  bool _showFloatingButton = true;

  static const double _footerHideThreshold = 140;

  @override
  void initState() {
    super.initState();

    _activePage = widget.initialPage;

    _pages[_activePage] = _createPage(_activePage);
  }

  Widget _createPage(String page) {
    switch (page) {
      case 'Home':
        return const HomePage(
          showHeader: false,
        );

      case 'Work':
        return const WorkPage(
          showHeader: false,
        );

      case 'About':
        return const AboutPage(
          showHeader: false,
        );

      case 'Contact':
        return const ContactPage(
          showHeader: false,
        );

      default:
        return const HomePage(
          showHeader: false,
        );
    }
  }

  void _changePage(String page) {
    if (page == _activePage) {
      return;
    }

    if (!_pages.containsKey(page)) {
      _pages[page] = _createPage(page);
    }

    setState(() {
      _activePage = page;
      _showFloatingButton = true;
    });
  }

  bool _handleScrollNotification(
    ScrollNotification notification,
  ) {
    if (notification.metrics.axis != Axis.vertical) {
      return false;
    }

    final double remaining =
        notification.metrics.maxScrollExtent -
            notification.metrics.pixels;

    final bool shouldShow =
        remaining > _footerHideThreshold;

    if (shouldShow != _showFloatingButton) {
      setState(() {
        _showFloatingButton = shouldShow;
      });
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth =
        MediaQuery.sizeOf(context).width;

    final bool isDesktop =
        screenWidth >= 700;

    final bool shouldDisplayButton =
        isDesktop &&
        _activePage != 'Contact' &&
        _showFloatingButton;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SizedBox.expand(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              children: [
                PortfolioHeader(
                  activePage: _activePage,
                  onPageChanged: _changePage,
                ),

                Expanded(
                  child: NotificationListener<
                      ScrollNotification>(
                    onNotification:
                        _handleScrollNotification,
                    child: _pages[_activePage]!,
                  ),
                ),
              ],
            ),

            if (isDesktop && _activePage != 'Contact')
              Positioned(
                right: 30,

                // Home has a footer visible at the bottom,
                // so keep the floating button above it.
                bottom: _activePage == 'Home'
                    ? 95
                    : 28,

                child: IgnorePointer(
                  ignoring: !shouldDisplayButton,
                  child: AnimatedOpacity(
                    duration:
                        const Duration(milliseconds: 180),
                    opacity:
                        shouldDisplayButton ? 1.0 : 0.0,
                    child: AnimatedSlide(
                      duration:
                          const Duration(milliseconds: 220),
                      curve: Curves.easeOutCubic,
                      offset: shouldDisplayButton
                          ? Offset.zero
                          : const Offset(0, 1.5),
                      child: FloatingConnectButton(
                        onPressed: () {
                          _changePage('Contact');
                        },
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
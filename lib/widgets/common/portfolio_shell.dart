import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../screens/home/home_page.dart';
import '../../screens/work/work_page.dart';
import '../../screens/about/about_page.dart';
import 'portfolio_header.dart';

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

  @override
  void initState() {
    super.initState();

    _activePage = widget.initialPage;

    // Only create the page we actually start on.
    _pages[_activePage] = _createPage(_activePage);
  }

  Widget _createPage(String page) {
    switch (page) {
      case 'Work':
        return const WorkPage(
          showHeader: false,
        );

      case 'About':
        return const AboutPage(
          showHeader: false,
        );

      case 'Home':
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

    // Contact will be connected later.
    if (page == 'Contact') {
      return;
    }

    // Create the page only the first time we visit it.
    if (!_pages.containsKey(page)) {
      _pages[page] = _createPage(page);
    }

    setState(() {
      _activePage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // Fixed portfolio header.
          PortfolioHeader(
            activePage: _activePage,
            onPageChanged: _changePage,
          ),

          // Page content.
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (_pages.containsKey('Home'))
                  Offstage(
                    offstage: _activePage != 'Home',
                    child: TickerMode(
                      enabled: _activePage == 'Home',
                      child: _pages['Home']!,
                    ),
                  ),

                if (_pages.containsKey('Work'))
                  Offstage(
                    offstage: _activePage != 'Work',
                    child: TickerMode(
                      enabled: _activePage == 'Work',
                      child: _pages['Work']!,
                    ),
                  ),

                if (_pages.containsKey('About'))
                  Offstage(
                    offstage: _activePage != 'About',
                    child: TickerMode(
                      enabled: _activePage == 'About',
                      child: _pages['About']!,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
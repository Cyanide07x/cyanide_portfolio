import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../screens/home/home_page.dart';
import '../../screens/work/work_page.dart';
import '../../screens/about/about_page.dart';
import '../../screens/contact/contact_page.dart';
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

    _pages[_activePage] = _createPage(_activePage);
  }

  // =====================================================
  // CREATE PAGE
  // =====================================================

  Widget _createPage(String page) {
    switch (page) {
      // -------------------------------------------------
      // HOME
      // -------------------------------------------------

      case 'Home':
        return const HomePage(
          showHeader: false,
        );

      // -------------------------------------------------
      // WORK
      // -------------------------------------------------

      case 'Work':
        return const WorkPage(
          showHeader: false,
        );

      // -------------------------------------------------
      // ABOUT
      // -------------------------------------------------

      case 'About':
        return const AboutPage(
          showHeader: false,
        );

      // -------------------------------------------------
      // CONTACT
      // -------------------------------------------------

      case 'Contact':
        return const ContactPage(
          showHeader: false,
        );

      // -------------------------------------------------
      // FALLBACK
      // -------------------------------------------------

      default:
        return const HomePage(
          showHeader: false,
        );
    }
  }

  // =====================================================
  // CHANGE PAGE
  // =====================================================

  void _changePage(String page) {
    if (page == _activePage) {
      return;
    }

    // Create the page only when it is opened
    // for the first time.
    if (!_pages.containsKey(page)) {
      _pages[page] = _createPage(page);
    }

    setState(() {
      _activePage = page;
    });
  }

  // =====================================================
  // BUILD
  // =====================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: Column(
        children: [
          // =================================================
          // PERSISTENT HEADER
          // =================================================

          PortfolioHeader(
            activePage: _activePage,
            onPageChanged: _changePage,
          ),

          // =================================================
          // CURRENT PAGE
          // =================================================

          Expanded(
            child: _pages[_activePage]!,
          ),
        ],
      ),
    );
  }
}
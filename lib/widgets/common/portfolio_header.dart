import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../screens/intro/intro_page.dart';
import '../../theme/app_colors.dart';
import '../../screens/work/work_page.dart';
import '../../screens/home/home_page.dart';
import 'page_transition.dart';

class PortfolioHeader extends StatelessWidget {
  final String activePage;

  const PortfolioHeader({
    super.key,
    this.activePage = 'Home',
  });

  // =====================================================
  // GO TO INTRO
  // =====================================================

  void _goToIntro(BuildContext context) {
    Navigator.pushReplacement(
      context,
      CynxPageRoute(
        page: const IntroPage(),
      ),
    );
  }

  // =====================================================
  // MOBILE NAVIGATION
  // =====================================================

  void _handleMobileNavigation(
    BuildContext context,
    String value,
  ) {
    if (value == activePage) {
      return;
    }

    if (value == 'Home') {
      Navigator.pushReplacement(
        context,
        CynxPageRoute(
          page: const HomePage(),
        ),
      );
    } else if (value == 'Work') {
      Navigator.pushReplacement(
        context,
        CynxPageRoute(
          page: const WorkPage(),
        ),
      );
    }

    // About and Contact are intentionally left
    // without navigation until those pages are created.
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 700;

        return Container(
          height: 88,
          decoration: BoxDecoration(
            color: AppColors.background,
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withValues(alpha: 0.08),
                width: 1,
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 22 : 40,
            ),
            child: Row(
              children: [
                // =========================
                // CYNX LOGO
                // =========================

                GestureDetector(
                  onTap: () => _goToIntro(context),
                  child: SvgPicture.asset(
                    'assets/images/logos/cynx_mark.svg',
                    width: isMobile ? 52 : 62,
                  ),
                ),

                const Spacer(),

                // =========================
                // DESKTOP NAVIGATION
                // =========================

                if (!isMobile)
                  Row(
                    children: [
                      _NavItem(
                        title: 'Home',
                        isActive: activePage == 'Home',
                      ),

                      const SizedBox(width: 38),

                      _NavItem(
                        title: 'Work',
                        isActive: activePage == 'Work',
                      ),

                      const SizedBox(width: 38),

                      _NavItem(
                        title: 'About',
                        isActive: activePage == 'About',
                      ),

                      const SizedBox(width: 38),

                      _NavItem(
                        title: 'Contact',
                        isActive: activePage == 'Contact',
                      ),
                    ],
                  ),

                // =========================
                // MOBILE MENU BUTTON
                // =========================

                if (isMobile)
                  PopupMenuButton<String>(
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 28,
                    ),
                    color: const Color(0xFF0A0A0A),
                    offset: const Offset(0, 55),

                    // =========================
                    // MOBILE MENU SELECTION
                    // =========================

                    onSelected: (value) {
                      _handleMobileNavigation(
                        context,
                        value,
                      );
                    },

                    itemBuilder: (context) => [
                      PopupMenuItem<String>(
                        value: 'Home',
                        child: Text(
                          'Home',
                          style: TextStyle(
                            color: activePage == 'Home'
                                ? AppColors.primary
                                : Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ),

                      PopupMenuItem<String>(
                        value: 'Work',
                        child: Text(
                          'Work',
                          style: TextStyle(
                            color: activePage == 'Work'
                                ? AppColors.primary
                                : Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ),

                      PopupMenuItem<String>(
                        value: 'About',
                        child: Text(
                          'About',
                          style: TextStyle(
                            color: activePage == 'About'
                                ? AppColors.primary
                                : Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ),

                      PopupMenuItem<String>(
                        value: 'Contact',
                        child: Text(
                          'Contact',
                          style: TextStyle(
                            color: activePage == 'Contact'
                                ? AppColors.primary
                                : Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// =====================================================
// NAVIGATION ITEM
// =====================================================

class _NavItem extends StatelessWidget {
  final String title;
  final bool isActive;

  const _NavItem({
    required this.title,
    required this.isActive,
  });

  // =====================================================
  // DESKTOP NAVIGATION
  // =====================================================

  void _handleTap(BuildContext context) {
    if (title == 'Home') {
      Navigator.pushReplacement(
        context,
        CynxPageRoute(
          page: const HomePage(),
        ),
      );
    } else if (title == 'Work') {
      Navigator.pushReplacement(
        context,
        CynxPageRoute(
          page: const WorkPage(),
        ),
      );
    }

    // About and Contact are intentionally left
    // without navigation until those pages are created.
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _handleTap(context),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 4,
            bottom: 13,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: isActive
                      ? Colors.white
                      : const Color(0xFF9E9699),
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 12),

              AnimatedContainer(
                duration: const Duration(
                  milliseconds: 200,
                ),
                height: 2,
                width: isActive ? 50 : 0,
                color: AppColors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
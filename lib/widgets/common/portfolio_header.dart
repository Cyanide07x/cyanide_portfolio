import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../screens/intro/intro_page.dart';
import '../../theme/app_colors.dart';
import 'page_transition.dart';

class PortfolioHeader extends StatelessWidget {
  final String activePage;

  // This is used by PortfolioShell.
  // When provided, Home / Work / About will
  // change only the page content.
  final ValueChanged<String>? onPageChanged;

  const PortfolioHeader({
    super.key,
    this.activePage = 'Home',
    this.onPageChanged,
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
    // Don't do anything if already on the selected page.
    if (value == activePage) {
      return;
    }

    // ===================================================
    // SHELL MODE
    // ===================================================
    //
    // When PortfolioHeader is being used inside
    // PortfolioShell, this callback changes only
    // the content below the header.
    //

    if (onPageChanged != null) {
      if (value == 'Home' ||
          value == 'Work' ||
          value == 'About') {
        onPageChanged!(value);
      }

      // Contact will be connected later.
      return;
    }

    // ===================================================
    // NORMAL ROUTE MODE
    // ===================================================
    //
    // Keeps the old navigation behavior for any place
    // where the header is still used outside the shell.
    //

    if (value == 'Home') {
      Navigator.pushReplacement(
        context,
        CynxPageRoute(
          page: const _HomePagePlaceholder(),
        ),
      );
    } else if (value == 'Work') {
      Navigator.pushReplacement(
        context,
        CynxPageRoute(
          page: const _WorkPagePlaceholder(),
        ),
      );
    } else if (value == 'About') {
      Navigator.pushReplacement(
        context,
        CynxPageRoute(
          page: const _AboutPagePlaceholder(),
        ),
      );
    }

    // Contact will be connected
    // when the Contact page is created.
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
                // =====================================================
                // CYNX LOGO
                // =====================================================

                GestureDetector(
                  onTap: () => _goToIntro(context),
                  child: SvgPicture.asset(
                    'assets/images/logos/cynx_mark.svg',
                    width: isMobile ? 52 : 62,
                  ),
                ),

                const Spacer(),

                // =====================================================
                // DESKTOP NAVIGATION
                // =====================================================

                if (!isMobile)
                  Row(
                    children: [
                      _NavItem(
                        title: 'Home',
                        isActive: activePage == 'Home',
                        onTap: () {
                          if (onPageChanged != null) {
                            onPageChanged!('Home');
                          } else {
                            _navigateToHome(context);
                          }
                        },
                      ),

                      const SizedBox(width: 38),

                      _NavItem(
                        title: 'Work',
                        isActive: activePage == 'Work',
                        onTap: () {
                          if (onPageChanged != null) {
                            onPageChanged!('Work');
                          } else {
                            _navigateToWork(context);
                          }
                        },
                      ),

                      const SizedBox(width: 38),

                      _NavItem(
                        title: 'About',
                        isActive: activePage == 'About',
                        onTap: () {
                          if (onPageChanged != null) {
                            onPageChanged!('About');
                          } else {
                            _navigateToAbout(context);
                          }
                        },
                      ),

                      const SizedBox(width: 38),

                      _NavItem(
                        title: 'Contact',
                        isActive: activePage == 'Contact',
                        onTap: () {
                          // Contact will be connected later.
                        },
                      ),
                    ],
                  ),

                // =====================================================
                // MOBILE MENU BUTTON
                // =====================================================

                if (isMobile)
                  PopupMenuButton<String>(
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 28,
                    ),
                    color: const Color(0xFF0A0A0A),
                    offset: const Offset(0, 55),

                    // =================================================
                    // MOBILE MENU SELECTION
                    // =================================================

                    onSelected: (value) {
                      _handleMobileNavigation(
                        context,
                        value,
                      );
                    },

                    // =================================================
                    // MOBILE MENU ITEMS
                    // =================================================

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

  // =====================================================
  // OLD ROUTE NAVIGATION
  // =====================================================

  void _navigateToHome(BuildContext context) {
    Navigator.pushReplacement(
      context,
      CynxPageRoute(
        page: const _HomePagePlaceholder(),
      ),
    );
  }

  void _navigateToWork(BuildContext context) {
    Navigator.pushReplacement(
      context,
      CynxPageRoute(
        page: const _WorkPagePlaceholder(),
      ),
    );
  }

  void _navigateToAbout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      CynxPageRoute(
        page: const _AboutPagePlaceholder(),
      ),
    );
  }
}

// =====================================================
// NAVIGATION ITEM
// =====================================================

class _NavItem extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.title,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
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

// =====================================================
// TEMPORARY PLACEHOLDERS
// =====================================================
//
// These prevent the old route mode from causing import
// conflicts while we move everything into PortfolioShell.
//
// We will remove these once the shell is fully connected.
//

class _HomePagePlaceholder extends StatelessWidget {
  const _HomePagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

class _WorkPagePlaceholder extends StatelessWidget {
  const _WorkPagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

class _AboutPagePlaceholder extends StatelessWidget {
  const _AboutPagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
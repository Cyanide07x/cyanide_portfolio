import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../widgets/common/portfolio_footer.dart';
import '../../widgets/common/portfolio_header.dart';
import 'widgets/calcynx_preview.dart';
import 'widgets/project_polygon_painter.dart';
import 'widgets/tech_tag.dart';

class WorkPage extends StatelessWidget {
  final bool showHeader;
  final bool embedded;

  const WorkPage({
    super.key,
    this.showHeader = true,
    this.embedded = false,
  });

  @override
  Widget build(BuildContext context) {
    if (embedded) {
      return _buildPageContent(context);
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          if (showHeader) const PortfolioHeader(activePage: 'Work'),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildPageContent(context),
                  const PortfolioFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // PAGE CONTENT
  // ================================================================

  Widget _buildPageContent(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        final bool isMobile = width < 700;
        final bool isTablet = width >= 700 && width < 1100;

        final double horizontalPadding = isMobile
            ? 24
            : isTablet
                ? 50
                : 90;

        // HERO
        final Widget heroSection = Padding(
          padding: EdgeInsets.only(
            left: horizontalPadding,
            right: horizontalPadding,
            top: isMobile ? 70 : 68,
            bottom: isMobile ? 65 : 72,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isMobile ? double.infinity : 1000,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '# Work',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: isMobile ? 28 : 35),
                  Text(
                    'One project so far — built end to end.',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: isMobile ? 36 : 58,
                      height: 1.05,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.5,
                    ),
                  ),
                  SizedBox(height: isMobile ? 24 : 35),
                  Text(
                    "I'm early in my career, so this is "
                    "project one: designed, built, and "
                    "shipped by me alone. More is on "
                    "the way.",
                    style: TextStyle(
                      color: AppColors.muted,
                      fontSize: isMobile ? 17 : 18,
                      height: 1.7,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        // FEATURED PROJECT
        final Widget featuredProject = Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: AppColors.white.withValues(alpha: 0.08),
              ),
              bottom: BorderSide(
                color: AppColors.white.withValues(alpha: 0.08),
              ),
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: isMobile ? 55 : 50,
          ),
          child: isMobile
              ? _buildMobileProject()
              : _buildDesktopProject(isTablet),
        );

        // MORE PROJECTS
        final Widget moreProjects = Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: isMobile ? 65 : 75,
          ),
          child: Center(
            child: Text(
              'More projects in progress — check back soon.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.muted,
                fontSize: isMobile ? 16 : 18,
                height: 1.5,
              ),
            ),
          ),
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            heroSection,
            featuredProject,
            moreProjects,
          ],
        );
      },
    );
  }

  // ================================================================
  // DESKTOP / TABLET PROJECT
  // ================================================================

  Widget _buildDesktopProject(bool isTablet) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // POLYGON
        SizedBox(
          width: isTablet ? 140 : 165,
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Transform.translate(
              offset: const Offset(-35, 0),
              child: const CustomPaint(
                size: Size(70, 70),
                painter: ProjectPolygonPainter(),
              ),
            ),
          ),
        ),

        // PROJECT INFORMATION
        Expanded(
          flex: 6,
          child: Padding(
            padding: EdgeInsets.only(
              right: isTablet ? 30 : 70,
            ),
            child: _buildProjectInfo(),
          ),
        ),

        // CALCYNX PREVIEW
        Expanded(
          flex: 4,
          child: CalCynxPreview(
            isTablet: isTablet,
            isMobile: false,
          ),
        ),
      ],
    );
  }

  // ================================================================
  // MOBILE PROJECT
  // ================================================================

  Widget _buildMobileProject() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomPaint(
          size: Size(70, 70),
          painter: ProjectPolygonPainter(),
        ),
        const SizedBox(height: 35),
        _buildProjectInfo(),
        const SizedBox(height: 45),
        const CalCynxPreview(
          isTablet: false,
          isMobile: true,
        ),
      ],
    );
  }

  // ================================================================
  // PROJECT INFORMATION
  // ================================================================

  Widget _buildProjectInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '01 — Featured',
          style: TextStyle(
            color: AppColors.muted,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'CalCynx',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 30,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 22),
        const Text(
          'A personal workspace and '
          'calendar app designed to keep '
          'everyday tasks, bills, and '
          'important dates in one place.',
          style: TextStyle(
            color: AppColors.muted,
            fontSize: 18,
            height: 1.65,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 25),
        _buildBullet(
          'Organize daily tasks, bills, and reminders from a single workspace',
        ),
        const SizedBox(height: 12),
        _buildBullet(
          'Calendar-based planning with monthly totals and useful summaries',
        ),
        const SizedBox(height: 12),
        _buildBullet(
          'Built in Flutter with a focus on clean interaction and responsive design',
        ),
        const SizedBox(height: 28),
        const Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            TechTag(text: 'Flutter'),
            TechTag(text: 'Dart'),
            TechTag(text: 'Web'),
            TechTag(text: 'Personal Project'),
            TechTag(text: 'Android'),
          ],
        ),
      ],
    );
  }

  // ================================================================
  // BULLET
  // ================================================================

  Widget _buildBullet(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 8),
          child: Text(
            '•',
            style: TextStyle(
              color: AppColors.muted,
              fontSize: 18,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: AppColors.muted,
              fontSize: 16,
              height: 1.55,
            ),
          ),
        ),
      ],
    );
  }
}

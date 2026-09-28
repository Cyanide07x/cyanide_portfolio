import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../widgets/common/portfolio_header.dart';
import '../../widgets/common/portfolio_footer.dart';

class AboutPage extends StatelessWidget {
  final bool showHeader;

  const AboutPage({
    super.key,
    this.showHeader = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: Column(
        children: [
          // =====================================================
          // HEADER
          // =====================================================

          if (showHeader)
            const PortfolioHeader(
              activePage: 'About',
            ),

          // =====================================================
          // PAGE CONTENT
          // =====================================================

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  _buildAboutSection(context),

                  _buildEducationSection(context),

                  _buildHowIWorkSection(context),

                  // =================================================
                  // FOOTER
                  // =================================================

                  const PortfolioFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // ABOUT
  // ===========================================================

  Widget _buildAboutSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: _horizontalPadding(context),
        vertical: 110,
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          _sectionLabel('# About'),

          const SizedBox(height: 35),

          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 1000,
            ),
            child: const Text(
              'I work on things that stopped syncing.',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 58,
                height: 1.05,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          const SizedBox(height: 35),

          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 700,
            ),
            child: const Text(
              "I'm a Flutter developer, fresh out of college and building my first real body of work. I move between product design, brand, and app development, and I'm drawn to the seam between disciplines more than the middle of either one. Everything on this site is a project I chose because it stretched me somewhere new.",
              style: TextStyle(
                color: AppColors.mutedDark,
                fontSize: 18,
                height: 1.7,
              ),
            ),
          ),

          const SizedBox(height: 80),

          _buildCapabilities(context),
        ],
      ),
    );
  }

  // ===========================================================
  // CAPABILITIES
  // ===========================================================

  Widget _buildCapabilities(BuildContext context) {
    final bool isMobile =
        MediaQuery.of(context).size.width < 700;

    final capabilities = [
      const _Capability(
        number: '01',
        title: 'Product Design',
        description:
            'Designing interfaces with a focus on clarity, usability and visual identity.',
      ),

      const _Capability(
        number: '02',
        title: 'Brand & Identity',
        description:
            'Creating visual systems that give digital products a recognizable identity.',
      ),

      const _Capability(
        number: '03',
        title: 'App Development',
        description:
            'Building responsive applications with Flutter and modern development tools.',
      ),

      const _Capability(
        number: '04',
        title: 'Creative Code',
        description:
            'Experimenting with code, interaction and motion to create distinctive experiences.',
      ),
    ];

    if (isMobile) {
      return Column(
        children: capabilities
            .map(
              (item) => Padding(
                padding:
                    const EdgeInsets.only(
                  bottom: 18,
                ),
                child: _CapabilityCard(
                  capability: item,
                ),
              ),
            )
            .toList(),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics:
          const NeverScrollableScrollPhysics(),
      itemCount: capabilities.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 18,
        mainAxisSpacing: 18,
        childAspectRatio: 2.4,
      ),
      itemBuilder: (context, index) {
        return _CapabilityCard(
          capability: capabilities[index],
        );
      },
    );
  }

  // ===========================================================
  // EDUCATION
  // ===========================================================

  Widget _buildEducationSection(
    BuildContext context,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal:
            _horizontalPadding(context),
        vertical: 110,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color:
                AppColors.white.withValues(
              alpha: 0.08,
            ),
          ),
          bottom: BorderSide(
            color:
                AppColors.white.withValues(
              alpha: 0.08,
            ),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          _sectionLabel('# Education'),

          const SizedBox(height: 55),

          _EducationRow(
            title:
                'B.Tech, Computer Science',
            subtitle:
                'Lakshmi Narain College of Technology and Science — LNCT-S',
            year: '2022–2026',
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // HOW I WORK
  // ===========================================================

  Widget _buildHowIWorkSection(
    BuildContext context,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal:
            _horizontalPadding(context),
        vertical: 110,
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          _sectionLabel('# How I work'),

          const SizedBox(height: 55),

          _ProcessRow(
            number: '01',
            title: 'Listen',
            description:
                'Understand the problem, the people and what needs to change.',
          ),

          _ProcessRow(
            number: '02',
            title: 'Frame',
            description:
                'Turn the problem into a clear direction and a practical plan.',
          ),

          _ProcessRow(
            number: '03',
            title: 'Build',
            description:
                'Design and develop the experience with attention to detail.',
          ),

          _ProcessRow(
            number: '04',
            title: 'Tune',
            description:
                'Refine the result until everything feels like it belongs together.',
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // SECTION LABEL
  // ===========================================================

  Widget _sectionLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: AppColors.primary,
        fontSize: 14,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.5,
      ),
    );
  }

  // ===========================================================
  // RESPONSIVE PADDING
  // ===========================================================

  double _horizontalPadding(
    BuildContext context,
  ) {
    final width =
        MediaQuery.of(context).size.width;

    if (width < 600) {
      return 24;
    }

    if (width < 1000) {
      return 50;
    }

    return 90;
  }
}

// ===============================================================
// CAPABILITY MODEL
// ===============================================================

class _Capability {
  final String number;
  final String title;
  final String description;

  const _Capability({
    required this.number,
    required this.title,
    required this.description,
  });
}

// ===============================================================
// CAPABILITY CARD
// ===============================================================

class _CapabilityCard
    extends StatelessWidget {
  final _Capability capability;

  const _CapabilityCard({
    required this.capability,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      padding:
          const EdgeInsets.all(28),
      decoration:
          BoxDecoration(
        border:
            Border.all(
          color:
              AppColors.white.withValues(
            alpha: 0.10,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            capability.number,
            style:
                const TextStyle(
              color:
                  AppColors.primary,
              fontSize: 13,
              fontWeight:
                  FontWeight.w700,
            ),
          ),

          const SizedBox(
            height: 18,
          ),

          Text(
            capability.title,
            style:
                const TextStyle(
              color: AppColors.white,
              fontSize: 22,
              fontWeight:
                  FontWeight.w700,
            ),
          ),

          const SizedBox(
            height: 12,
          ),

          Text(
            capability.description,
            style:
                const TextStyle(
              color:
                  AppColors.mutedDark,
              fontSize: 14,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

// ===============================================================
// EDUCATION ROW
// ===============================================================

class _EducationRow
    extends StatelessWidget {
  final String title;
  final String subtitle;
  final String year;

  const _EducationRow({
    required this.title,
    required this.subtitle,
    required this.year,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    final bool isMobile =
        MediaQuery.of(context).size.width <
            700;

    return Container(
      padding:
          const EdgeInsets.symmetric(
        vertical: 28,
      ),
      decoration:
          BoxDecoration(
        border:
            Border(
          top:
              BorderSide(
            color:
                AppColors.white.withValues(
              alpha: 0.10,
            ),
          ),
        ),
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  year,
                  style:
                      const TextStyle(
                    color:
                        AppColors.primary,
                    fontSize: 13,
                    fontWeight:
                        FontWeight.w700,
                  ),
                ),

                const SizedBox(
                  height: 15,
                ),

                Text(
                  title,
                  style:
                      const TextStyle(
                    color:
                        AppColors.white,
                    fontSize: 22,
                    fontWeight:
                        FontWeight.w700,
                  ),
                ),

                const SizedBox(
                  height: 8,
                ),

                Text(
                  subtitle,
                  style:
                      const TextStyle(
                    color:
                        AppColors.mutedDark,
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),
              ],
            )
          : Row(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 130,
                  child: Text(
                    year,
                    style:
                        const TextStyle(
                      color:
                          AppColors.primary,
                      fontSize: 13,
                      fontWeight:
                          FontWeight.w700,
                    ),
                  ),
                ),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style:
                            const TextStyle(
                          color:
                              AppColors.white,
                          fontSize: 22,
                          fontWeight:
                              FontWeight.w700,
                        ),
                      ),

                      const SizedBox(
                        height: 8,
                      ),

                      Text(
                        subtitle,
                        style:
                            const TextStyle(
                          color:
                              AppColors.mutedDark,
                          fontSize: 15,
                          height: 1.5,
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

// ===============================================================
// PROCESS ROW
// ===============================================================

class _ProcessRow
    extends StatelessWidget {
  final String number;
  final String title;
  final String description;

  const _ProcessRow({
    required this.number,
    required this.title,
    required this.description,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(
        vertical: 30,
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 70,
            child: Text(
              number,
              style:
                  const TextStyle(
                color:
                    AppColors.primary,
                fontSize: 13,
                fontWeight:
                    FontWeight.w700,
              ),
            ),
          ),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style:
                      const TextStyle(
                    color:
                        AppColors.white,
                    fontSize: 24,
                    fontWeight:
                        FontWeight.w700,
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                ConstrainedBox(
                  constraints:
                      const BoxConstraints(
                    maxWidth: 650,
                  ),
                  child: Text(
                    description,
                    style:
                        const TextStyle(
                      color:
                          AppColors.mutedDark,
                      fontSize: 15,
                      height: 1.6,
                    ),
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
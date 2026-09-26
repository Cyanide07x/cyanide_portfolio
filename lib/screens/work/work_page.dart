import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../widgets/common/portfolio_header.dart';
import '../../widgets/common/portfolio_footer.dart';

class WorkPage extends StatelessWidget {
  const WorkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // ==========================================================
          // HEADER
          // ==========================================================

          const PortfolioHeader(
            activePage: 'Work',
          ),

          // ==========================================================
          // PAGE CONTENT
          // ==========================================================

          Expanded(
            child: SingleChildScrollView(
              child: _buildPageContent(context),
            ),
          ),

          // ==========================================================
          // FOOTER
          // ==========================================================

          const PortfolioFooter(),
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

        final bool isTablet =
            width >= 700 && width < 1100;

        final double horizontalPadding = isMobile
            ? 24
            : isTablet
                ? 40
                : 92;

        // ============================================================
        // HERO
        // ============================================================

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
                maxWidth: isMobile
                    ? double.infinity
                    : 850,
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    '# Work',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize:
                          isMobile ? 16 : 18,
                      fontWeight:
                          FontWeight.w700,
                    ),
                  ),

                  SizedBox(
                    height:
                        isMobile ? 24 : 26,
                  ),

                  Text(
                    'One project so far — built end to end.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isMobile
                          ? 36
                          : isTablet
                              ? 42
                              : 46,
                      height: 1.15,
                      fontWeight:
                          FontWeight.w800,
                      letterSpacing: -1,
                    ),
                  ),

                  SizedBox(
                    height:
                        isMobile ? 24 : 26,
                  ),

                  Text(
                    "I'm early in my career, so this is "
                    "project one: designed, built, and "
                    "shipped by me alone. More is on "
                    "the way.",
                    style: TextStyle(
                      color:
                          const Color(0xFFB0A8AC),
                      fontSize:
                          isMobile ? 17 : 19,
                      height: 1.6,
                      fontWeight:
                          FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        // ============================================================
        // FEATURED PROJECT
        // ============================================================

        final Widget featuredProject =
            Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color:
                    Colors.white.withValues(
                  alpha: 0.08,
                ),
              ),
              bottom: BorderSide(
                color:
                    Colors.white.withValues(
                  alpha: 0.08,
                ),
              ),
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal:
                horizontalPadding,
            vertical:
                isMobile ? 55 : 50,
          ),
          child: isMobile
              ? _buildMobileProject()
              : _buildDesktopProject(
                  isTablet,
                ),
        );

        // ============================================================
        // MORE PROJECTS
        // ============================================================

        final Widget moreProjects =
            Padding(
          padding: EdgeInsets.symmetric(
            horizontal:
                horizontalPadding,
            vertical:
                isMobile ? 65 : 75,
          ),
          child: Center(
            child: Text(
              'More projects in progress — check back soon.',
              textAlign:
                  TextAlign.center,
              style: TextStyle(
                color:
                    const Color(0xFFB0A8AC),
                fontSize:
                    isMobile ? 16 : 18,
                height: 1.5,
              ),
            ),
          ),
        );

        return Column(
          crossAxisAlignment:
              CrossAxisAlignment.stretch,
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

  Widget _buildDesktopProject(
    bool isTablet,
  ) {
    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        // ==========================================================
        // POLYGON
        // ==========================================================

        SizedBox(
          width:
              isTablet ? 140 : 165,
          child: Padding(
            padding:
                const EdgeInsets.only(
              top: 8,
            ),
            child: Transform.translate(
              offset:
                  const Offset(-35, 0),
              child: CustomPaint(
                size:
                    const Size(70, 70),
                painter:
                    _ProjectPolygonPainter(),
              ),
            ),
          ),
        ),

        // ==========================================================
        // PROJECT INFORMATION
        // ==========================================================

        Expanded(
          flex: 6,
          child: Padding(
            padding:
                EdgeInsets.only(
              right:
                  isTablet ? 30 : 70,
            ),
            child:
                _buildProjectInfo(),
          ),
        ),

        // ==========================================================
        // CALCYNX PREVIEW
        // ==========================================================

        Expanded(
          flex: 4,
          child: _buildAppPreview(
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
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        // Polygon

        CustomPaint(
          size:
              const Size(70, 70),
          painter:
              _ProjectPolygonPainter(),
        ),

        const SizedBox(
          height: 35,
        ),

        _buildProjectInfo(),

        const SizedBox(
          height: 45,
        ),

        _buildAppPreview(
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
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        const Text(
          '01 — Featured',
          style: TextStyle(
            color:
                Color(0xFFB0A8AC),
            fontSize: 16,
            fontWeight:
                FontWeight.w400,
          ),
        ),

        const SizedBox(
          height: 20,
        ),

        const Text(
          'CalCynx',
          style: TextStyle(
            color:
                Colors.white,
            fontSize: 30,
            fontWeight:
                FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),

        const SizedBox(
          height: 22,
        ),

        const Text(
          'A personal workspace and '
          'calendar app designed to keep '
          'everyday tasks, bills, and '
          'important dates in one place.',
          style: TextStyle(
            color:
                Color(0xFFB0A8AC),
            fontSize: 18,
            height: 1.65,
            fontWeight:
                FontWeight.w400,
          ),
        ),

        const SizedBox(
          height: 25,
        ),

        _buildBullet(
          'Organize daily tasks, bills, and '
          'reminders from a single workspace',
        ),

        const SizedBox(
          height: 12,
        ),

        _buildBullet(
          'Calendar-based planning with '
          'monthly totals and useful summaries',
        ),

        const SizedBox(
          height: 12,
        ),

        _buildBullet(
          'Built in Flutter with a focus on '
          'clean interaction and responsive design',
        ),

        const SizedBox(
          height: 28,
        ),

        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: const [
            _TechTag(
              text: 'Flutter',
            ),
            _TechTag(
              text: 'Dart',
            ),
            _TechTag(
              text: 'Web',
            ),
            _TechTag(
              text: 'Personal Project',
            ),
            _TechTag(
              text: 'Android',
            ),
          ],
        ),
      ],
    );
  }

  // ================================================================
  // BULLET
  // ================================================================

  Widget _buildBullet(
    String text,
  ) {
    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        const Padding(
          padding:
              EdgeInsets.only(
            top: 8,
          ),
          child: Text(
            '•',
            style: TextStyle(
              color:
                  Color(0xFFB0A8AC),
              fontSize: 18,
            ),
          ),
        ),

        const SizedBox(
          width: 10,
        ),

        Expanded(
          child: Text(
            text,
            style:
                const TextStyle(
              color:
                  Color(0xFFB0A8AC),
              fontSize: 16,
              height: 1.55,
            ),
          ),
        ),
      ],
    );
  }

  // ================================================================
  // CALCYNX PREVIEW
  // ================================================================

  Widget _buildAppPreview({
    required bool isTablet,
    required bool isMobile,
  }) {
    return _CalCynxPreview(
      isTablet: isTablet,
      isMobile: isMobile,
    );
  }
}

// ==================================================================
// CALCYNX INTERACTIVE PREVIEW
// ==================================================================

class _CalCynxPreview
    extends StatefulWidget {
  final bool isTablet;
  final bool isMobile;

  const _CalCynxPreview({
    required this.isTablet,
    required this.isMobile,
  });

  @override
  State<_CalCynxPreview>
      createState() =>
          _CalCynxPreviewState();
}

class _CalCynxPreviewState
    extends State<_CalCynxPreview> {
  bool _calendarSelected =
      false;

  bool _taskHovered = false;

  double _mouseX = 0;
  double _mouseY = 0;

  // ================================================================
  // CURRENT DISPLAYED MONTH
  // ================================================================

  late DateTime _displayedMonth;

  @override
  void initState() {
    super.initState();

    final DateTime now =
        DateTime.now();

    _displayedMonth = DateTime(
      now.year,
      now.month,
      1,
    );
  }

  // ================================================================
  // PREVIOUS MONTH
  // ================================================================

  void _previousMonth() {
    setState(() {
      _displayedMonth =
          DateTime(
        _displayedMonth.year,
        _displayedMonth.month - 1,
        1,
      );
    });
  }

  // ================================================================
  // NEXT MONTH
  // ================================================================

  void _nextMonth() {
    setState(() {
      _displayedMonth =
          DateTime(
        _displayedMonth.year,
        _displayedMonth.month + 1,
        1,
      );
    });
  }

  // ================================================================
  // MONTH NAME
  // ================================================================

  String _monthName(
    int month,
  ) {
    const List<String> months = [
      'JANUARY',
      'FEBRUARY',
      'MARCH',
      'APRIL',
      'MAY',
      'JUNE',
      'JULY',
      'AUGUST',
      'SEPTEMBER',
      'OCTOBER',
      'NOVEMBER',
      'DECEMBER',
    ];

    return months[month - 1];
  }

  // ================================================================
  // BUILD
  // ================================================================

  @override
  Widget build(
    BuildContext context,
  ) {
    return LayoutBuilder(
      builder:
          (context, constraints) {
        final double
            availableWidth =
            constraints.maxWidth;

        final bool isMobile =
            widget.isMobile;

        // ==========================================================
        // PREVIEW HEIGHT
        // ==========================================================
        //
        // Workspace = compact
        // Calendar = taller so the complete
        // calendar fits without overflow.
        //
        // ==========================================================

        final double
            previewHeight;

        if (_calendarSelected) {
          previewHeight = isMobile
              ? 410
              : widget.isTablet
                  ? 440
                  : 470;
        } else {
          previewHeight = isMobile
              ? (availableWidth * 0.82)
                  .clamp(
                  280.0,
                  360.0,
                )
              : widget.isTablet
                  ? 340
                  : 390;
        }

        final double padding =
            isMobile ? 12 : 16;

        final double tabHeight =
            isMobile ? 38 : 42;

        return MouseRegion(
          cursor:
              SystemMouseCursors.basic,

          // ========================================================
          // MOUSE REACTION
          // ========================================================

          onHover: isMobile
              ? null
              : (event) {
                  final RenderBox
                      box =
                      context
                          .findRenderObject()
                          as RenderBox;

                  final Offset local =
                      box.globalToLocal(
                    event.position,
                  );

                  final double
                      centerX =
                      constraints
                              .maxWidth /
                          2;

                  final double
                      centerY =
                      previewHeight /
                          2;

                  setState(() {
                    _mouseX =
                        ((local.dx -
                                    centerX) /
                                centerX)
                            .clamp(
                          -1.0,
                          1.0,
                        );

                    _mouseY =
                        ((local.dy -
                                    centerY) /
                                centerY)
                            .clamp(
                          -1.0,
                          1.0,
                        );
                  });
                },

          onExit: isMobile
              ? null
              : (_) {
                  setState(() {
                    _mouseX = 0;
                    _mouseY = 0;
                  });
                },

          child:
              AnimatedContainer(
            duration:
                const Duration(
              milliseconds: 180,
            ),

            curve:
                Curves.easeOutCubic,

            transform:
                Matrix4.identity()
                  ..translateByDouble(
                    _mouseX * 6,
                    _mouseY * 4,
                    0,
                    1,
                  ),

            width:
                double.infinity,

            height:
                previewHeight,

            decoration:
                BoxDecoration(
              color:
                  Colors.black,

              borderRadius:
                  BorderRadius.circular(
                isMobile
                    ? 22
                    : 28,
              ),

              border:
                  Border.all(
                color:
                    Colors.white
                        .withValues(
                  alpha: 0.12,
                ),
              ),

              boxShadow: [
                BoxShadow(
                  color:
                      AppColors
                          .primary
                          .withValues(
                    alpha: 0.08,
                  ),
                  blurRadius:
                      isMobile
                          ? 20
                          : 30,
                  spreadRadius: 2,
                ),
              ],
            ),

            padding:
                EdgeInsets.all(
              padding,
            ),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                // ==================================================
                // TABS
                // ==================================================

                Row(
                  children: [
                    Expanded(
                      child:
                          _PreviewTab(
                        title:
                            'Workspace',
                        isActive:
                            !_calendarSelected,
                        height:
                            tabHeight,
                        isMobile:
                            isMobile,
                        onTap: () {
                          setState(() {
                            _calendarSelected =
                                false;
                          });
                        },
                      ),
                    ),

                    SizedBox(
                      width:
                          isMobile
                              ? 6
                              : 8,
                    ),

                    Expanded(
                      child:
                          _PreviewTab(
                        title:
                            'Calendar',
                        isActive:
                            _calendarSelected,
                        height:
                            tabHeight,
                        isMobile:
                            isMobile,
                        onTap: () {
                          setState(() {
                            _calendarSelected =
                                true;
                          });
                        },
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height:
                      isMobile
                          ? 18
                          : 24,
                ),

                // ==================================================
                // CONTENT
                // ==================================================

                Expanded(
                  child:
                      AnimatedSwitcher(
                    duration:
                        const Duration(
                      milliseconds:
                          200,
                    ),
                    child:
                        _calendarSelected
                            ? _buildCalendarView(
                                isMobile,
                              )
                            : _buildWorkspaceView(
                                isMobile,
                              ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ================================================================
  // WORKSPACE VIEW
  // ================================================================

  Widget _buildWorkspaceView(
    bool isMobile,
  ) {
    return Column(
      key: const ValueKey(
        'workspace',
      ),
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Text(
          'YOUR WORKSPACE',
          style: TextStyle(
            color:
                Colors.white,
            fontSize:
                isMobile
                    ? 12
                    : 14,
            fontWeight:
                FontWeight.w800,
            letterSpacing:
                isMobile
                    ? 1.2
                    : 1.5,
          ),
        ),

        SizedBox(
          height:
              isMobile
                  ? 7
                  : 10,
        ),

        Text(
          'Keep everything in sync.',
          style: TextStyle(
            color:
                const Color(
              0xFF9E9699,
            ),
            fontSize:
                isMobile
                    ? 11
                    : 13,
          ),
        ),

        const Spacer(),

        _buildTask(
          isMobile,
        ),
      ],
    );
  }

  // ================================================================
  // CALENDAR VIEW
  // ================================================================

  Widget _buildCalendarView(
    bool isMobile,
  ) {
    return Column(
      key: const ValueKey(
        'calendar',
      ),
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        // ==========================================================
        // MONTH HEADER
        // ==========================================================

        Row(
          children: [
            Expanded(
              child: Text(
                '${_monthName(
                  _displayedMonth.month,
                )} ${_displayedMonth.year}',
                style: TextStyle(
                  color:
                      Colors.white,
                  fontSize:
                      isMobile
                          ? 12
                          : 14,
                  fontWeight:
                      FontWeight.w800,
                  letterSpacing:
                      1.2,
                ),
              ),
            ),

            _MonthButton(
              icon:
                  Icons.chevron_left,
              onTap:
                  _previousMonth,
              isMobile:
                  isMobile,
            ),

            const SizedBox(
              width: 4,
            ),

            _MonthButton(
              icon:
                  Icons.chevron_right,
              onTap:
                  _nextMonth,
              isMobile:
                  isMobile,
            ),
          ],
        ),

        SizedBox(
          height:
              isMobile
                  ? 12
                  : 16,
        ),

        // ==========================================================
        // WEEK DAYS
        // ==========================================================

        Row(
          children: const [
            _WeekDay(
              label: 'M',
            ),
            _WeekDay(
              label: 'T',
            ),
            _WeekDay(
              label: 'W',
            ),
            _WeekDay(
              label: 'T',
            ),
            _WeekDay(
              label: 'F',
            ),
            _WeekDay(
              label: 'S',
            ),
            _WeekDay(
              label: 'S',
            ),
          ],
        ),

        SizedBox(
          height:
              isMobile
                  ? 6
                  : 8,
        ),

        // ==========================================================
        // CALENDAR GRID
        // ==========================================================

        Expanded(
          child:
              _buildCalendarGrid(
            isMobile,
          ),
        ),

        SizedBox(
          height:
              isMobile
                  ? 10
                  : 12,
        ),

        // ==========================================================
        // TODAY INFO
        // ==========================================================

        _buildCalendarInfo(
          isMobile,
        ),
      ],
    );
  }

  // ================================================================
  // CALENDAR GRID
  // ================================================================

  Widget _buildCalendarGrid(
    bool isMobile,
  ) {
    final int year =
        _displayedMonth.year;

    final int month =
        _displayedMonth.month;

    // First day of month.

    final DateTime firstDay =
        DateTime(
      year,
      month,
      1,
    );

    // Dart:
    //
    // Monday = 1
    // Tuesday = 2
    // ...
    // Sunday = 7
    //
    // Convert to:
    //
    // Monday = 0
    // Sunday = 6

    final int firstWeekday =
        firstDay.weekday - 1;

    // Last day of month.

    final int daysInMonth =
        DateTime(
      year,
      month + 1,
      0,
    ).day;

    // Calculate required cells.

    final int totalCells =
        ((firstWeekday +
                    daysInMonth +
                    6) ~/
                7) *
            7;

    final List<Widget> days =
        [];

    for (
      int i = 0;
      i < totalCells;
      i++
    ) {
      final int dayNumber =
          i -
              firstWeekday +
              1;

      if (dayNumber < 1 ||
          dayNumber >
              daysInMonth) {
        days.add(
          _emptyCalendarDay(
            isMobile,
          ),
        );
      } else {
        final DateTime date =
            DateTime(
          year,
          month,
          dayNumber,
        );

        days.add(
          _calendarDate(
            date,
            isMobile,
          ),
        );
      }
    }

    return GridView.count(
      crossAxisCount: 7,

      shrinkWrap: true,

      physics:
          const NeverScrollableScrollPhysics(),

      mainAxisSpacing:
          isMobile ? 4 : 5,

      crossAxisSpacing:
          isMobile ? 3 : 5,

      childAspectRatio:
          isMobile
              ? 1.45
              : 1.55,

      children: days,
    );
  }

  // ================================================================
  // CALENDAR DATE
  // ================================================================

  Widget _calendarDate(
    DateTime date,
    bool isMobile,
  ) {
    final DateTime today =
        DateTime.now();

    final bool isToday =
        date.year ==
                today.year &&
            date.month ==
                today.month &&
            date.day ==
                today.day;

    return AnimatedContainer(
      duration:
          const Duration(
        milliseconds: 160,
      ),

      decoration:
          BoxDecoration(
        color: isToday
            ? AppColors.primary
                .withValues(
                alpha: 0.22,
              )
            : const Color(
                0xFF030303,
              ),

        border:
            Border.all(
          color: isToday
              ? AppColors.primary
              : Colors.white
                  .withValues(
                  alpha: 0.06,
                ),
        ),

        borderRadius:
            BorderRadius.circular(
          isMobile ? 5 : 6,
        ),
      ),

      child: Center(
        child: Text(
          '${date.day}',
          style:
              TextStyle(
            color: isToday
                ? Colors.white
                : const Color(
                    0xFFB0A8AC,
                  ),

            fontSize:
                isMobile
                    ? 10
                    : 11,

            fontWeight: isToday
                ? FontWeight.w800
                : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  // ================================================================
  // EMPTY CALENDAR CELL
  // ================================================================

  Widget _emptyCalendarDay(
    bool isMobile,
  ) {
    return Container(
      decoration:
          BoxDecoration(
        color:
            const Color(
          0xFF070707,
        ),

        borderRadius:
            BorderRadius.circular(
          isMobile ? 5 : 6,
        ),
      ),
    );
  }

  // ================================================================
  // CALENDAR INFO
  // ================================================================

  Widget _buildCalendarInfo(
    bool isMobile,
  ) {
    final DateTime now =
        DateTime.now();

    final bool showingCurrentMonth =
        _displayedMonth.year ==
                now.year &&
            _displayedMonth.month ==
                now.month;

    return Container(
      width:
          double.infinity,

      height:
          isMobile ? 36 : 40,

      padding:
          const EdgeInsets.symmetric(
        horizontal: 10,
      ),

      decoration:
          BoxDecoration(
        color:
            const Color(
          0xFF0D0D0D,
        ),

        border:
            Border.all(
          color:
              Colors.white
                  .withValues(
            alpha: 0.08,
          ),
        ),

        borderRadius:
            BorderRadius.circular(
          7,
        ),
      ),

      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,

            decoration:
                const BoxDecoration(
              color:
                  AppColors.primary,
              shape:
                  BoxShape.circle,
            ),
          ),

          const SizedBox(
            width: 8,
          ),

          Expanded(
            child: Text(
              showingCurrentMonth
                  ? 'Today — ${now.day} ${_monthName(now.month).toLowerCase()}'
                  : 'Calendar preview',

              style:
                  TextStyle(
                color:
                    const Color(
                  0xFFB0A8AC,
                ),
                fontSize:
                    isMobile
                        ? 10
                        : 11,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // WORKSPACE TASK
  // ================================================================

  Widget _buildTask(
    bool isMobile,
  ) {
    return MouseRegion(
      cursor:
          SystemMouseCursors.click,

      onEnter: (_) {
        if (!isMobile) {
          setState(() {
            _taskHovered =
                true;
          });
        }
      },

      onExit: (_) {
        if (!isMobile) {
          setState(() {
            _taskHovered =
                false;
          });
        }
      },

      child:
          AnimatedContainer(
        duration:
            const Duration(
          milliseconds: 160,
        ),

        width:
            double.infinity,

        height:
            isMobile
                ? 40
                : 45,

        padding:
            EdgeInsets.symmetric(
          horizontal:
              isMobile
                  ? 10
                  : 12,
        ),

        decoration:
            BoxDecoration(
          color: _taskHovered
              ? const Color(
                  0xFF151515,
                )
              : const Color(
                  0xFF0D0D0D,
                ),

          border:
              Border.all(
            color: _taskHovered
                ? AppColors
                    .primary
                    .withValues(
                    alpha: 0.35,
                  )
                : Colors.white
                    .withValues(
                    alpha: 0.08,
                  ),
          ),

          borderRadius:
              BorderRadius.circular(
            isMobile
                ? 7
                : 8,
          ),
        ),

        child: Row(
          children: [
            Container(
              width:
                  isMobile
                      ? 7
                      : 8,

              height:
                  isMobile
                      ? 7
                      : 8,

              decoration:
                  const BoxDecoration(
                color:
                    AppColors.primary,
                shape:
                    BoxShape.circle,
              ),
            ),

            SizedBox(
              width:
                  isMobile
                      ? 8
                      : 10,
            ),

            const Expanded(
              child: Text(
                'Build portfolio',
                overflow:
                    TextOverflow
                        .ellipsis,
                style:
                    TextStyle(
                  color:
                      Colors.white,
                  fontSize: 13,
                ),
              ),
            ),

            AnimatedOpacity(
              duration:
                  const Duration(
                milliseconds:
                    150,
              ),

              opacity:
                  _taskHovered
                      ? 1
                      : 0.6,

              child:
                  const Text(
                'Today',
                style:
                    TextStyle(
                  color:
                      Color(
                    0xFF777174,
                  ),
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================================================================
// PREVIEW TAB
// ==================================================================

class _PreviewTab
    extends StatefulWidget {
  final String title;
  final bool isActive;
  final double height;
  final bool isMobile;
  final VoidCallback onTap;

  const _PreviewTab({
    required this.title,
    required this.isActive,
    required this.height,
    required this.isMobile,
    required this.onTap,
  });

  @override
  State<_PreviewTab>
      createState() =>
          _PreviewTabState();
}

class _PreviewTabState
    extends State<_PreviewTab> {
  bool _hovered = false;

  @override
  Widget build(
    BuildContext context,
  ) {
    final bool active =
        widget.isActive;

    return MouseRegion(
      cursor:
          SystemMouseCursors.click,

      onEnter: (_) {
        if (!widget.isMobile) {
          setState(() {
            _hovered = true;
          });
        }
      },

      onExit: (_) {
        if (!widget.isMobile) {
          setState(() {
            _hovered = false;
          });
        }
      },

      child: GestureDetector(
        onTap:
            widget.onTap,

        child:
            AnimatedContainer(
          duration:
              const Duration(
            milliseconds: 160,
          ),

          height:
              widget.height,

          decoration:
              BoxDecoration(
            color: active
                ? AppColors.primary
                    .withValues(
                    alpha:
                        _hovered
                            ? 0.28
                            : 0.18,
                  )
                : _hovered
                    ? const Color(
                        0xFF181114,
                      )
                    : const Color(
                        0xFF100B0D,
                      ),

            border:
                Border.all(
              color: active
                  ? AppColors.primary
                  : _hovered
                      ? AppColors
                          .primary
                          .withValues(
                          alpha:
                              0.35,
                        )
                      : Colors.white
                          .withValues(
                          alpha:
                              0.10,
                        ),
            ),

            borderRadius:
                BorderRadius.circular(
              widget.isMobile
                  ? 8
                  : 10,
            ),
          ),

          child: Center(
            child: Text(
              widget.title,

              style:
                  TextStyle(
                color: active
                    ? Colors.white
                    : _hovered
                        ? Colors.white
                        : const Color(
                            0xFF9E9699,
                          ),

                fontSize:
                    widget.isMobile
                        ? 12
                        : 13,

                fontWeight: active
                    ? FontWeight.w700
                    : FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ==================================================================
// WEEK DAY
// ==================================================================

class _WeekDay
    extends StatelessWidget {
  final String label;

  const _WeekDay({
    required this.label,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Expanded(
      child: Center(
        child: Text(
          label,
          style:
              const TextStyle(
            color:
                Color(0xFF555055),
            fontSize: 9,
            fontWeight:
                FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

// ==================================================================
// MONTH BUTTON
// ==================================================================

class _MonthButton
    extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isMobile;

  const _MonthButton({
    required this.icon,
    required this.onTap,
    required this.isMobile,
  });

  @override
  State<_MonthButton>
      createState() =>
          _MonthButtonState();
}

class _MonthButtonState
    extends State<_MonthButton> {
  bool _hovered = false;

  @override
  Widget build(
    BuildContext context,
  ) {
    return MouseRegion(
      cursor:
          SystemMouseCursors.click,

      onEnter: (_) {
        if (!widget.isMobile) {
          setState(() {
            _hovered = true;
          });
        }
      },

      onExit: (_) {
        if (!widget.isMobile) {
          setState(() {
            _hovered = false;
          });
        }
      },

      child: GestureDetector(
        onTap:
            widget.onTap,

        child:
            AnimatedContainer(
          duration:
              const Duration(
            milliseconds: 140,
          ),

          width:
              widget.isMobile
                  ? 24
                  : 28,

          height:
              widget.isMobile
                  ? 24
                  : 28,

          decoration:
              BoxDecoration(
            color: _hovered
                ? AppColors
                    .primary
                    .withValues(
                    alpha: 0.18,
                  )
                : const Color(
                    0xFF0D0D0D,
                  ),

            border:
                Border.all(
              color: _hovered
                  ? AppColors
                      .primary
                      .withValues(
                      alpha: 0.45,
                    )
                  : Colors.white
                      .withValues(
                      alpha: 0.08,
                    ),
            ),

            borderRadius:
                BorderRadius.circular(
              6,
            ),
          ),

          child: Icon(
            widget.icon,
            color:
                const Color(
              0xFF9E9699,
            ),
            size:
                widget.isMobile
                    ? 14
                    : 16,
          ),
        ),
      ),
    );
  }
}

// ==================================================================
// TECH TAG
// ==================================================================

class _TechTag
    extends StatelessWidget {
  final String text;

  const _TechTag({
    required this.text,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 7,
      ),

      decoration:
          BoxDecoration(
        border:
            Border.all(
          color:
              Colors.white
                  .withValues(
            alpha: 0.10,
          ),
        ),

        borderRadius:
            BorderRadius.circular(
          2,
        ),
      ),

      child: Text(
        text,
        style:
            const TextStyle(
          color:
              Colors.white,
          fontSize: 13,
          fontWeight:
              FontWeight.w500,
        ),
      ),
    );
  }
}

// ==================================================================
// PROJECT POLYGON
// ==================================================================

class _ProjectPolygonPainter
    extends CustomPainter {
  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final Paint paint =
        Paint()
          ..color =
              AppColors
                  .primary
                  .withValues(
            alpha: 0.9,
          );

    final Path path =
        Path();

    path.moveTo(
      size.width * 0.55,
      0,
    );

    path.lineTo(
      size.width * 0.98,
      size.height * 0.20,
    );

    path.lineTo(
      size.width * 0.88,
      size.height * 0.80,
    );

    path.lineTo(
      size.width * 0.38,
      size.height,
    );

    path.lineTo(
      0,
      size.height * 0.55,
    );

    path.close();

    canvas.drawPath(
      path,
      paint,
    );
  }

  @override
  bool shouldRepaint(
    covariant CustomPainter oldDelegate,
  ) {
    return false;
  }
}
import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import 'calendar_components.dart';
import 'preview_tab.dart';

class CalCynxPreview extends StatefulWidget {
  final bool isTablet;
  final bool isMobile;

  const CalCynxPreview({
    super.key,
    required this.isTablet,
    required this.isMobile,
  });

  @override
  State<CalCynxPreview> createState() => _CalCynxPreviewState();
}

class _CalCynxPreviewState extends State<CalCynxPreview> {
  bool _calendarSelected = false;
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
    final DateTime now = DateTime.now();
    _displayedMonth = DateTime(
      now.year,
      now.month,
      1,
    );
  }

  // ================================================================
  // PREVIOUS / NEXT MONTH
  // ================================================================

  void _previousMonth() {
    setState(() {
      _displayedMonth = DateTime(
        _displayedMonth.year,
        _displayedMonth.month - 1,
        1,
      );
    });
  }

  void _nextMonth() {
    setState(() {
      _displayedMonth = DateTime(
        _displayedMonth.year,
        _displayedMonth.month + 1,
        1,
      );
    });
  }

  // ================================================================
  // MONTH NAME
  // ================================================================

  String _monthName(int month) {
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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double availableWidth = constraints.maxWidth;
        final bool isMobile = widget.isMobile;

        // Preview Height
        final double previewHeight;
        if (_calendarSelected) {
          previewHeight = isMobile
              ? 410
              : widget.isTablet
                  ? 440
                  : 470;
        } else {
          previewHeight = isMobile
              ? (availableWidth * 0.82).clamp(280.0, 360.0)
              : widget.isTablet
                  ? 340
                  : 390;
        }

        final double padding = isMobile ? 12 : 16;
        final double tabHeight = isMobile ? 38 : 42;

        return MouseRegion(
          cursor: SystemMouseCursors.basic,
          onHover: isMobile
              ? null
              : (event) {
                  // Direct localPosition avoids expensive render box tree queries
                  final Offset local = event.localPosition;
                  final double centerX = constraints.maxWidth / 2;
                  final double centerY = previewHeight / 2;

                  final double newX =
                      ((local.dx - centerX) / centerX).clamp(-1.0, 1.0);
                  final double newY =
                      ((local.dy - centerY) / centerY).clamp(-1.0, 1.0);

                  if ((newX - _mouseX).abs() > 0.02 ||
                      (newY - _mouseY).abs() > 0.02) {
                    setState(() {
                      _mouseX = newX;
                      _mouseY = newY;
                    });
                  }
                },
          onExit: isMobile
              ? null
              : (_) {
                  setState(() {
                    _mouseX = 0;
                    _mouseY = 0;
                  });
                },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOutCubic,
            transform: Matrix4.identity()
              ..translateByDouble(
                _mouseX * 6,
                _mouseY * 4,
                0,
                1,
              ),
            width: double.infinity,
            height: previewHeight,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(isMobile ? 22 : 28),
              border: Border.all(
                color: AppColors.white.withValues(alpha: 0.12),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  blurRadius: isMobile ? 20 : 30,
                  spreadRadius: 2,
                ),
              ],
            ),
            padding: EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TABS
                Row(
                  children: [
                    Expanded(
                      child: PreviewTab(
                        title: 'Workspace',
                        isActive: !_calendarSelected,
                        height: tabHeight,
                        isMobile: isMobile,
                        onTap: () {
                          if (_calendarSelected) {
                            setState(() {
                              _calendarSelected = false;
                            });
                          }
                        },
                      ),
                    ),
                    SizedBox(width: isMobile ? 6 : 8),
                    Expanded(
                      child: PreviewTab(
                        title: 'Calendar',
                        isActive: _calendarSelected,
                        height: tabHeight,
                        isMobile: isMobile,
                        onTap: () {
                          if (!_calendarSelected) {
                            setState(() {
                              _calendarSelected = true;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),

                SizedBox(height: isMobile ? 18 : 24),

                // CONTENT
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: _calendarSelected
                        ? _buildCalendarView(isMobile)
                        : _buildWorkspaceView(isMobile),
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

  Widget _buildWorkspaceView(bool isMobile) {
    return Column(
      key: const ValueKey('workspace'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'YOUR WORKSPACE',
          style: TextStyle(
            color: AppColors.white,
            fontSize: isMobile ? 12 : 14,
            fontWeight: FontWeight.w800,
            letterSpacing: isMobile ? 1.2 : 1.5,
          ),
        ),
        SizedBox(height: isMobile ? 7 : 10),
        Text(
          'Keep everything in sync.',
          style: TextStyle(
            color: AppColors.mutedDark,
            fontSize: isMobile ? 11 : 13,
          ),
        ),
        const Spacer(),
        _buildTask(isMobile),
      ],
    );
  }

  // ================================================================
  // CALENDAR VIEW
  // ================================================================

  Widget _buildCalendarView(bool isMobile) {
    return Column(
      key: const ValueKey('calendar'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // MONTH HEADER
        Row(
          children: [
            Expanded(
              child: Text(
                '${_monthName(_displayedMonth.month)} ${_displayedMonth.year}',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: isMobile ? 12 : 14,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            MonthButton(
              icon: Icons.chevron_left,
              onTap: _previousMonth,
              isMobile: isMobile,
            ),
            const SizedBox(width: 4),
            MonthButton(
              icon: Icons.chevron_right,
              onTap: _nextMonth,
              isMobile: isMobile,
            ),
          ],
        ),

        SizedBox(height: isMobile ? 12 : 16),

        // WEEK DAYS
        const Row(
          children: [
            WeekDay(label: 'M'),
            WeekDay(label: 'T'),
            WeekDay(label: 'W'),
            WeekDay(label: 'T'),
            WeekDay(label: 'F'),
            WeekDay(label: 'S'),
            WeekDay(label: 'S'),
          ],
        ),

        SizedBox(height: isMobile ? 6 : 8),

        // CALENDAR GRID
        Expanded(
          child: _buildCalendarGrid(isMobile),
        ),

        SizedBox(height: isMobile ? 10 : 12),

        // TODAY INFO
        _buildCalendarInfo(isMobile),
      ],
    );
  }

  // ================================================================
  // CALENDAR GRID
  // ================================================================

  Widget _buildCalendarGrid(bool isMobile) {
    final int year = _displayedMonth.year;
    final int month = _displayedMonth.month;

    final DateTime firstDay = DateTime(year, month, 1);
    final int firstWeekday = firstDay.weekday - 1;
    final int daysInMonth = DateTime(year, month + 1, 0).day;
    final int totalCells = ((firstWeekday + daysInMonth + 6) ~/ 7) * 7;

    final List<Widget> days = [];

    for (int i = 0; i < totalCells; i++) {
      final int dayNumber = i - firstWeekday + 1;

      if (dayNumber < 1 || dayNumber > daysInMonth) {
        days.add(_emptyCalendarDay(isMobile));
      } else {
        final DateTime date = DateTime(year, month, dayNumber);
        days.add(_calendarDate(date, isMobile));
      }
    }

    return GridView.count(
      crossAxisCount: 7,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: isMobile ? 4 : 5,
      crossAxisSpacing: isMobile ? 3 : 5,
      childAspectRatio: isMobile ? 1.45 : 1.55,
      children: days,
    );
  }

  Widget _calendarDate(DateTime date, bool isMobile) {
    final DateTime today = DateTime.now();
    final bool isToday = date.year == today.year &&
        date.month == today.month &&
        date.day == today.day;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 160),
      decoration: BoxDecoration(
        color: isToday
            ? AppColors.primary.withValues(alpha: 0.22)
            : const Color(0xFF030303),
        border: Border.all(
          color: isToday
              ? AppColors.primary
              : AppColors.white.withValues(alpha: 0.06),
        ),
        borderRadius: BorderRadius.circular(isMobile ? 5 : 6),
      ),
      child: Center(
        child: Text(
          '${date.day}',
          style: TextStyle(
            color: isToday ? AppColors.white : AppColors.muted,
            fontSize: isMobile ? 10 : 11,
            fontWeight: isToday ? FontWeight.w800 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _emptyCalendarDay(bool isMobile) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF070707),
        borderRadius: BorderRadius.circular(isMobile ? 5 : 6),
      ),
    );
  }

  Widget _buildCalendarInfo(bool isMobile) {
    final DateTime now = DateTime.now();
    final bool showingCurrentMonth =
        _displayedMonth.year == now.year && _displayedMonth.month == now.month;

    return Container(
      width: double.infinity,
      height: isMobile ? 36 : 40,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF0D0D0D),
        border: Border.all(
          color: AppColors.white.withValues(alpha: 0.08),
        ),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              showingCurrentMonth
                  ? 'Today — ${now.day} ${_monthName(now.month).toLowerCase()}'
                  : 'Calendar preview',
              style: TextStyle(
                color: AppColors.muted,
                fontSize: isMobile ? 10 : 11,
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

  Widget _buildTask(bool isMobile) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        if (!isMobile) {
          setState(() {
            _taskHovered = true;
          });
        }
      },
      onExit: (_) {
        if (!isMobile) {
          setState(() {
            _taskHovered = false;
          });
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        width: double.infinity,
        height: isMobile ? 40 : 45,
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 10 : 12,
        ),
        decoration: BoxDecoration(
          color:
              _taskHovered ? AppColors.surfaceHover : const Color(0xFF0D0D0D),
          border: Border.all(
            color: _taskHovered
                ? AppColors.primary.withValues(alpha: 0.35)
                : AppColors.white.withValues(alpha: 0.08),
          ),
          borderRadius: BorderRadius.circular(isMobile ? 7 : 8),
        ),
        child: Row(
          children: [
            Container(
              width: isMobile ? 7 : 8,
              height: isMobile ? 7 : 8,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: isMobile ? 8 : 10),
            const Expanded(
              child: Text(
                'Build portfolio',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 13,
                ),
              ),
            ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 150),
              opacity: _taskHovered ? 1 : 0.6,
              child: const Text(
                'Today',
                style: TextStyle(
                  color: Color(0xFF777174),
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

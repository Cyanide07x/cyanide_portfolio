import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../theme/app_colors.dart';

class PortfolioFooter extends StatelessWidget {
  const PortfolioFooter({super.key});

  // =========================
  // OPEN EXTERNAL URL
  // =========================

Future<void> _openUrl(String url) async {
  final uri = Uri.parse(url);

  await launchUrl(
    uri,
    webOnlyWindowName: '_self',
  );
}

  // =========================
  // OPEN RESUME
  // =========================

  Future<void> _openResume() async {
    final resumeUrl = Uri.base
        .resolve(
          'assets/assets/resume/Utsav_Sachan_Resume_cynx.pdf',
        )
        .toString();

    await _openUrl(resumeUrl);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 700;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 20 : 40,
            vertical: isMobile ? 30 : 28,
          ),
          decoration: BoxDecoration(
            color: AppColors.background,
            border: Border(
              top: BorderSide(
                color: Colors.white.withValues(alpha: 0.08),
                width: 1,
              ),
            ),
          ),
          child: isMobile
              ? _buildMobileFooter()
              : _buildDesktopFooter(),
        );
      },
    );
  }

  // =========================
  // DESKTOP FOOTER
  // =========================

  Widget _buildDesktopFooter() {
    return Row(
      children: [
        _copyright(),
        const Spacer(),
        _desktopLinks(),
      ],
    );
  }

  // =========================
  // MOBILE FOOTER
  // =========================

  Widget _buildMobileFooter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'CYNX — Without Sync, 2026',
          style: TextStyle(
            color: Color(0xFFB0A8AC),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),

        const SizedBox(height: 26),

        // GitHub
        _FooterLink(
          text: 'GitHub',
          fontSize: 15,
          onTap: () => _openUrl(
            'https://github.com/Cyanide07x',
          ),
        ),

        const SizedBox(height: 16),

        // LinkedIn
        _FooterLink(
          text: 'LinkedIn',
          fontSize: 15,
          onTap: () => _openUrl(
            'https://www.linkedin.com/in/utsav-sachan-7759b4250',
          ),
        ),

        const SizedBox(height: 18),

        // Resume
        _ResumeButton(
          onTap: _openResume,
        ),
      ],
    );
  }

  // =========================
  // COPYRIGHT
  // =========================

  Widget _copyright() {
    return const Text(
      'CYNX — Without Sync, 2026',
      style: TextStyle(
        color: Color(0xFFB0A8AC),
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  // =========================
  // DESKTOP LINKS
  // =========================

  Widget _desktopLinks() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // GitHub
        _FooterLink(
          text: 'GitHub',
          fontSize: 16,
          onTap: () => _openUrl(
            'https://github.com/Cyanide07x',
          ),
        ),

        const SizedBox(width: 28),

        // LinkedIn
        _FooterLink(
          text: 'LinkedIn',
          fontSize: 16,
          onTap: () => _openUrl(
            'https://www.linkedin.com/in/utsav-sachan-7759b4250/',
          ),
        ),

        const SizedBox(width: 28),

        // Resume
        _ResumeButton(
          onTap: _openResume,
        ),
      ],
    );
  }
}

// =========================
// FOOTER LINK
// =========================

class _FooterLink extends StatefulWidget {
  final String text;
  final double fontSize;
  final VoidCallback onTap;

  const _FooterLink({
    required this.text,
    required this.fontSize,
    required this.onTap,
  });

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 150),
          style: TextStyle(
            color: isHovered
                ? Colors.white
                : const Color(0xFFB0A8AC),
            fontSize: widget.fontSize,
            fontWeight: FontWeight.w600,
          ),
          child: Text(widget.text),
        ),
      ),
    );
  }
}

// =========================
// RESUME BUTTON
// =========================

class _ResumeButton extends StatefulWidget {
  final VoidCallback onTap;

  const _ResumeButton({
    required this.onTap,
  });

  @override
  State<_ResumeButton> createState() => _ResumeButtonState();
}

class _ResumeButtonState extends State<_ResumeButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 9,
          ),
          decoration: BoxDecoration(
            color: isHovered
                ? const Color(0xFF151515)
                : Colors.transparent,
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.12),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(2),
          ),
          child: const Text(
            'Resume ↓',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
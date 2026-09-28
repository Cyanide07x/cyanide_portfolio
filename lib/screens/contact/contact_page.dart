import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../theme/app_colors.dart';
import '../../widgets/common/portfolio_header.dart';
import '../../widgets/common/portfolio_footer.dart';

class ContactPage extends StatefulWidget {
  final bool showHeader;

  const ContactPage({
    super.key,
    this.showHeader = true,
  });

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController =
      TextEditingController();

  final TextEditingController _emailController =
      TextEditingController();

  final TextEditingController _messageController =
      TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();

    super.dispose();
  }

  // =========================
  // SEND MESSAGE
  // =========================

  Future<void> _sendMessage() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final String name = _nameController.text.trim();
    final String email = _emailController.text.trim();
    final String message = _messageController.text.trim();

    final String subject =
        'Portfolio contact from $name';

    final String body =
        'Name: $name\n'
        'Email: $email\n\n'
        'Message:\n$message';

    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'hello@cynx.dev',
      queryParameters: {
        'subject': subject,
        'body': body,
      },
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Unable to open your email application.',
          ),
        ),
      );
    }
  }

  // =========================
  // BUILD
  // =========================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          if (widget.showHeader)
            const PortfolioHeader(
              activePage: 'Contact',
            ),

          Expanded(
            child: SingleChildScrollView(
              child: _buildContactSection(context),
            ),
          ),

          const PortfolioFooter(),
        ],
      ),
    );
  }

  // =========================
  // CONTACT SECTION
  // =========================

  Widget _buildContactSection(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;

        final bool isMobile = width < 700;
        final bool isTablet =
            width >= 700 && width < 1100;

        final double horizontalPadding = isMobile
            ? 24
            : isTablet
                ? 50
                : 90;

        final double headingSize = isMobile
            ? 36
            : isTablet
                ? 48
                : 58;

        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: isMobile ? 70 : 72,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 1360,
              ),
              child: isMobile
                  ? _buildMobileLayout(
                      context,
                      headingSize,
                    )
                  : _buildDesktopLayout(
                      context,
                      headingSize,
                      isTablet,
                    ),
            ),
          ),
        );
      },
    );
  }

  // =========================
  // DESKTOP / TABLET
  // =========================

  Widget _buildDesktopLayout(
    BuildContext context,
    double headingSize,
    bool isTablet,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: isTablet ? 5 : 4,
          child: _buildContactInfo(
            context,
            headingSize,
          ),
        ),

        SizedBox(
          width: isTablet ? 45 : 90,
        ),

        Expanded(
          flex: 6,
          child: _buildContactForm(context),
        ),
      ],
    );
  }

  // =========================
  // MOBILE
  // =========================

  Widget _buildMobileLayout(
    BuildContext context,
    double headingSize,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildContactInfo(
          context,
          headingSize,
        ),

        const SizedBox(height: 55),

        _buildContactForm(context),
      ],
    );
  }

  // =========================
  // CONTACT INFORMATION
  // =========================

  Widget _buildContactInfo(
    BuildContext context,
    double headingSize,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '# Contact',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 14,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
          ),
        ),

        const SizedBox(height: 24),

        Text(
          "Let's get in sync.",
          style: TextStyle(
            color: Colors.white,
            fontSize: headingSize,
            fontWeight: FontWeight.w700,
            height: 1.05,
            letterSpacing: -0.8,
          ),
        ),

        const SizedBox(height: 28),

        const Text(
          "Tell me what's misaligned and what you're trying to "
          "build. I reply within two working days.",
          style: TextStyle(
            color: Color(0xFFB0A8AC),
            fontSize: 18,
            fontWeight: FontWeight.w400,
            height: 1.7,
          ),
        ),

        const SizedBox(height: 34),

        _buildInfoItem(
          label: 'Email',
          value: 'hello@cynx.dev',
          onTap: () async {
            final Uri uri = Uri(
              scheme: 'mailto',
              path: 'hello@cynx.dev',
            );

            await launchUrl(uri);
          },
        ),

        const SizedBox(height: 26),

        _buildInfoItem(
          label: 'Location',
          value: 'Remote, working worldwide',
        ),

        const SizedBox(height: 26),

        _buildInfoItem(
          label: 'Elsewhere',
          value: 'Instagram — Are.na — GitHub',
        ),
      ],
    );
  }

  // =========================
  // INFORMATION ITEM
  // =========================

  Widget _buildInfoItem({
    required String label,
    required String value,
    VoidCallback? onTap,
  }) {
    final Widget content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFFB0A8AC),
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 1.4,
          ),
        ),

        const SizedBox(height: 3),

        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            height: 1.4,
          ),
        ),
      ],
    );

    if (onTap == null) {
      return content;
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: content,
      ),
    );
  }

  // =========================
  // CONTACT FORM
  // =========================

  Widget _buildContactForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildField(
            label: 'Name',
            controller: _nameController,
            hint: 'Your name',
          ),

          const SizedBox(height: 24),

          _buildField(
            label: 'Email',
            controller: _emailController,
            hint: 'you@example.com',
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your email.';
              }

              if (!value.contains('@') ||
                  !value.contains('.')) {
                return 'Please enter a valid email.';
              }

              return null;
            },
          ),

          const SizedBox(height: 24),

          _buildField(
            label: 'Message',
            controller: _messageController,
            hint: 'Tell us about the project',
            maxLines: 5,
          ),

          const SizedBox(height: 30),

          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: _sendMessage,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.primary,
                    width: 1,
                  ),
                ),
                child: const Text(
                  'Send message',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // FORM FIELD
  // =========================

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required String hint,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFFB0A8AC),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),

        const SizedBox(height: 8),

        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: validator ??
              (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return 'Please enter your $label.';
                }

                return null;
              },
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
          cursorColor: AppColors.primary,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: Color(0xFF777177),
              fontSize: 18,
            ),
            filled: true,
            fillColor: const Color(0xFF0B080B),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: const BorderSide(
                color: Color(0xFF292329),
                width: 1,
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(
                color: Color(0xFF292329),
                width: 1,
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(
                color: AppColors.primary,
                width: 1,
              ),
            ),
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(
                color: AppColors.primary,
                width: 1,
              ),
            ),
            focusedErrorBorder:
                const OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(
                color: AppColors.primary,
                width: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
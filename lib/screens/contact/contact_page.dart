import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
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

  bool _isSending = false;

  static const String _formspreeEndpoint =
      'https://formspree.io/f/mjykpddr';

  static const String _discordUsername = 'cyanide.lc';

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();

    super.dispose();
  }

  Future<void> _sendMessage() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_isSending) {
      return;
    }

    setState(() {
      _isSending = true;
    });

    final String name = _nameController.text.trim();
    final String email = _emailController.text.trim();
    final String message = _messageController.text.trim();

    try {
      final response = await http.post(
        Uri.parse(_formspreeEndpoint),
        headers: {
          'Accept': 'application/json',
        },
        body: {
          'name': name,
          'email': email,
          '_replyto': email,
          'message': message,
          '_subject': 'Portfolio contact from $name',
        },
      );

      if (!mounted) {
        return;
      }

      if (response.statusCode >= 200 &&
          response.statusCode < 300) {
        _nameController.clear();
        _emailController.clear();
        _messageController.clear();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Message sent successfully.',
            ),
            duration: Duration(seconds: 4),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Something went wrong. Please try again.',
            ),
            duration: Duration(seconds: 4),
          ),
        );
      }
    } catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Unable to send the message. Please try again.',
          ),
          duration: Duration(seconds: 4),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSending = false;
        });
      }
    }
  }

  Future<void> _copyDiscordUsername() async {
    await Clipboard.setData(
      const ClipboardData(
        text: _discordUsername,
      ),
    );

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Discord username copied!',
        ),
        duration: Duration(seconds: 2),
      ),
    );
  }

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
          value: 'utsav0724@gmail.com',
          onTap: () async {
            final Uri uri = Uri(
              scheme: 'mailto',
              path: 'utsav0724@gmail.com',
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
          value: 'Discord',
          onTap: _copyDiscordUsername,
        ),
      ],
    );
  }

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
              if (value == null ||
                  value.trim().isEmpty) {
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
            hint: 'Tell me about the project',
            maxLines: 5,
          ),
          const SizedBox(height: 30),
          MouseRegion(
            cursor: _isSending
                ? SystemMouseCursors.basic
                : SystemMouseCursors.click,
            child: GestureDetector(
              onTap: _isSending
                  ? null
                  : _sendMessage,
              child: AnimatedContainer(
                duration:
                    const Duration(milliseconds: 200),
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.primary,
                    width: 1,
                  ),
                ),
                child: _isSending
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child:
                            CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.primary,
                        ),
                      )
                    : const Text(
                        'Send message',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight:
                              FontWeight.w700,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

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
            contentPadding:
                const EdgeInsets.symmetric(
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
            enabledBorder:
                const OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(
                color: Color(0xFF292329),
                width: 1,
              ),
            ),
            focusedBorder:
                const OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(
                color: AppColors.primary,
                width: 1,
              ),
            ),
            errorBorder:
                const OutlineInputBorder(
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
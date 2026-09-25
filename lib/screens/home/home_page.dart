import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../widgets/common/portfolio_header.dart';






class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const PortfolioHeader(
            activePage: 'Home',
          ),

          Expanded(
            child: Center(
              child: Text(
                'HOME PAGE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
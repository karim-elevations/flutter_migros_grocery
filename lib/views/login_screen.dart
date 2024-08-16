// lib/views/screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:migros_small_app_debug/utils/widgets/sheet/signup_bottom_sheet.dart';
import '../utils/widgets/buttons/primary_button.dart';
import '../utils/widgets/custom_app_bar.dart';
import '../utils/widgets/custom_app_bar.dart';
import '../utils/widgets/sheet/login_bottom_sheet.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Primary background image
          Container(
            color: Colors.transparent,
            child: Image.asset(
              './assets/images/migros_stand_bg.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Content
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              PrimaryButton(
                buttonWidth: 100.0,
                onPressed: () {
                  // Add your sign up logic here
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return LoginBottomSheetContent();
                    },
                  );
                },
                child: Text(
                  'Connexion',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFF46341), // #0F0705
                    Color(0xFFEE4E4E), // #501F12
                  ],
                  stops: [0.0, 1.0],
                ),
              ),
              SizedBox(height: 10),
              PrimaryButton(
                buttonWidth: 100.0,
                onPressed: () {
                  // Add your sign up logic here
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return SignupBottomSheet();
                    },
                  );
                },
                child: Text(
                  'Inscription',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF000000), // #0F0705
                    Color(0xFF501F12), // #501F12
                  ],
                  stops: [0.0, 1.0],
                ),
              ),
              SizedBox(height: 40),
            ],
          ),
        ],
      ),
    );
  }
}


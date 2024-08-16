import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '/utils/widgets/buttons/primary_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../text_fields/text_field.dart';
import '/provider/user_provider.dart';

class LoginBottomSheetContent extends StatefulWidget {
  @override
  _LoginBottomSheetContentState createState() =>
      _LoginBottomSheetContentState();
}

class _LoginBottomSheetContentState extends State<LoginBottomSheetContent> {
  final UserAuthProvider _userAuthProvider = UserAuthProvider();
  final PageController _pageController = PageController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  void _goToNextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _goToPreviousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;


    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFFFFCABC),
            Colors.white.withOpacity(0.8),
            Colors.white,
          ],
          stops: [0.0, 0.2, 1.0],
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.center,
              child: SvgPicture.asset('./assets/vector/drag_sheet.svg'),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height *
                  0.6, // Adjust height constraint
              child: PageView(
                controller: _pageController,
                physics:
                    const NeverScrollableScrollPhysics(), // Disable swipe gestures
                children: [
                  _buildStepOne(width),
                  _buildStepTwo(width),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepOne(double width) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 10.0,
      children: [
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.topLeft,
          child: const Text(
            'Connexion',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.topLeft,
          child: const Text(
            'Entrez votre adresse email afin de vous connectez à notre application.',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Colors.black54,
            ),
          ),
        ),
        const SizedBox(height: 25),
        CustomTextField(
          title: 'Adresse email',
          hintText: 'jean@exemple.ch',
          controller: _emailController,
        ),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.center,
          child: PrimaryButton(
            child: const Text(
              'Suivant',
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
                Colors.black,
                Color(0xFF0F0705),
                Color(0xFF501F12),
              ],
              stops: [0.0, 0.5, 1.0],
            ),
            onPressed: _goToNextPage,
            buttonWidth: width * 0.3,
          ),
        ),
      ],
    );
  }

  Widget _buildStepTwo(double width) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 10.0,
      children: [
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.topLeft,
          child: const Text(
            'Mot de Passe',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.topLeft,
          child: const Text(
            'Entrez votre mot de passe pour vous verifier votre email et vous connecter à notre application.',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Colors.black54,
            ),
          ),
        ),
        const SizedBox(height: 25),
        CustomTextField(
          title: 'Mot de passe',
          hintText: '••••••••',
          controller: _passwordController,
        ),
        const SizedBox(height: 16),
        PrimaryButton(
          child: const Text(
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
              Colors.black,
              Color(0xFF0F0705),
              Color(0xFF501F12),
            ],
            stops: [0.0, 0.5, 1.0],
          ),
          onPressed: () async {
           
            await _userAuthProvider.signIn(
              email: _emailController.text,
              password: _passwordController.text,
            );
      
           GoRouter.of(context).go('/products');
          },
          buttonWidth: width * 0.28,
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: _goToPreviousPage,
          child: const Text(
            'Retour',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}

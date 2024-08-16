import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '/utils/widgets/buttons/primary_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../text_fields/text_field.dart';
import '/provider/user_provider.dart';

class SignupBottomSheet extends StatefulWidget {
  @override
  _SignupBottomSheetState createState() => _SignupBottomSheetState();
}

class _SignupBottomSheetState extends State<SignupBottomSheet> {
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
              child: _signupWidget(width),
            ),
          ],
        ),
      ),
    );
  }

  Widget _signupWidget(double width) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 10.0,
      children: [
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.topLeft,
          child: const Text(
            'Inscription',
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
            'Entrez les informations ci-dessous pour vous inscrire à notre plateforme.',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Colors.black54,
            ),
          ),
        ),
        const SizedBox(height: 25),
        CustomTextField(
          title: 'Adresse e-mail',
          hintText: 'johndoe@example.com',
          controller: _emailController,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          title: 'Mot de passe',
          hintText: '••••••••',
          controller: _passwordController,
        ),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.center,
          child: PrimaryButton(
            child: const Text(
              'S\'inscrire',
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
              try {
                // Attempt to sign up the user
                await _userAuthProvider.signUp(
                  email: _emailController.text,
                  password: _passwordController.text,
                );

                // If successful, show a success message
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Inscription réussie'),
                    backgroundColor: Colors.green,
                  ),
                );

                // Navigate to the products screen
                GoRouter.of(context).go('/products');
              } catch (error) {
                // If there's an error, show an error message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Erreur lors de l\'inscription : $error'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            buttonWidth: width * 0.28,
          ),
        ),
        const SizedBox(height: 18),
        TextButton(
          onPressed: () => GoRouter.of(context).pop(),
          child: const Text(
            'Annuler l\'inscription',
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

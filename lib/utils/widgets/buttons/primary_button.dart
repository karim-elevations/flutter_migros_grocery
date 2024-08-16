import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final double buttonWidth;
  final VoidCallback onPressed;

  const PrimaryButton({
    required this.child,
    required this.gradient,
    required this.onPressed,
    required this.buttonWidth,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(16.0), // Match the ElevatedButton's border radius
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent, // Remove shadow if you want a flat gradient
          shape: RoundedRectangleBorder(
           // Match the Container's border radius
          ),
        ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)), // Remove button elevation if you want a flat look
        onPressed: onPressed,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 23, horizontal: buttonWidth),
          child: child,
        ),
      ),
    );
  }
}



class SecondaryTransparentButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  const SecondaryTransparentButton({
    required this.child,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: child,
    );
  }
}

enum ButtonType {
  primary,
  secondary
  }

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final ButtonType buttonType;

  CustomButton({
    required this.label,
    required this.onPressed,
    required this.buttonType,
  });

  @override
  Widget build(BuildContext context) {
    Color buttonColor;
    switch (buttonType) {
      case ButtonType.primary:
        buttonColor = Colors.blue;
        break;
      case ButtonType.secondary:
        buttonColor = Colors.grey;
        break;
    }

    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
      style: ElevatedButton.styleFrom(),
    );
  }
}

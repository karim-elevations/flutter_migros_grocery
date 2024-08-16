import 'package:flutter/material.dart';
import 'dart:ui';

class CustomGradientCard extends StatelessWidget {
  final Widget child;
  final String backgroundImageAsset;

  const CustomGradientCard({
    Key? key,
    required this.child,
    required this.backgroundImageAsset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final cardWidth = screenWidth * 0.95;

        return Container(
          width: cardWidth,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(234, 205, 127, 0.02),
                Color.fromRGBO(234, 205, 127, 0.02),
              ],
            ),
            border: Border.all(
              color: const Color.fromRGBO(255, 255, 255, 0.08),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(17),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(17),
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Image.asset(
                    backgroundImageAsset,
                    fit: BoxFit.cover,
                    alignment: Alignment.centerRight,
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromRGBO(234, 205, 127, 0.08),
                          Color.fromRGBO(255, 255, 255, 0),
                        ],
                      ),
                    ),
                  ),
                ),
                child,
              ],
            ),
          ),
        );
      },
    );
  }
}
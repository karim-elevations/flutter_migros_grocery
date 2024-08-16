import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leftSide;
  final Widget? rightSide;
  const CustomAppBar({Key? key, this.leftSide, this.rightSide}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(75.0);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          color: Colors.white.withOpacity(0.1),
          child: AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                leftSide ?? Container(width: 100,),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0,),
                  child: SvgPicture.asset(
                    './assets/vector/migros_logo.svg',
                    height: 48,
                  ),
                ),
                rightSide ?? Container(width: 100,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

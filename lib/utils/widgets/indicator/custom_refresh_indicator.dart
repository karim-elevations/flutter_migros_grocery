import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomRefreshIndicator extends RefreshIndicator implements StatefulWidget {
  CustomRefreshIndicator({
    Key? key,
    required Widget child,
    required RefreshCallback onRefresh,
    Color? backgroundColor,
    Color? color,
    double displacement = 135.0,
    double strokeWidth = 2.0,
    String? semanticsLabel,
    String? semanticsValue,
    ScrollNotificationPredicate notificationPredicate = defaultScrollNotificationPredicate,
  
  }) : super(
          key: key,
          child: child,
          onRefresh: onRefresh,
          backgroundColor: backgroundColor,
          color: color,
          displacement: displacement,
          strokeWidth: strokeWidth,
          semanticsLabel: semanticsLabel,
          semanticsValue: semanticsValue,
          notificationPredicate: notificationPredicate,
        );

  @override
  _CustomRefreshIndicatorState createState() => _CustomRefreshIndicatorState();
}

class _CustomRefreshIndicatorState extends RefreshIndicatorState {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        super.build(context),
        Positioned(
          top: widget.displacement,
          child: Opacity(
            opacity: 0.5,
            child: Text('Tirez pour rafraîchir'),
          ),
        ),
      ],
    );
  }
}

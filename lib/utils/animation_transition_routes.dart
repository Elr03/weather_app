import 'package:flutter/material.dart';

///This is a scale transition for navigation
///
class ScalePageRoute extends PageRouteBuilder {
  final Widget widget;
  final String routeName;
  final Curve? curve;
  final Duration? duration;
  ScalePageRoute(
      {required this.widget,
      required this.routeName,
      this.curve,
      this.duration})
      : super(
            settings: RouteSettings(name: routeName),
            transitionDuration: duration ?? const Duration(milliseconds: 500),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secAnimation,
                Widget child) {
              animation = CurvedAnimation(
                parent: animation,
                curve: curve ?? Curves.decelerate,
              );
              return ScaleTransition(
                alignment: Alignment.bottomRight,
                scale: animation,
                child: child,
              );
            },
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secAnimation) {
              return widget;
            });
}

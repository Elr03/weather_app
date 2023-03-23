import 'package:flutter/material.dart';
import 'package:weather_app/utils/animation_transition_routes.dart';

class Navigation {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  ///pop navigation method
  static void popRoute<T extends Object?>([T? result]) {
    //Makes sure it won't pop beyond the app navigator
    if (navigatorKey.currentState != null &&
        navigatorKey.currentState!.canPop()) {
      return navigatorKey.currentState!.pop(result);
    }
  }

  ///push named with scale animation navigation method
  static Future<void> scaleNavigateTo(Widget routeScreen, String routeName) {
    return navigatorKey.currentState!.push<void>(ScalePageRoute(
      widget: routeScreen,
      routeName: routeName,
    ));
  }

  static Future<void> popAndNavigate(String routeName) {
    return navigatorKey.currentState!.popAndPushNamed(routeName);
  }
}

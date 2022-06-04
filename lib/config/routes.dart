import 'package:cia/blocs/blocs.dart';
import 'package:cia/screens/screens.dart';
import 'package:flutter/material.dart';

List<Page> onGenerateAppViewPages(
    AppStatus state,
    List<Page<dynamic>> pages
) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomeScreen.page()];
    case AppStatus.unauthenticated:
      return [LoginScreen.page()];
  }
}

PageRouteBuilder fadeRoute(Widget page) {
  return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 500),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        animation = CurvedAnimation(parent: animation, curve: Curves.easeOut);
        return FadeTransition(
          opacity: animation, child: child,);
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return page;
      });
}
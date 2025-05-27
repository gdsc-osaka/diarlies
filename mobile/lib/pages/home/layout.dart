import 'package:diarlies/components/nb_bottom_navigation.dart';
import 'package:diarlies/components/nb_shape.dart';
import 'package:diarlies/i18n/strings.g.dart';
import 'package:diarlies/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key, required this.shell});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    final styles = Styles.of(context);

    void onNavigate(int index) {
      shell.goBranch(index, initialLocation: index == shell.currentIndex);
    }

    return Scaffold(
      extendBody: true,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          if (styles.brightness == Brightness.light) Positioned(bottom: -100, left: -100, child: NBCircle()),
          if (styles.brightness == Brightness.light) Positioned(top: -20, right: -10, child: NBTriangle()),
          SafeArea(child: shell),
          SafeArea(
            top: false,
            bottom: true,
            left: false,
            right: false,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: NBBottomNavigation(
                currentIndex: shell.currentIndex,
                onTap: onNavigate,
                items: [
                  NBBottomNavigationItem(
                    icon: Icon(Icons.book_outlined),
                    label: t.home.bottom_nav.diary,
                    backgroundColor: styles.color.orangeHalfTone,
                  ),
                  NBBottomNavigationItem(
                    icon: Icon(Icons.language_outlined),
                    label: t.home.bottom_nav.social,
                    backgroundColor: styles.color.greenHalfTone,
                  ),
                  NBBottomNavigationItem(
                    icon: Icon(Icons.settings_outlined),
                    label: t.home.bottom_nav.settings,
                    backgroundColor: styles.color.grey,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

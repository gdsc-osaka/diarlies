import 'package:diarlies/components/nb_bottom_navigation.dart';
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
      shell.goBranch(
        index,
        initialLocation: index == shell.currentIndex,
      );
    }

    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: Stack(
          children: [
            shell,
            Align(
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
          ],
        ),
      ),
    );
  }
}

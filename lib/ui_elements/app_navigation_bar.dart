import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../constraints/style.dart';

class AppNavigationBar extends StatefulWidget {
  final PageController pageController;
  int bottomSelectedIndex;

  AppNavigationBar(
      {Key? key,
      required this.pageController,
      required this.bottomSelectedIndex})
      : super(key: key);

  @override
  State<AppNavigationBar> createState() => _AppNavigationBarState();
}

class _AppNavigationBarState extends State<AppNavigationBar> {
  void bottomTapped(int index) {
    setState(() {
      widget.bottomSelectedIndex = index;
      widget.pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppStyle.bottomAppBarPadding,
      color: Colors.white,
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        onTap: (index) {
          bottomTapped(index);
        },
        selectedItemColor: AppStyle.colors.darkBlue,
        showUnselectedLabels: false,
        unselectedItemColor: AppStyle.colors.darkGrey,
        currentIndex: widget.bottomSelectedIndex,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Ionicons.home_outline),
            activeIcon: Icon(Ionicons.home),
            label: 'Головна',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.add_circle_outline),
            activeIcon: Icon(Ionicons.add_circle),
            label: 'Новий Пост',
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.person_outline),
            activeIcon: Icon(Ionicons.person),
            label: 'Профіль',
          ),
        ],
      ),
    );
  }
}

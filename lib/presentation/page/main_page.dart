import 'package:flutter/material.dart';

import '../../ui/resource/movie_db_icons.dart';
import '../../ui/resource/ui_colors.dart';
import 'favorite_page.dart';
import 'home_page.dart';
import 'map_page.dart';
import 'popular_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  static const String routeName = 'main-page';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Widget> _childPage = <Widget>[
    const HomePage(),
    const PopularPage(),
    const FavoritePage(),
    const MapPage(),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _childPage.elementAt(_selectedIndex)),
      backgroundColor: UiColors.backgroundColor,
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(MovieDBIcons.home),
            label: 'Home',
            backgroundColor: UiColors.black,
          ),
          BottomNavigationBarItem(
            icon: const Icon(MovieDBIcons.popular),
            label: 'Popular',
            backgroundColor: UiColors.black,
          ),
          BottomNavigationBarItem(
            icon: const Icon(MovieDBIcons.favorite),
            label: 'Favorite',
            backgroundColor: UiColors.black,
          ),
          BottomNavigationBarItem(
            icon: const Icon(MovieDBIcons.marker),
            label: 'Map',
            backgroundColor: UiColors.black,
          ),
        ],
        currentIndex: _selectedIndex,
        backgroundColor: UiColors.black,
        selectedItemColor: UiColors.primary,
        unselectedItemColor: UiColors.white,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

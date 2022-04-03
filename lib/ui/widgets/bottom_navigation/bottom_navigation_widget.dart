import 'package:flutter/material.dart';
import 'package:recipes/domain/factories/screen_factory.dart';

class BottomNavigationWidget extends StatefulWidget {
  const BottomNavigationWidget({Key? key}) : super(key: key);
  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  int _selectedTab = 0;
  final _screenFactory = ScreenFactory();

  void onSelectTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedTab,
        children: [
          _screenFactory.makeMainScreen(),
          _screenFactory.makeCategoriesScreen(),
          _screenFactory.makeFavoriteScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        elevation: 0,
        backgroundColor: Colors.green[600],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(.5),
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Main',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
        ],
        onTap: onSelectTab,
      ),
    );
  }
}

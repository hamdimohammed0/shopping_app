

import 'package:flutter/material.dart';
import 'package:shopping_app/screens/cart_screen.dart';
import 'package:shopping_app/screens/favorite_screen.dart';
import 'package:shopping_app/screens/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  final List<Widget> screens =[
   HomeScreen(),
   FavoritesScreen(),
   CartScreen(),
   
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index){
          setState(() {
            currentIndex = index ;
          });
        },
        destinations: [
          NavigationDestination(
            selectedIcon: Icon(Icons.home) ,
            icon: Icon(Icons.home_outlined),
            label: 'Home'),
          NavigationDestination(
            selectedIcon: Icon(Icons.favorite) ,
            icon: Icon(Icons.favorite_outline),
            label: 'Favorites'),
          NavigationDestination(
            selectedIcon: Icon(Icons.shopping_cart) ,
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Cart'),


        ]),

    ) ;
  }
}
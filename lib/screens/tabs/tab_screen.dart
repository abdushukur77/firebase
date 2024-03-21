import 'package:flutter/material.dart';
import 'package:library_app/screens/tabs/products/products_screen.dart';
import 'package:library_app/screens/tabs/profile/profile_screen.dart';
import 'package:library_app/view_model/tab_view_model.dart';
import 'package:provider/provider.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Widget> screens = [ProductsScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[context.watch<TabViewModel>().getIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: context.watch<TabViewModel>().getIndex,
        onTap: (newIndex) {
          context.read<TabViewModel>().changeIndex(newIndex);
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: "Products",
              activeIcon: Icon(
                Icons.shopping_cart,
                color: Colors.blueAccent,
              )),

          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
              activeIcon: Icon(
                Icons.person,
                color: Colors.blueAccent,
              )),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:patch_assesment/features/home/view/cart_page.dart';
import 'package:patch_assesment/features/home/view/discover.dart';
import 'package:patch_assesment/features/home/view/inbox_page.dart';
import 'package:patch_assesment/features/home/view/profile_page.dart';
import 'package:patch_assesment/features/home/view/sell_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _widgetOptions = <Widget>[
    const DiscoverPage(),
    const CartPage(),
    const SellPage(),
    const ProfilePage(),
    const InboxPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
         backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Discover',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              label: 'Sell',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.inbox_outlined),
              label: 'Inbox',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_outlined),
              label: 'Profile',
            ),
          ]),
    );
  }
}

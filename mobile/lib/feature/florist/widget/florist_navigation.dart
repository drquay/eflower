import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/feature/florist/widget/florist_home.dart';
import 'package:flutter_boilerplate/feature/history/widget/history_page.dart';
import 'package:flutter_boilerplate/feature/profile/widget/profile_widget.dart';
import 'package:flutter_boilerplate/feature/shipper/widget/shipper_home.dart';
import 'package:flutter_boilerplate/feature/shipper/widget/shipper_track_status_widget.dart';

class FloristNavigation extends StatefulWidget {
  const FloristNavigation({Key? key}) : super(key: key);

  @override
  State<FloristNavigation> createState() => _FloristNavigation();
}

class _FloristNavigation extends State<FloristNavigation> {
  int _selectedIndex = 0;
  static  final List<Widget> _widgetOptions = <Widget>[
    FloristHome(),
    ProfileWidget()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.post_add_outlined),
            label: 'Đơn hàng',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Tài khoản',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

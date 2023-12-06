import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/feature/profile/widget/profile_widget.dart';
import 'package:flutter_boilerplate/feature/shipper/widget/shipper_home.dart';
import 'package:flutter_boilerplate/feature/shipper/widget/shipper_track_status_widget.dart';

class ShipperNavigation extends StatefulWidget {
  const ShipperNavigation({Key? key}) : super(key: key);

  @override
  State<ShipperNavigation> createState() => _ShipperNavigation();
}

class _ShipperNavigation extends State<ShipperNavigation> {
  int _selectedIndex = 0;
  static  List<Widget> _widgetOptions = <Widget>[
    const ShipperHome(),
    const ProfileWidget()
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

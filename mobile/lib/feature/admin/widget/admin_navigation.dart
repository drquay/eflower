import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/feature/profile/widget/profile_widget.dart';
import 'package:flutter_boilerplate/feature/admin/account_management/widget/account_management_page.dart';
import 'package:flutter_boilerplate/shared/constants/app_theme.dart';

class AdminNavigation extends StatefulWidget {
  const AdminNavigation({Key? key}) : super(key: key);

  @override
  State<AdminNavigation> createState() => _AdminNavigation();
}

class _AdminNavigation extends State<AdminNavigation> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const AccountManagementPage(),
    const AccountManagementPage(),
    const AccountManagementPage(),
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
            icon: Icon(Icons.manage_accounts_outlined,color: Colors.black,),
            label: 'Tài khoản',
            tooltip: 'Tài khoản',
            backgroundColor: AppColors.background,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.reorder_outlined,color: Colors.black),
            label: 'Đơn hàng',
            tooltip: 'Đơn hàng',
            backgroundColor: AppColors.background,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined,color: Colors.black),
            label: 'Sản phẩm',
            tooltip: 'Sản phẩm',
            backgroundColor: AppColors.background,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined,color: Colors.black),
            label: 'Cài đặt',
            tooltip: 'Cài đặt',
            backgroundColor: AppColors.background,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}

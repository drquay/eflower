import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/shared/model/user.dart';
import 'package:flutter_boilerplate/shared/model/user_response.dart';

class UserDataList extends  DataTableSource{
  UserDataList(this._data);

  final UserResponse _data;

  @override
  DataRow? getRow(int index) {
    final user = _data.items[index];
    return DataRow(cells: [
      DataCell(Text((index+1).toString())),
      DataCell(Text(user.username.toString())),
      DataCell(Text(user.phoneNumber.toString())),
    ]);
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => _data.totalItems;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;

}
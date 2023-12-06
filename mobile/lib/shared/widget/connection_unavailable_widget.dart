import 'package:flutter/material.dart';

class ConnectionUnavailableWidget extends StatelessWidget {
  const ConnectionUnavailableWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(child: const Center(child: Text('Đã có lỗi xải ra vui lòng thử lại')));
  }
}

import 'dart:convert';

import 'package:flutter_boilerplate/feature/notification/model/notify_model.dart';
import 'package:flutter_boilerplate/feature/notification/state/notify_state.dart';
import 'package:flutter_boilerplate/shared/util/ui_util.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
final notifyProvider = StateNotifierProvider<NotifyProvider, NotifyState>((ref) {
  return NotifyProvider(ref.read);
});
class NotifyProvider extends StateNotifier<NotifyState> {
  NotifyProvider(this._reader) : super(const NotifyState.empty()) {
    _init();
  }
  final Reader _reader;

  void _init()  {
    const notifyEndpoint = 'notify';
    final channel = IOWebSocketChannel.connect('${dotenv.env['WS_SOCKET']}/$notifyEndpoint');
    channel.stream.listen((message) {
      final Map<String, dynamic> parsedJson = jsonDecode(message);
      final notification = notificationFromJson(parsedJson).copyWith(dateTime:DateTime.now());
      UiUtil.showAppNotification(notification);
      state.when(empty: () {
        final list = <NotifyModel>[notification];
        if (mounted) {
          state = NotifyState.hasNotifications(list);
        }
      }, hasNotifications: (notificationList) {
        final newList = <NotifyModel> [...notificationList, notification];
        if(mounted){
          state = NotifyState.hasNotifications(newList);
        }
      });
    });
  }
}

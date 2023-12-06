import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/feature/notification/model/notify_model.dart';
import 'package:flutter_boilerplate/feature/notification/provider/notify_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class NotificationDrawer extends ConsumerWidget {
  const NotificationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<NotifyModel> notifications = [] ;
    ref.watch(notifyProvider).whenOrNull(hasNotifications:(messages){
      notifications = messages;
    });
    return Drawer(
      //ListView to listdown children of drawer
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          //Drawer header for Heading part of drawer
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blueGrey,
            ),
            child: Text(
              'Thông báo',
              style: TextStyle(fontSize: 26, color: Colors.white),
            ),
          ),
          buildMessageRows(notifications)
          //Child tile of drawer with specified title
        ],
      ),
    );
  }

  Widget buildMessageRows(List<NotifyModel> notifications ){
    if(notifications.isEmpty) return Center(
        child: Text('Chưa có thông báo nào!'),
    );
    return  ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: notifications.length, // Replace with the actual number of messages
      itemBuilder: (BuildContext context, int index) {
        return messageRow(notifications[index]);
      },
    );
  }

  Widget messageRow(NotifyModel notifyModel) {
    String dateAndTimeFormat = DateFormat('yyyy-MM-dd HH:mm:ss').format(notifyModel.dateTime!);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
                text: notifyModel.message,
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 4,),
          timeAndDate(dateAndTimeFormat)
        ],
      )
    );
  }

  Widget timeAndDate(String dateTime) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          dateTime,
          style: const TextStyle(fontSize: 10),
        )
      ],
    );
  }
}

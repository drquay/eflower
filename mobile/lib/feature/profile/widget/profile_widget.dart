import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_boilerplate/feature/florist/provider/home_provider.dart';
import 'package:flutter_boilerplate/feature/profile/widget/profile_list_item_widget.dart';
import 'package:flutter_boilerplate/feature/shipper/widget/list_order_shipped_widget.dart';
import 'package:flutter_boilerplate/l10n/l10n.dart';
import 'package:flutter_boilerplate/shared/constants/enum.dart';
import 'package:flutter_boilerplate/shared/provider/account_provider.dart';
import 'package:flutter_boilerplate/shared/provider/token_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class ProfileWidget extends ConsumerWidget {
  const ProfileWidget({Key? key}) : super(key: key);
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final account = ref.watch(accountProvider);
    final token = ref.watch(tokenProvider);
    var fullName = '';
    var avatar = '';
    var phone = '';
    var viewPayHistoryAble = false;
    token.maybeWhen(
        orElse: () {},
        hasValue: (token) {
          viewPayHistoryAble = token.privileges.contains(Privilege.SHIPPER_PRIVILEGE.name);
        });
    account.maybeWhen(
        loaded: (userResponse) {
          final _account = userResponse.items[0];
          fullName = _account.fullName ?? '';
          avatar = _account.avatar ?? '';
          phone = _account.phoneNumber ?? '';
        },
        orElse: () {});
    final profileInfo = Expanded(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Stack(
              children: <Widget>[
                CircleAvatar(
                  radius: 30,
                  backgroundImage: avatar.isNotEmpty
                      ? NetworkImage(avatar)
                      : const AssetImage('assets/image/flower_default.png')
                          as ImageProvider,
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Text(
            fullName,
          ),
          SizedBox(height: 10),
          Text(
            phone,
          ),
        ],
      ),
    );
    final header = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        profileInfo,
      ],
    );

    return Builder(
      builder: (context) {
        return Scaffold(
          body: Column(
            children: <Widget>[
              SizedBox(height: 10),
              header,
              Expanded(
                child: ListView(
                  children: <Widget>[
                    // ProfileListItem(
                    //   icon: Icons.supervised_user_circle,
                    //   text: 'Privacy',
                    // ),
                    if (viewPayHistoryAble)
                      ProfileListItem(
                        icon: Icons.history,
                        text: 'Lịch Sử',
                        onPressed: () {
                          Get.to(() => ListOrderShipped());
                        },
                      ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(height: 30),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 10,
                    ).copyWith(
                      bottom: 10,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: _widgetLogoutButton(context, ref),
                  )
                ],
              ),
              SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  Widget _widgetLogoutButton(BuildContext context, WidgetRef ref) {
    return ElevatedButton.icon(
      label: Text(context.l10n.log_out),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
          elevation: MaterialStateProperty.all<double>(4),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0)))),
      icon: const Icon(Icons.power_settings_new_outlined),
      onPressed: () {
        ref.read(homeProvider.notifier).logout();
      },
    );
  }
}

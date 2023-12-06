import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/app/provider/app_start_provider.dart';
import 'package:flutter_boilerplate/feature/admin/widget/admin_navigation.dart';
import 'package:flutter_boilerplate/feature/auth/widget/sign_in_page.dart';
import 'package:flutter_boilerplate/feature/florist/widget/florist_home.dart';
import 'package:flutter_boilerplate/feature/florist/widget/florist_navigation.dart';
import 'package:flutter_boilerplate/feature/notification/provider/notify_provider.dart';
import 'package:flutter_boilerplate/feature/shipper/widget/shipper_navigation.dart';
import 'package:flutter_boilerplate/shared/widget/connection_unavailable_widget.dart';
import 'package:flutter_boilerplate/shared/widget/loading_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppStartPage extends ConsumerWidget {
  const AppStartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(appStartProvider);
    final notifications = ref.watch(notifyProvider);
    return state.maybeWhen(
      initial: () => const LoadingWidget(),
      floristAuthenticated: () =>  FloristNavigation(),
      shipperAuthenticated: () =>  ShipperNavigation(),
      adminAuthenticated: () =>  AdminNavigation(),
      unauthenticated: () => SignInPage(),
      internetUnAvailable: () => const ConnectionUnavailableWidget(),
      orElse: () => const LoadingWidget(),
    );
  }
}

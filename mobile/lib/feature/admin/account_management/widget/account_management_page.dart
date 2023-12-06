import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/feature/admin/account_management/data_mapping/user_data_list.dart';
import 'package:flutter_boilerplate/feature/admin/account_management/provider/account_mangament_provider.dart';
import 'package:flutter_boilerplate/feature/admin/account_management/repository/account_management_repository_provider.dart';
import 'package:flutter_boilerplate/feature/admin/account_management/widget/edit_profile.dart';
import 'package:flutter_boilerplate/feature/florist/model/order.dart';
import 'package:flutter_boilerplate/feature/shipper/widget/order_to_ship_list_row_widget.dart';
import 'package:flutter_boilerplate/l10n/l10n.dart';
import 'package:flutter_boilerplate/shared/http/app_exception.dart';
import 'package:flutter_boilerplate/shared/model/order_response_model.dart';
import 'package:flutter_boilerplate/shared/model/user.dart';
import 'package:flutter_boilerplate/shared/model/user_response.dart';
import 'package:flutter_boilerplate/shared/widget/connection_unavailable_widget.dart';
import 'package:flutter_boilerplate/shared/widget/loading_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class AccountManagementPage extends ConsumerWidget {
  const AccountManagementPage({Key? key}) : super(key: key);
  static const int _rowPerPage = 10;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            await ref
                .read(accountManagementProvider.notifier)
                .getListAccount(page: 0, size: _rowPerPage);
          },
          child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    pinned: true,
                    floating: true,
                    title: Text(context.l10n.account_management_page),
                  ),
                ];
              },
              body: TabBarView(
                children: [
                  _tableDateWidget(ref),
                ],
              )),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }

  Widget _tableDateWidget(WidgetRef ref) {
    final accountMmt = ref.watch(accountManagementProvider);
    return accountMmt.when(loading: () {
      return const LoadingWidget();
    }, loaded: (userResponse) {
      return Column(children: [
        DataTable(
          onSelectAll: (val) {},
          rows: getRows(userResponse),
          columns: const [
            DataColumn(label: Text('STT')),
            DataColumn(label: Text('Tên đăng nhập')),
            DataColumn(label: Text('Số điện thoại')),
            DataColumn(label: Text('Chỉnh sửa'))
          ],
          columnSpacing: 30,
          horizontalMargin: 10,
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
                '${(userResponse.currentPage - 1) * _rowPerPage + 1} - ${(userResponse.currentPage - 1) * _rowPerPage + userResponse.items.length} of ${userResponse.totalItems}'),
            const SizedBox(
              width: 20,
            ),
            IconButton(
                onPressed: (userResponse.currentPage <= 1)
                    ? null
                    : () async {
                        //previous page
                        await ref
                            .read(accountManagementProvider.notifier)
                            .getListAccount(page: 0, size: _rowPerPage);
                      },
                icon: const Icon(Icons.first_page_outlined)),
            IconButton(
                onPressed: (userResponse.currentPage <= 1)
                    ? null
                    : () async {
                        //previous page
                        await ref
                            .read(accountManagementProvider.notifier)
                            .getListAccount(
                                page: userResponse.currentPage - 2,
                                size: _rowPerPage);
                      },
                icon: const Icon(Icons.navigate_before_outlined)),
            IconButton(
                onPressed: (userResponse.currentPage >= userResponse.totalPages)
                    ? null
                    : () async {
                        //next page
                        await ref
                            .read(accountManagementProvider.notifier)
                            .getListAccount(
                                page: userResponse.currentPage,
                                size: _rowPerPage);
                      },
                icon: const Icon(Icons.navigate_next_outlined)),
            IconButton(
                onPressed: (userResponse.currentPage >= userResponse.totalPages)
                    ? null
                    : () async {
                        //previous page
                        await ref
                            .read(accountManagementProvider.notifier)
                            .getListAccount(
                                page: userResponse.totalPages - 1,
                                size: _rowPerPage);
                      },
                icon: const Icon(Icons.last_page_outlined)),
          ],
        ),
      ]);
    }, error: (error) {
      return const ConnectionUnavailableWidget();
    });
  }

  List<DataRow> getRows(UserResponse userResponse) {
    final lists = <DataRow>[];
    for (var i = 0; i < userResponse.items.length; i++) {
      final dataRow = getRow(userResponse, i);
      lists.add(dataRow);
    }
    return lists;
  }

  DataRow getRow(UserResponse userResponse, int index) {
    final user = userResponse.items[index];
    final stt = (userResponse.currentPage - 1) * _rowPerPage + index + 1;
    return DataRow(cells: [
      DataCell(Text(stt.toString())),
      DataCell(Text(user.username.toString())),
      DataCell(Text(user.phoneNumber.toString())),
      DataCell(IconButton(
        icon: const Icon(Icons.edit_outlined),
        onPressed: () {
          Get.to(() => EditProfileUI(userName:user.username.toString()));
        },
      ))
    ]);
  }

  Widget _tab(String name, int numberOrders) {
    return Tab(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: name,
          children: [
            TextSpan(
              text: ' ($numberOrders)',
              style: const TextStyle(color: Colors.red),
            )
          ],
        ),
      ),
    );
  }
}

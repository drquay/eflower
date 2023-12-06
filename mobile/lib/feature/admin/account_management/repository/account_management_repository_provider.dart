import 'package:flutter_boilerplate/app/state/app_start_state.dart';
import 'package:flutter_boilerplate/feature/florist/provider/home_provider.dart';
import 'package:flutter_boilerplate/shared/http/api_provider.dart';
import 'package:flutter_boilerplate/shared/http/api_response.dart';
import 'package:flutter_boilerplate/shared/http/app_exception.dart';
import 'package:flutter_boilerplate/shared/model/user.dart';
import 'package:flutter_boilerplate/shared/model/user_response.dart';
import 'package:flutter_boilerplate/shared/state/account_state.dart';
import 'package:flutter_boilerplate/shared/util/ui_util.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class AccountManagementRepositoryProtocol {
  Future<void> getListAccount({int? page, int? size});
  Future<void> updateAccount(User user);
}

final accountManagementRepositoryProvider =
    Provider((ref) => AccountManagementRepository(ref.read));

class AccountManagementRepository
    implements AccountManagementRepositoryProtocol {
  AccountManagementRepository(this._reader);

  late final ApiProvider _api = _reader(apiProvider);
  final Reader _reader;

  @override
  Future<AccountState> getListAccount({int? page, int? size}) async {
    final APIResponse response;
    if (page != null && size != null) {
      response = await _api.get('accounts?page=$page&size=$size');
    } else {
      response = await _api.get('accounts');
    }
    await response.when(
      success: (success) {},
      error: (error) async {
        if (error is AppExceptionUnauthorized) {
           await _reader(homeProvider.notifier).logout();
          UiUtil.showAppExceptionFromBottom(
              const AppException.errorWithMessage('Phiên đăng nhâp hết hạn'));
        } else {
          UiUtil.showAppExceptionFromBottom(
              const AppException.errorWithMessage('Đã có lỗi xảy ra'));
        }
      },
    );
    if (response is APISuccess) {
      final value = response.value;
      try {
        final _account = userResponseFromJson(value);
        return AccountState.loaded(_account);
      } catch (e) {
        UiUtil.showAppExceptionFromBottom(
            AppException.errorWithMessage('Đã có lỗi xảy ra'));
      }
    }
    return const AccountState.loading();
  }

  @override
  Future<void> updateAccount(User user) async {
    final APIResponse response;
    response = await _api.put('accounts/${user.id}', user.toJson());
    await response.when(
      success: (success) {},
      error: (error) async {
        if (error is AppExceptionUnauthorized) {
          await _reader(homeProvider.notifier).logout();
          UiUtil.showAppExceptionFromBottom(
              const AppException.errorWithMessage('Phiên đăng nhâp hết hạn'));
        } else {
          UiUtil.showAppExceptionFromBottom(
              const AppException.errorWithMessage('Đã có lỗi xảy ra'));
        }
      },
    );
    if (response is APISuccess) {
      //TODO: Cap nhat thanh cong
      UiUtil.showSuccessMessage('Cập nhật thành công');
    }else{
      UiUtil.showAppExceptionFromBottom(
          const AppException.errorWithMessage('Cập nhật thất bại'));
    }
  }
}

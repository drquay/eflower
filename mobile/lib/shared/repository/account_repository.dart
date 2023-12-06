import 'package:flutter_boilerplate/feature/florist/provider/home_provider.dart';
import 'package:flutter_boilerplate/shared/http/api_provider.dart';
import 'package:flutter_boilerplate/shared/http/api_response.dart';
import 'package:flutter_boilerplate/shared/http/app_exception.dart';
import 'package:flutter_boilerplate/shared/model/user.dart';
import 'package:flutter_boilerplate/shared/model/user_response.dart';
import 'package:flutter_boilerplate/shared/state/account_state.dart';
import 'package:flutter_boilerplate/shared/util/ui_util.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class AccountRepositoryProtocol {
  Future<AccountState> getAccount({required String userName});
  Future<UserResponse?> getListAccount({int? page, int? size});
}

final accountRepositoryProvider =
    Provider((ref) => AccountRepository(ref.read));

class AccountRepository implements AccountRepositoryProtocol {
  AccountRepository(this._reader);

  late final ApiProvider _api = _reader(apiProvider);
  final Reader _reader;

  @override
  Future<AccountState> getAccount({required String userName}) async {
    final response = await _api.get('accounts?username=$userName');
    response.when(
      success: (success) {},
      error: (error) {
        if (error is AppExceptionUnauthorized) {
          _reader(homeProvider.notifier).logout();
          UiUtil.showAppExceptionFromBottom(
              const AppException.errorWithMessage('Phiên đăng nhâp hết hạn'));
        } else {
          UiUtil.showAppExceptionFromBottom(
              const AppException.errorWithMessage('Đã có lỗi xảy ra'));
        }
        return AccountState.error(error);
      },
    );
    if (response is APISuccess) {
      final value = response.value;
      try {
        final _account = userResponseFromJson(value);

        return AccountState.loaded(_account);
      } catch (e) {
        return AccountState.error(AppException.errorWithMessage(e.toString()));
      }
    } else if (response is APIError) {
      return AccountState.error(response.exception);
    } else {
      return const AccountState.loading();
    }
  }

  @override
  Future<UserResponse?> getListAccount({int? page, int? size})async {
    final APIResponse response;
    if(page != null && size != null){
        response = await _api.get('accounts?page=$page&size=$size' );
    }else{
      response = await _api.get('accounts');
    }
    response.when(
      success: (success) {},
      error: (error) {
        UiUtil.showAppExceptionFromBottom(AppException.errorWithMessage('Đã có lỗi xảy ra'));
      },
    );
    if (response is APISuccess) {
      final value = response.value;
      try {
        final _account = userResponseFromJson(value);
        return _account;
      } catch (e) {
        UiUtil.showAppExceptionFromBottom(AppException.errorWithMessage('Đã có lỗi xảy ra'));
      }
    }
    return null;
  }
}

import 'dart:async';
import 'dart:io';

import 'package:flutter_boilerplate/app/provider/app_start_provider.dart';
import 'package:flutter_boilerplate/app/state/app_start_state.dart';
import 'package:flutter_boilerplate/feature/admin/account_management/repository/account_management_repository_provider.dart';
import 'package:flutter_boilerplate/feature/florist/provider/home_provider.dart';
import 'package:flutter_boilerplate/shared/model/user.dart';
import 'package:flutter_boilerplate/shared/model/user_response.dart';
import 'package:flutter_boilerplate/shared/repository/account_repository.dart';
import 'package:flutter_boilerplate/shared/repository/image_handler_repository.dart';
import 'package:flutter_boilerplate/shared/repository/token_repository.dart';
import 'package:flutter_boilerplate/shared/state/account_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final accountManagementProvider =
    StateNotifierProvider<AccountManagementProvider, AccountState>((ref) {
  final appStartState = ref.watch(appStartProvider);
  return AccountManagementProvider(ref.read, appStartState);
});

class AccountManagementProvider extends StateNotifier<AccountState> {
  AccountManagementProvider(this._reader, this._appStartState)
      : super(const AccountState.loading()) {
    _init();
  }
  final Reader _reader;
  late final AccountManagementRepository _repository =
      _reader(accountManagementRepositoryProvider);
  late final ImageHandlerRepository _imageHandlerRepository =
      _reader(imageHandlerRepositoryProvider);
  final int _defaultPage = 0;
  final int _rowPerPage = 10;
  Timer? _timer;
  final AppStartState _appStartState;
  Future<void> _init() async {
    _appStartState.whenOrNull(
      adminAuthenticated: () {
        getListAccount();
        initTimer();
      },
      unauthenticated: () {
        _timer?.cancel();
      },
    );
  }

  Timer initTimer() {
    if (_timer == null) {
      _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
        getListAccount();
        if (_appStartState is Unauthenticated) {
          _timer?.cancel();
        }
      });
    }

    return _timer!;
  }

  Future<void> getListAccount({int? page, int? size}) async {
    if (page != null && size != null) {
      if (mounted) {
        state = await _repository.getListAccount(page: page, size: size);
      }
    } else {
      if (mounted) {
        state = await _repository.getListAccount(
            page: _defaultPage, size: _rowPerPage);
      }
    }
  }

  Future<String?> updateAvatar(File file) async {
    final url = await _imageHandlerRepository.uploadImage(file);
    return url;
  }

  Future<void> updateAccount(User user) async {
    if (mounted) {
      state = const AccountState.loading();
      if (mounted) {
        await _repository.updateAccount(user);
      }
    }
  }
}

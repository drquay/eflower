import 'dart:async';

import 'package:flutter_boilerplate/app/provider/app_start_provider.dart';
import 'package:flutter_boilerplate/app/state/app_start_state.dart';
import 'package:flutter_boilerplate/shared/model/user.dart';
import 'package:flutter_boilerplate/shared/model/user_response.dart';
import 'package:flutter_boilerplate/shared/repository/account_repository.dart';
import 'package:flutter_boilerplate/shared/repository/token_repository.dart';
import 'package:flutter_boilerplate/shared/state/account_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final accountProvider =
    StateNotifierProvider<AccountProvider, AccountState>((ref) {
  final appStartState = ref.watch(appStartProvider);

  return AccountProvider(ref.read, appStartState);
});

class AccountProvider extends StateNotifier<AccountState> {
  AccountProvider(this._reader, this._appStartState)
      : super(const AccountState.loading()) {
    _init();
  }

  final Reader _reader;
  final AppStartState _appStartState;

  late final AccountRepository _repository = _reader(accountRepositoryProvider);
  late final TokenRepository _tokenRepository =
      _reader(tokenRepositoryProvider);

  Future<void> _init() async {
    await _appStartState.maybeWhen(
        floristAuthenticated: () async {
          final token = await _tokenRepository.fetchToken();
          if (token != null) {
            await getAccount(userName: token.username);
          }
        },
        shipperAuthenticated: () async {
          final token = await _tokenRepository.fetchToken();
          if (token != null) {
            await getAccount(userName: token.username);
          }
        },
        orElse: () {});
  }

  Future<void> getAccount({required String userName}) async {
    final response = await _repository.getAccount(userName: userName);
    if (mounted) {
      state = response;
    }
  }
  Future<UserResponse?> getAccountWithoutState({required String userName}) async {
    final response = await _repository.getAccount(userName: userName);
    UserResponse? userResponse = null;
    response.whenOrNull(loaded: (res){userResponse = res;});
    return userResponse;
  }

  Future<UserResponse?> getListAccount({int? page, int? size}) async{
    final UserResponse? response;
    if(page != null && size !=null){
      response = await _repository.getListAccount(page: page, size: size);
    }
    else{
      response =  await _repository.getListAccount();
    }

    return response;
  }
}

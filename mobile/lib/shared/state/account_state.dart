import 'package:flutter_boilerplate/shared/http/app_exception.dart';
import 'package:flutter_boilerplate/shared/model/user.dart';
import 'package:flutter_boilerplate/shared/model/user_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_state.freezed.dart';

@freezed
class AccountState with _$AccountState {
  const factory AccountState.loading() = _Loading;
  const factory AccountState.loaded(UserResponse userResponse) = _Loaded;
  const factory AccountState.error(AppException error) = _Error;
}
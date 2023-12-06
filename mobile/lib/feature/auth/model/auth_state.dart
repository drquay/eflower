import 'package:flutter_boilerplate/shared/http/app_exception.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = Initial;
  const factory AuthState.loading() = Loading;
  const factory AuthState.floristLoggedIn() = FloristLoggedIn;
  const factory AuthState.shipperLoggedIn() = ShipperLoggedIn;
  const factory AuthState.adminLoggedIn() = AdminLoggedIn;
  const factory AuthState.error(AppException error) = Error;
}

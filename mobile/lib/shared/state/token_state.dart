import 'package:flutter_boilerplate/shared/http/app_exception.dart';
import 'package:flutter_boilerplate/shared/model/token.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_state.freezed.dart';

@freezed
class TokenState with _$TokenState {
  const factory TokenState.loading() = _Loading;
  const factory TokenState.hasValue(Token token) = _HasValue;
  const factory TokenState.empty(AppException error) = _Empty;
}
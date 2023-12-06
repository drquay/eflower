import 'package:flutter_boilerplate/feature/auth/model/auth_state.dart';
import 'package:flutter_boilerplate/shared/constants/enum.dart';
import 'package:flutter_boilerplate/shared/http/api_provider.dart';
import 'package:flutter_boilerplate/shared/http/app_exception.dart';
import 'package:flutter_boilerplate/shared/model/token.dart';
import 'package:flutter_boilerplate/shared/repository/token_repository.dart';
import 'package:flutter_boilerplate/shared/util/validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class AuthRepositoryProtocol {
  Future<AuthState> login(String email, String password);
}

final authRepositoryProvider = Provider((ref) => AuthRepository(ref.read));

class AuthRepository implements AuthRepositoryProtocol {
  AuthRepository(this._reader);

  late final ApiProvider _api = _reader(apiProvider);
  final Reader _reader;

  @override
  Future<AuthState> login(String username, String password) async {
    if (!Validator.isUsername(username)) {
      return AuthState.error(
        AppException.errorWithMessage('Vui lòng điền tên đăng nhập'),
      );
    }
    if (!Validator.isValidPassWord(password)) {
      return AuthState.error(
        AppException.errorWithMessage('Mật khẩu tối thiểu 5 ký tự'),
      );
    }
    final params = {
      'username': username,
      'password': password,
    };
    final loginResponse = await _api.post('auth/signin', params);

    return loginResponse.when(
      success: (success) async {
        final tokenRepository = _reader(tokenRepositoryProvider);

        final token = Token.fromJson(success);
        if (token.privileges.contains(Privilege.ADMINISTRATOR_PRIVILEGE.name)) {
          await tokenRepository.saveToken(token);

          return  AuthState.adminLoggedIn();
        }
        if (token.privileges.contains(Privilege.SHIPPER_PRIVILEGE.name)) {
          await tokenRepository.saveToken(token);

          return  AuthState.shipperLoggedIn();
        }
        if (token.privileges.contains(Privilege.FLORIST_PRIVILEGE.name)) {
          await tokenRepository.saveToken(token);

          return  AuthState.floristLoggedIn();
        }

        return AuthState.error(AppException.errorWithMessage(
            'Vài trò của tài khoản này không hợp lệ'));
      },
      error: (error) {
        if (error == AppException.unauthorized()) {
          return AuthState.error(AppException.errorWithMessage(
              'Tài khoản hoặc mật khẩu không chính xác'));
        }

        return error == AppException.connectivity()
            ? AuthState.error(
                AppException.errorWithMessage('Vui lòng kiểm tra kết nối mạng'))
            : AuthState.error(
                AppException.errorWithMessage('Lỗi không xác định'));
      },
    );
  }
}

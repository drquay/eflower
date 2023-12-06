import 'package:flutter_boilerplate/app/state/app_start_state.dart';
import 'package:flutter_boilerplate/feature/auth/model/auth_state.dart';
import 'package:flutter_boilerplate/feature/auth/provider/auth_provider.dart';
import 'package:flutter_boilerplate/feature/florist/provider/home_provider.dart';
import 'package:flutter_boilerplate/feature/florist/state/home_state.dart';
import 'package:flutter_boilerplate/shared/constants/enum.dart';
import 'package:flutter_boilerplate/shared/repository/token_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appStartProvider =
    StateNotifierProvider<AppStartNotifier, AppStartState>((ref) {
  final loginState = ref.watch(authProvider);
  final homeState = ref.watch(homeProvider);

  late AppStartState appStartState;
  appStartState = loginState is FloristLoggedIn
      ? AppStartState.floristAuthenticated()
      : AppStartState.initial();
  appStartState = loginState is ShipperLoggedIn
      ? AppStartState.shipperAuthenticated()
      : AppStartState.initial();
  appStartState = loginState is AdminLoggedIn
      ? AppStartState.adminAuthenticated()
      : AppStartState.initial();

  return AppStartNotifier(appStartState, ref.read, loginState, homeState);
});

class AppStartNotifier extends StateNotifier<AppStartState> {
  AppStartNotifier(AppStartState appStartState, this._reader, this._authState,
      this._homeState)
      : super(appStartState) {
    _init();
  }

  late final TokenRepository _tokenRepository =
      _reader(tokenRepositoryProvider);
  final AuthState _authState;
  final HomeState _homeState;
  final Reader _reader;

  Future<void> _init() async {
    // _authState.maybeWhen(
    //     floristLoggedIn: () {
    //       if (mounted) {
    //         state = AppStartState.floristAuthenticated();
    //       }
    //     },
    //     shipperLoggedIn: () {
    //       if (mounted) {
    //         state = AppStartState.shipperAuthenticated();
    //       }
    //     },
    //     orElse: () {});
    _homeState.maybeWhen(
        loggedOut: () {
          if (mounted) {
            state = AppStartState.unauthenticated();
          }
        },
        orElse: () {});
    try {
      final token = await _tokenRepository.fetchToken();
      if (token != null) {
        if (token.privileges.contains(Privilege.FLORIST_PRIVILEGE.name)) {
          if (mounted) {
            state = AppStartState.floristAuthenticated();
          }
        }
        if (token.privileges.contains(Privilege.SHIPPER_PRIVILEGE.name)) {
          if (mounted) {
            state = AppStartState.shipperAuthenticated();
          }
        }
        if (token.privileges.contains(Privilege.ADMINISTRATOR_PRIVILEGE.name)) {
          if (mounted) {
            state = AppStartState.adminAuthenticated();
          }
        }
      } else {
        if (mounted && !(state is Unauthenticated)) {
          state = AppStartState.unauthenticated();
        }
      }
    } catch (e) {
      await _tokenRepository.remove();
    }
  }
}

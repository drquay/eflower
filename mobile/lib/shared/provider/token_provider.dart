
import 'package:flutter_boilerplate/app/provider/app_start_provider.dart';
import 'package:flutter_boilerplate/app/state/app_start_state.dart';
import 'package:flutter_boilerplate/feature/florist/provider/home_provider.dart';
import 'package:flutter_boilerplate/feature/florist/state/orders_state.dart';
import 'package:flutter_boilerplate/shared/http/app_exception.dart';
import 'package:flutter_boilerplate/shared/model/token.dart';
import 'package:flutter_boilerplate/shared/repository/token_repository.dart';
import 'package:flutter_boilerplate/shared/state/token_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tokenProvider = StateNotifierProvider<TokenProvider,TokenState>((ref) {
  final appStartState = ref.watch(appStartProvider);

  return TokenProvider(ref.read,appStartState);
});

class TokenProvider extends StateNotifier<TokenState>{
  TokenProvider(this._reader,this._appStartState) : super(const TokenState.loading()){
    _init();
  }

  final Reader _reader;
  final AppStartState _appStartState;
  late final TokenRepository _tokenRepository= _reader(tokenRepositoryProvider);
  Future<void> _init() async {
    _appStartState.maybeWhen(
        floristAuthenticated: () {
          fetchToken();
        },
        shipperAuthenticated: (){
          fetchToken();
        },
        orElse: () {});
  }
  Future<void> fetchToken() async {
    final response = await _tokenRepository.fetchToken();
    if(response==null) {
      await _reader(homeProvider.notifier).logout();
    } else
    if (mounted) {
      state = TokenState.hasValue(response);
    }
  }

}
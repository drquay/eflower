import 'package:flutter_boilerplate/feature/florist/state/home_state.dart';
import 'package:flutter_boilerplate/shared/repository/token_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

final homeProvider = StateNotifierProvider<HomeProvider, HomeState>((ref) {
  return HomeProvider(ref.read);
});

class HomeProvider extends StateNotifier<HomeState> {
  HomeProvider(this._reader) : super(const HomeState.loading());
  final Reader _reader;
  late final TokenRepository _tokenRepository =
      _reader(tokenRepositoryProvider);

  Future<void> logout() async {
    await _tokenRepository.remove();
    if(mounted ){
      await Get.deleteAll();
      state =  HomeState.loggedOut();
    }
  }
}

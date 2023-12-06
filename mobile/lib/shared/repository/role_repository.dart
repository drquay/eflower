import 'package:flutter_boilerplate/shared/constants/store_key.dart';
import 'package:flutter_boilerplate/shared/util/platform_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/role.dart';

abstract class RoleRepositoryProtocol {
  Future<void> remove();
  Future<void> saveRole(Role role);
  Future<Role?> fetchRole();
}

final roleRepositoryProvider = Provider<RoleRepository>((ref) {
  return RoleRepository(ref.read);
});

class RoleRepository implements RoleRepositoryProtocol {
  RoleRepository(this._reader);

  late final PlatformType _platform = _reader(platformTypeProvider);
  final Reader _reader;
  Role? _role;

  @override
  Future<Role?> fetchRole() async {
    
    String? roleValue;

    if (_platform == PlatformType.iOS ||
        _platform == PlatformType.android ||
        _platform == PlatformType.linux) {
      const storage = FlutterSecureStorage();
      roleValue = await storage.read(key: StoreKey.role.toString());
    } else {
      final prefs = await SharedPreferences.getInstance();
      roleValue = prefs.getString(StoreKey.role.toString());
    }
    try {
      if (roleValue != null) {
        _role = roleFromJson(roleValue);
      }
    } on Exception catch (e) {
      return _role;
    }
    return _role;
  }

  @override
  Future<void> remove()  async{
    _role = null;
    final prefs = await SharedPreferences.getInstance();

    if (_platform == PlatformType.iOS ||
        _platform == PlatformType.android ||
        _platform == PlatformType.linux) {
      const storage = FlutterSecureStorage();
      try {
        await storage.delete(key: StoreKey.role.toString());
      } on Exception catch (e) {}
    } else {
      await prefs.remove(StoreKey.role.toString());
    }

    await prefs.remove(StoreKey.username.toString());
  }

  @override
  Future<void> saveRole(Role role) async {
    final prefs = await SharedPreferences.getInstance();
    _role = role;
    if (_platform == PlatformType.iOS ||
        _platform == PlatformType.android ||
        _platform == PlatformType.linux) {
      const storage = FlutterSecureStorage();
      try {
        await storage.write(
            key: StoreKey.role.toString(), value: roleToJson(role));
      } on Exception catch (e) {}
    } else {
      await prefs.setString(StoreKey.role.toString(), roleToJson(role));
    }
  }

}

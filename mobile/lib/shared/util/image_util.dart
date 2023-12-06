import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:flutter_boilerplate/gen/assets.gen.dart';

class ImageUtil {
  static const base64Prefix = ';base64,';

  static String? _removePrefix(String? base64String) {
    if (base64String == null) return null;

    return base64String
        .substring(base64String.indexOf(base64Prefix) + base64Prefix.length);
  }

  static Image imageFromBase64String(String? base64String) {
    final s = _removePrefix(base64String);
    if (s == null) return Assets.image.flowerDefault.image();

    return Image.memory(base64Decode(s));
  }

  static AssetImage defaultImage() {
    return AssetImage(Assets.image.flowerDefault.path);
  }

  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  static Uint8List base64StringForImage(String base64String) {
    final s = _removePrefix(base64String);

    return base64Decode(s!);
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }
}

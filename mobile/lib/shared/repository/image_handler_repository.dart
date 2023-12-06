import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_boilerplate/shared/http/api_provider.dart';
import 'package:flutter_boilerplate/shared/http/api_response.dart';
import 'package:flutter_boilerplate/shared/http/app_exception.dart';
import 'package:flutter_boilerplate/shared/model/user.dart';
import 'package:flutter_boilerplate/shared/model/user_response.dart';
import 'package:flutter_boilerplate/shared/state/account_state.dart';
import 'package:flutter_boilerplate/shared/util/ui_util.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';

abstract class ImageHandlerRepositoryProtocol {
  Future<String?> uploadImage(File file);

}

final imageHandlerRepositoryProvider =
    Provider((ref) => ImageHandlerRepository(ref.read));

class ImageHandlerRepository implements ImageHandlerRepositoryProtocol {
  ImageHandlerRepository(this._reader);

  late final ApiProvider _api = _reader(apiProvider);
  final Reader _reader;
  @override
  Future<String?> uploadImage(File file) async {
    final fileName = basename(file.path);
    Map<String, MultipartFile> multipartFiles = {};
    multipartFiles['file'] =
        MultipartFile(file.openRead(), await file.length(), filename: fileName);
    final formData = FormData.fromMap(multipartFiles);

    final response = await _api.post('', formData,
        newBaseUrl: dotenv.env['UPLOAD_IMAGE_URL']!,
        contentType: ContentType.multipart);

    if (response is APISuccess) {
      final value = response.value;
      try {
        final imageUrl = value['link'];

        return imageUrl;
      } catch (e) {
        return null;
      }
    }
    return null;
  }

}

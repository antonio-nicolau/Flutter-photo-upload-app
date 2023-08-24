import 'dart:developer';

import 'package:wisy_image_uploader/src/core/model/photo.model.dart';
import 'package:wisy_image_uploader/src/core/repositories/photos.repository.interface.dart';
import 'package:wisy_image_uploader/src/core/services/photos.service.interface.dart';

class PhotosService implements IPhotosService {
  final IPhotosRepository _repository;

  const PhotosService(this._repository);

  @override
  Future<bool> create(Photo photo) async {
    try {
      return _repository.create(photo);
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  @override
  Stream<List<Photo>> getAll() {
    return _repository.getAll();
  }
}

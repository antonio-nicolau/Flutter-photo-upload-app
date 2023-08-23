import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wisy_image_uploader/src/core/model/photo.model.dart';
import 'package:wisy_image_uploader/src/core/repositories/photos.repository.interface.dart';
import 'package:wisy_image_uploader/src/core/services/photos.service.dart';

class PhotosService implements IPhotosService {
  final IPhotosRepository _repository;

  PhotosService(this._repository);

  @override
  Future<void> create(Photo photo) async {
    _repository.create(photo);
  }

  @override
  Stream<QuerySnapshot<Photo>> getAll() {
    return _repository.getAll();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wisy_image_uploader/src/core/model/photo.model.dart';
import 'package:wisy_image_uploader/src/core/repositories/photos.repository.dart';

final photosRepositoryProvider = Provider<IPhotosRepository>((ref) {
  return PhotosRepository(FirebaseFirestore.instance);
});

abstract class IPhotosRepository {
  Future<bool> create(Photo photo);
  Stream<List<Photo>> getAll();
}

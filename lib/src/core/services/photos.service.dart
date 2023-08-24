import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wisy_image_uploader/src/core/model/photo.model.dart';
import 'package:wisy_image_uploader/src/core/repositories/photos.repository.interface.dart';
import 'package:wisy_image_uploader/src/core/services/photos.service.interface.dart';

final photosServiceProvider = Provider<IPhotosService>((ref) {
  final repository = ref.read(photosRepositoryProvider);
  return PhotosService(repository);
});

abstract class IPhotosService {
  Future<void> create(Photo photo);
  Stream<List<Photo>> getAll();
}

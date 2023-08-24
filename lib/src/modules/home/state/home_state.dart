import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wisy_image_uploader/src/core/model/photo.model.dart';
import 'package:wisy_image_uploader/src/core/services/photos.service.dart';

final allPhotosProvider = StreamProvider<List<Photo>>((ref) {
  return ref.read(photosServiceProvider).getAll();
});

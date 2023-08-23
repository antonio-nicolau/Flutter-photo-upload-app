import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wisy_image_uploader/src/core/model/photo.model.dart';

abstract class IPhotosRepository {
  Future<void> create(Photo photo);
  Stream<QuerySnapshot<Photo>> getAll();
}

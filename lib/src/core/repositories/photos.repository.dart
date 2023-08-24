import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wisy_image_uploader/src/core/model/photo.model.dart';
import 'package:wisy_image_uploader/src/core/repositories/photos.repository.interface.dart';

class PhotosRepository implements IPhotosRepository {
  final FirebaseFirestore _firestore;

  const PhotosRepository(this._firestore);

  @override
  Future<bool> create(Photo photo) async {
    final reference = await _firestore.collection('photos').add(photo.toMap());

    if (reference.id.isNotEmpty) {
      return true;
    } else {
      throw Exception();
    }
  }

  @override
  Stream<List<Photo>> getAll() {
    final reference = _firestore
        .collection('photos')
        .withConverter(
          fromFirestore: Photo.fromFirestore,
          toFirestore: (Photo photo, _) => photo.toMap(),
        )
        .snapshots();

    return reference.asyncMap((event) => event.docs.map((e) => e.data()).toList());
  }
}

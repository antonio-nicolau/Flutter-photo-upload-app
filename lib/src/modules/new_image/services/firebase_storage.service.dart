import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:wisy_image_uploader/src/modules/new_image/services/remote_storage.service.interface.dart';

class FirebaseCloudStorage implements RemoteStorage {
  final FirebaseStorage _instance;
  const FirebaseCloudStorage(this._instance);

  @override
  Future<String?> upload(File file) async {
    final imagesRef = _instance.ref().child(file.uri.pathSegments.last);

    try {
      await imagesRef.putFile(file);
      return imagesRef.getDownloadURL();
    } catch (e) {
      print(e.toString());
    }

    return imagesRef.fullPath;
  }
}

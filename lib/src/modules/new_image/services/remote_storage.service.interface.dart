import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wisy_image_uploader/src/modules/new_image/services/firebase_storage.service.dart';

final remoteStorageProvider = Provider<RemoteStorage>((ref) {
  return FirebaseCloudStorage(FirebaseStorage.instance);
});

abstract class RemoteStorage {
  Future<String?> upload(File file);
}

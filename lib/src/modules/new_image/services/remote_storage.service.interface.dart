import 'dart:io';

abstract class IRemoteStorage {
  Future<String?> upload(File file);
}

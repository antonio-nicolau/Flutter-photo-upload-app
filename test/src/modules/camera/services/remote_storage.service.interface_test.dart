import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wisy_image_uploader/src/modules/camera/services/remote_storage.service.interface.dart';
import 'remote_storage.service.interface_test.mocks.dart';

@GenerateMocks([RemoteStorage])
void main() {
  late RemoteStorage remoteStorage;
  late File file;

  setUp(() {
    remoteStorage = MockRemoteStorage();
    file = File('fakePath');
  });

  group('RemoteStorage Tests', () {
    test('Should upload file', () async {
      const fakeDownloadUrl = 'https://example.com/image.jpg';
      when(remoteStorage.upload(file)).thenAnswer((_) async => fakeDownloadUrl);

      final downloadUrl = await remoteStorage.upload(file);

      verify(remoteStorage.upload(file)).called(1);
      expect(downloadUrl?.isNotEmpty, true);
      expect(downloadUrl, fakeDownloadUrl);
    });

    test('Should not upload file', () async {
      when(remoteStorage.upload(file)).thenAnswer((_) async {
        return null;
      });

      final downloadUrl = await remoteStorage.upload(file);
      verify(remoteStorage.upload(file)).called(1);
      expect(downloadUrl, null);
    });
  });
}

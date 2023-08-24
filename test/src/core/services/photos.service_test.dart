import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wisy_image_uploader/src/core/model/photo.model.dart';
import 'package:wisy_image_uploader/src/core/services/photos.service.dart';
import 'package:wisy_image_uploader/src/core/services/photos.service.interface.dart';
import 'dart:async';
import '../../../mocks/mock_photos.dart';
import '../repositories/photos.repository.interface_test.mocks.dart';

void main() {
  group('PhotosService Tests', () {
    late IPhotosService photosService;
    late MockPhotosRepository mockRepository;
    final photo = mockPhotos.first;

    setUp(() {
      mockRepository = MockPhotosRepository();
      photosService = PhotosService(mockRepository);
    });

    test('create Photo - success', () async {
      // Mock the create method of the repository to succeed
      when(mockRepository.create(photo)).thenAnswer((_) async => true);

      final result = await photosService.create(photo);
      verify(mockRepository.create(photo)).called(1);
      expect(result, true);
    });

    test('create Photo - failure', () async {
      when(mockRepository.create(photo)).thenThrow(Exception());

      final result = await photosService.create(photo);

      verify(mockRepository.create(photo)).called(1);
      expect(result, false);
    });

    test('get all Photos', () {
      when(mockRepository.getAll()).thenAnswer((_) => Stream.value(mockPhotos));

      final result = photosService.getAll();

      expect(result, isA<Stream<List<Photo>>>());
      result.listen((photos) {
        expect(photos, equals(mockPhotos));
      });
    });
  });
}

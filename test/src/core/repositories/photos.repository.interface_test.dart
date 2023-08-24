import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wisy_image_uploader/src/core/model/photo.model.dart';
import 'package:wisy_image_uploader/src/core/repositories/photos.repository.dart';
import 'package:wisy_image_uploader/src/core/repositories/photos.repository.interface.dart';
import '../../../mocks/mock_photos.dart';
import 'photos.repository.interface_test.mocks.dart';

@GenerateMocks([PhotosRepository])
void main() {
  group('IPhotosRepository Tests', () {
    late IPhotosRepository photosRepository;

    setUp(() {
      photosRepository = MockPhotosRepository();
    });

    test('create Photo', () async {
      final photo = mockPhotos.first;
      when(photosRepository.create(photo)).thenAnswer(
        (inv) => Future.value(true),
      );
      final response = await photosRepository.create(photo);

      expect(response, true);
      verify(photosRepository.create(photo));
    });

    test('should not create photo', () async {
      final photo = mockPhotos.first; // Create a sample photo
      when(photosRepository.create(photo)).thenThrow(Exception());

      try {
        await photosRepository.create(photo);
      } catch (e) {
        verify(photosRepository.create(photo));
        expect(e, isInstanceOf<Exception>());
      }
    });

    test('get all Photos', () async {
      final streamController = StreamController<List<Photo>>();
      when(photosRepository.getAll()).thenAnswer((_) => streamController.stream);

      final result = photosRepository.getAll();
      expect(result, isA<Stream<List<Photo>>>());

      streamController.add(mockPhotos);

      final collectedPhotos = await result.first;

      verify(photosRepository.getAll());
      expect(collectedPhotos, equals(mockPhotos));
      streamController.close();
    });
  });
}

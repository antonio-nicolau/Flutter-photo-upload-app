import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wisy_image_uploader/src/core/model/photo.model.dart';
import 'package:wisy_image_uploader/src/core/services/photos.service.interface.dart';
import 'package:wisy_image_uploader/src/core/services/photos.service.dart';
import '../../../mocks/mock_photos.dart';
import 'photos.service.interface_test.mocks.dart';

@GenerateMocks([PhotosService])
void main() {
  late IPhotosService photosService;

  setUp(() {
    photosService = MockPhotosService();
  });

  group('IPhotosService Test', () {
    test('Create Photo', () async {
      final photo = mockPhotos.first;
      when(photosService.create(photo)).thenAnswer((_) async => true);

      final response = await photosService.create(photo);
      verify(photosService.create(photo)).called(1);
      expect(response, true);
    });

    test('get all Photos', () {
      when(photosService.getAll()).thenAnswer((_) => Stream.value(mockPhotos));

      final result = photosService.getAll();

      expect(result, isA<Stream<List<Photo>>>());

      result.listen((photos) {
        expect(photos, equals(mockPhotos));
      });
    });
  });
}

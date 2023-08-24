import 'package:wisy_image_uploader/src/core/model/photo.model.dart';

final List<Photo> mockPhotos = List.generate(
  5,
  (index) => Photo(
    timestamp: DateTime.now().millisecondsSinceEpoch,
    url: 'https://example.com/photo_$index.jpg',
  ),
);

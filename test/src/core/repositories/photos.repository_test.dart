import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:wisy_image_uploader/src/core/model/photo.model.dart';
import 'package:wisy_image_uploader/src/core/repositories/photos.repository.dart';
import 'package:wisy_image_uploader/src/core/repositories/photos.repository.interface.dart';
import '../../../mocks/mock_photos.dart';
import 'photos.repository_test.mocks.dart';

@GenerateMocks([
  FirebaseFirestore,
  CollectionReference,
  DocumentReference,
  QueryDocumentSnapshot,
  QuerySnapshot,
])
void main() {
  late IPhotosRepository photosRepository;
  late MockFirebaseFirestore firestore;
  late MockDocumentReference<Map<String, dynamic>> mockDocumentReference;

  setUp(() {
    firestore = MockFirebaseFirestore();
    mockDocumentReference = MockDocumentReference<Map<String, dynamic>>();
    photosRepository = PhotosRepository(firestore);
  });

  group('PhotosRepository Tests', () {
    test('create Photo', () async {
      final photo = mockPhotos.first;
      final mockCollectionReference = MockCollectionReference<Map<String, dynamic>>();

      // Mock Firestore behavior
      when(firestore.collection('photos')).thenReturn(mockCollectionReference);
      when(mockCollectionReference.add(any)).thenAnswer((_) async => mockDocumentReference);
      when(mockDocumentReference.id).thenReturn('123');

      final result = await photosRepository.create(photo);

      verify(firestore.collection('photos')).called(1);
      verify(mockCollectionReference.add(photo.toMap())).called(1);
      verify(mockDocumentReference.id).called(1);

      expect(result, true);
    });

    test('get all Photos', () {
      final mapCollectionReference = MockCollectionReference<Map<String, dynamic>>();
      final photoCollectionReference = MockCollectionReference<Photo>();
      final querySnapshot = MockQuerySnapshot<Photo>();
      final queryDocumentSnapshots = mockPhotos.map((e) => MockQueryDocumentSnapshot<Photo>()).toList();

      // Mock Firestore behavior
      when(firestore.collection('photos')).thenReturn(mapCollectionReference);
      when(mapCollectionReference.withConverter(
        fromFirestore: anyNamed('fromFirestore'),
        toFirestore: anyNamed('toFirestore'),
      )).thenReturn(photoCollectionReference);

      provideDummy<Photo>(mockPhotos.first);
      when(photoCollectionReference.snapshots()).thenAnswer((_) => Stream.value(querySnapshot));

      // Mock fromFirestore behavior for each queryDocumentSnapshot
      for (int i = 0; i < queryDocumentSnapshots.length; i++) {
        when(queryDocumentSnapshots[i].data()).thenReturn(mockPhotos[i]);
      }

      when(querySnapshot.docs).thenReturn(queryDocumentSnapshots);

      final result = photosRepository.getAll();

      // Verify that Firestore methods were called correctly
      verify(firestore.collection('photos')).called(1);
      verify(mapCollectionReference.withConverter(
        fromFirestore: anyNamed('fromFirestore'),
        toFirestore: anyNamed('toFirestore'),
      )).called(1);

      verify(photoCollectionReference.snapshots()).called(1);

      expect(result, isA<Stream<List<Photo>>>());
      expect(result, emitsInOrder([mockPhotos]));
    });
  });
}

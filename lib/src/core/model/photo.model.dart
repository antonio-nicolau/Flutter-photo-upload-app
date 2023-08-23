import 'package:cloud_firestore/cloud_firestore.dart';

class Photo {
  final String name;
  final String url;

  const Photo({required this.name, required this.url});

  factory Photo.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    return Photo(
      name: snapshot['name'],
      url: snapshot['url'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'url': url,
    };
  }
}

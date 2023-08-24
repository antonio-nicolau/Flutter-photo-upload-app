import 'package:cloud_firestore/cloud_firestore.dart';

class Photo {
  final int timestamp;
  final String url;

  const Photo({required this.timestamp, required this.url});

  factory Photo.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    return Photo(
      timestamp: snapshot['timestamp'],
      url: snapshot['url'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'timestamp': timestamp,
    };
  }
}

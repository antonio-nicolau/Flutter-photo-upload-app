import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wisy_image_uploader/src/core/repositories/photos.repository.dart';
import 'package:wisy_image_uploader/src/modules/new_image/new_image_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: StreamBuilder(
        stream: PhotosRepository(FirebaseFirestore.instance).getAll(),
        builder: (context, snapshot) {
          return Text(snapshot.data?.docs.length.toString() ?? 'none');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const NewImagePage()),
          );
        },
        tooltip: 'New image',
        child: const Icon(Icons.add),
      ),
    );
  }
}

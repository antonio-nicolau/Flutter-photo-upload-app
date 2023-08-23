import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:better_open_file/better_open_file.dart';
import 'package:wisy_image_uploader/src/modules/new_image/services/firebase_storage.service.dart';

class NewImagePage extends StatelessWidget {
  const NewImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: CameraAwesomeBuilder.awesome(
        saveConfig: SaveConfig.photo(
          pathBuilder: () async {
            final file = await _createFile();
            await FirebaseCloudStorage(FirebaseStorage.instance).upload(
              file,
            );
            return file.path;
          },
        ),
        onMediaTap: (mediaCapture) {
          OpenFile.open(mediaCapture.filePath);
        },
      ),
    );
  }

  Future<File> _createFile() async {
    final fileName = '${getRandString()}.jpg';
    final Directory extDir = await getApplicationDocumentsDirectory();

    final file = await File('${extDir.path}/$fileName').create(recursive: true);
    return file;
  }

  String getRandString() {
    var random = Random.secure();
    var values = List<int>.generate(15, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }
}

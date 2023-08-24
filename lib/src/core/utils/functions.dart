import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:wisy_image_uploader/src/modules/home/widgets/image_preview_widget.dart';

String getRandString() {
  var random = Random.secure();
  var values = List<int>.generate(15, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

void showPreviewPage({
  required BuildContext context,
  String? url,
  File? file,
  bool showUploadButton = false,
}) {
  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: ImagePreview(file: file, showUploadButton: true),
      );
    },
  );
}

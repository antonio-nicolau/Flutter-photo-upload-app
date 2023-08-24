import 'dart:io';
import 'package:flutter/material.dart';
import 'package:wisy_image_uploader/src/modules/new_image/widgets/upload_image_button_widget.dart';

class ImagePreview extends StatelessWidget {
  const ImagePreview({
    super.key,
    this.url,
    this.file,
    this.showUploadButton = false,
  });

  final String? url;
  final File? file;
  final bool showUploadButton;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height * 0.6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: getPreviewWidget(url: url, file: file)),
          if (showUploadButton && file != null) UploadImageButton(file: file!),
        ],
      ),
    );
  }

  Widget getPreviewWidget({String? url, File? file}) {
    if (url != null) {
      return Image.network(url, fit: BoxFit.cover);
    }
    return Image.file(file!, fit: BoxFit.cover);
  }
}

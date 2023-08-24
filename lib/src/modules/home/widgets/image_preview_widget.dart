import 'package:flutter/material.dart';

class ImagePreview extends StatelessWidget {
  const ImagePreview(this.url, {super.key});

  final String url;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height * 0.6,
      child: Image.network(url, fit: BoxFit.cover),
    );
  }
}

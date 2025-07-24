import 'dart:typed_data';
import 'package:flutter/material.dart';

class ImageView extends StatefulWidget {
  const ImageView({super.key, this.imageBytes});
  final Uint8List? imageBytes;
  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        title: const Text('Image View'),
        centerTitle: true,
      ),
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Center(
          child: widget.imageBytes != null
              ? InteractiveViewer( // Optional for zoom/pan
            child: Image.memory(
              widget.imageBytes!,
              fit: BoxFit.contain,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          )
              : const Icon(Icons.image_outlined, size: 60),
        )
      ),
    );
  }

}

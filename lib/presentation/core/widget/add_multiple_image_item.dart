import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddMultipleImageItem extends StatefulWidget {
  const AddMultipleImageItem({
    super.key,
    this.title = 'Images',
    this.initialImages,
    this.onImagesChanged,
    this.maxSizeKB = 500,
  });

  final String title;
  final List<Uint8List?>? initialImages;
  final void Function(List<Uint8List?>)? onImagesChanged;
  final int maxSizeKB;

  @override
  State<AddMultipleImageItem> createState() => _AddMultipleImageItemState();
}

class _AddMultipleImageItemState extends State<AddMultipleImageItem> {
  late List<Uint8List> _images;
  final ImagePicker _picker = ImagePicker();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _images = widget.initialImages != null && widget.initialImages!.isNotEmpty
        ? widget.initialImages!.whereType<Uint8List>().toList()
        : [];
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      final sizeKB = bytes.lengthInBytes / 1024;
      if (sizeKB > widget.maxSizeKB && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Image must be less than ${widget.maxSizeKB} KB'),
          ),
        );
        return;
      }
      setState(() {
        _images.add(bytes);
      });
      widget.onImagesChanged?.call(List<Uint8List>.from(_images));
      // Scroll to the last image after the frame is rendered
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
    widget.onImagesChanged?.call(List<Uint8List>.from(_images));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        color: Theme.of(context).hoverColor,
        border: Border.all(color: Theme.of(context).hoverColor, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.arrow_circle_right_rounded, size: 18),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
            ],
          ),
          const SizedBox(height: 16),
          if (_images.isEmpty)
            Container(
              height: 120,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
              ),
              alignment: Alignment.center,
              child: Text(
                'No images added',
                style: TextStyle(color: Theme.of(context).hintColor),
              ),
            ),
          if (_images.isNotEmpty)
            SizedBox(
              height: 120,
              child: ListView.separated(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: _images.length,
                separatorBuilder: (context, idx) => const SizedBox(width: 12),
                itemBuilder: (context, idx) {
                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.memory(
                          _images[idx],
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: GestureDetector(
                          onTap: () => _removeImage(idx),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: _pickImage,
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).hoverColor,
              padding: const EdgeInsets.all(16.0),
            ),
            child: Text(
              'Add New +',
              style: TextStyle(color: Theme.of(context).iconTheme.color),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flyt_app/presentation/core/handler/dialog_handler.dart';
import 'package:image_picker/image_picker.dart';
import '../handler/picker_handler.dart';

class AddImageItem extends StatefulWidget {
  const AddImageItem({
    super.key,
    required this.title,
    this.onImagePicked,
    this.maxSizeKB = 500,
    this.initialImageBytes,
  });

  final String title;
  final void Function(Uint8List?)? onImagePicked;
  final int maxSizeKB;
  final Uint8List? initialImageBytes;

  @override
  State<AddImageItem> createState() => _AddImageItemState();
}

class _AddImageItemState extends State<AddImageItem> {
  Uint8List? _imageBytes;
  final PickerHandler _pickerHandler = PickerHandler();

  @override
  void initState() {
    super.initState();
    _imageBytes = widget.initialImageBytes;
  }

  Future<void> _pickImage(BuildContext context) async {
    final result = await _pickerHandler.pickImageWithMaxSize(
      ImageSource.gallery,
      maxSizeKB: widget.maxSizeKB,
    );
    if (result is Uint8List) {
      setState(() {
        _imageBytes = result;
      });
      widget.onImagePicked?.call(result);
    } else if (result is String) {
      if (context.mounted) {
        DialogHandler.showSnackBar(context: context, message: result);
      }
      if(result != 'No image selected.') {
        widget.onImagePicked?.call(null);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            color: Theme.of(context).hoverColor,
            border: Border.all(
              color: Theme.of(context).colorScheme.shadow,
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
                  if (_imageBytes != null)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _imageBytes = null;
                        });
                        widget.onImagePicked?.call(null);
                      },
                      child: const Icon(Icons.close_rounded, size: 18),
                    ),
                  if (_imageBytes != null) const SizedBox(width: 4.0),
                ],
              ),
              const SizedBox(height: 8.0),
              GestureDetector(
                onTap: () => _pickImage(context),
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  alignment: Alignment.center,
                  child: _imageBytes != null
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.memory(
                      _imageBytes!,
                      width: double.infinity,
                      height: 200,
                    ),
                  )
                      : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_a_photo,
                        size: 40,
                        color: Theme.of(
                          context,
                        ).iconTheme.color?.withAlpha(120),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Tap to add image',
                        style: TextStyle(
                          color: Theme.of(
                            context,
                          ).iconTheme.color?.withAlpha(120),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

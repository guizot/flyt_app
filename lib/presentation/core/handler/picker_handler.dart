import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class PickerHandler {
  final ImagePicker _imagePicker = ImagePicker();

  Future<dynamic> pickImageWithMaxSize(ImageSource source, {int maxSizeKB = 500}) async {
    try {
      final XFile? picked = await _imagePicker.pickImage(source: source);
      if (picked == null) return 'No image selected.';

      final Uint8List imageBytes = await picked.readAsBytes();

      // ✅ Check dynamic size
      if (imageBytes.lengthInBytes > maxSizeKB * 1024) {
        return 'Image too large. Max ${maxSizeKB}KB allowed.';
      }

      return imageBytes;
    } catch (e) {
      return 'Error picking image: $e';
    }
  }


  // Method to pick a single image
  Future<XFile?> pickImage(ImageSource source) async {
    try {
      final XFile? image = await _imagePicker.pickImage(source: source);
      if (image != null) {
        return image;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error picking image: $e');
      }
    }
    return null;
  }

  // Method to pick a single video
  Future<XFile?> pickVideo(ImageSource source) async {
    try {
      final XFile? image = await _imagePicker.pickVideo(source: source);
      if (image != null) {
        return image;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error picking image: $e');
      }
    }
    return null;
  }

  // Method to pick a multi image
  Future<List<XFile>?> multiImages() async {
    try {
      List<XFile> listFiles = [];
      final List<XFile> selectedImages = await _imagePicker.pickMultiImage();
      if (selectedImages.isNotEmpty) {
        listFiles.addAll(selectedImages);
      }
      return listFiles;
    } catch (e) {
      if (kDebugMode) {
        print('Error picking image: $e');
      }
    }
    return null;
  }

}

import 'dart:typed_data';
import 'package:hive/hive.dart';
part 'document_model.g.dart';

@HiveType(typeId: 5)
class DocumentModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  Uint8List? imageBytes;

  @HiveField(4)
  String travelerId;

  @HiveField(5)
  DateTime createdAt;

  DocumentModel({
    required this.id,
    required this.title,
    required this.description,
    this.imageBytes,
    required this.travelerId,
    required this.createdAt,
  });
} 
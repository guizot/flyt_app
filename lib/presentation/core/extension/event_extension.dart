import '../../../data/models/local/event_model.dart';

extension EventExtension on Event {
  Map<String, String> toMap() {
    return {
      'id': id,
      'title': title,
      'budget': budget,
      'description': description,
    };
  }
}
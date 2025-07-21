import 'package:flutter/material.dart';
import '../../../data/models/local/traveler_model.dart';
import '../../core/helper/age_helper.dart';

class TravelerItem extends StatefulWidget {
  const TravelerItem({super.key, required this.item, required this.onTap});
  final Traveler item;
  final Function(String) onTap;

  @override
  State<TravelerItem> createState() => _TravelerItemState();
}

class _TravelerItemState extends State<TravelerItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onTap(widget.item.id),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(24.0)),
              color: Theme.of(context).hoverColor,
              border: Border.all(
                color: Theme.of(context).hoverColor,
                width: 2,
              ),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 20.0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Left: Image
                widget.item.imageBytes != null
                    ? Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            image: MemoryImage(widget.item.imageBytes!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Theme.of(context).colorScheme.surface,
                        ),
                        alignment: Alignment.center,
                        child: const Icon(Icons.person, size: 32),
                      ),
                const SizedBox(width: 16.0),
                // Middle: Name above, birthdate below
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.item.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        buildGenderAgeText(
                          widget.item.gender,
                          widget.item.birthdate,
                        ),
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodySmall?.color,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16.0),
                const Icon(Icons.arrow_forward_ios_rounded, size: 20),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }

  String buildGenderAgeText(String gender, String birthdate) {
    final age = AgeHelper().calculateAge(birthdate);
    final genderStr = gender.isNotEmpty ? gender : '';
    final ageStr = age != null ? '$age Years' : '';
    if (genderStr.isNotEmpty && ageStr.isNotEmpty) {
      return '$genderStr | $ageStr';
    }
    return genderStr + ageStr;
  }
}

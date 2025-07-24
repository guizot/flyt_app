import 'package:flutter/material.dart';
import '../../../data/models/local/phrases_model.dart';
import '../../core/widget/common_separator.dart';

class PhrasesItem extends StatefulWidget {
  const PhrasesItem({super.key, required this.item, required this.onTap, required this.onSpeak});
  final PhrasesModel item;
  final Function(String) onTap;
  final Function(String?) onSpeak;

  @override
  State<PhrasesItem> createState() => _PhrasesItemState();
}

class _PhrasesItemState extends State<PhrasesItem> {
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
                color: Theme.of(context).colorScheme.shadow,
                width: 1,
              ),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 24.0,
              horizontal: 24.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        widget.item.myLanguage,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    const Icon(Icons.arrow_forward_ios_rounded, size: 15),
                  ],
                ),
                const CommonSeparator(color: Colors.grey),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.item.theirLanguage,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          if (widget.item.romanization != null &&
                              widget.item.romanization != '')
                            const SizedBox(height: 8.0)
                          else
                            Container(),
                          if (widget.item.romanization != null &&
                              widget.item.romanization != '')
                            Text(
                              widget.item.romanization!,
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            )
                          else
                            Container(),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: () => widget.onSpeak(widget.item.theirLanguage),
                      child: const Icon(Icons.speaker_phone, size: 28),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}

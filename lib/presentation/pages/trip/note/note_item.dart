import 'package:flutter/material.dart';
import 'package:flyt_app/data/models/local/note_model.dart';
import '../../../core/widget/common_separator.dart';

class NoteItem extends StatefulWidget {
  const NoteItem({super.key, required this.item, required this.onTap });
  final NoteModel item;
  final Function(String) onTap;

  @override
  State<NoteItem> createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> {

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
                        widget.item.title,
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
                Text(
                  widget.item.description,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }

}
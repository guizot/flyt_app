import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flyt_app/data/models/local/document_model.dart';

class DocumentItem extends StatefulWidget {
  const DocumentItem({super.key, required this.item, required this.onTap, required this.onViewImage});
  final DocumentModel item;
  final Function(String) onTap;
  final Function(Uint8List?) onViewImage;

  @override
  State<DocumentItem> createState() => _DocumentItemState();
}

class _DocumentItemState extends State<DocumentItem> {
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.item.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            widget.item.description,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      )
                    ),
                    const SizedBox(width: 16),
                    const Icon(Icons.arrow_forward_ios_rounded, size: 20),
                  ],
                ),
                widget.item.imageBytes != null ? const SizedBox(height: 16.0) : Container(),
                widget.item.imageBytes != null ? GestureDetector(
                  onTap: () => widget.onViewImage(widget.item.imageBytes),
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    alignment: Alignment.center,
                    child: widget.item.imageBytes != null
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.memory(
                        fit: BoxFit.cover,
                        widget.item.imageBytes!,
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
                ) : Container()
              ],
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }

}

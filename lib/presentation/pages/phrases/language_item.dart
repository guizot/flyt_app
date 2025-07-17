import 'package:flutter/material.dart';
import 'package:flyt_app/presentation/core/model/static/language.dart';
import '../../../data/models/local/language_model.dart';

class LanguageItem extends StatefulWidget {
  const LanguageItem({super.key, required this.item, required this.onTap});
  final LanguageModel item;
  final Function(String) onTap;

  @override
  State<LanguageItem> createState() => _LanguageItemState();
}

class _LanguageItemState extends State<LanguageItem> {
  @override
  Widget build(BuildContext context) {
    // Find the country object by name
    final country = languages.firstWhere(
      (c) => c.name == widget.item.language,
      orElse: () => Language(id: '', name: widget.item.language, icon: ''),
    );
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
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(country.icon, style: const TextStyle(fontSize: 28)),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        country.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Icon(Icons.keyboard_arrow_right_outlined, size: 28),
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

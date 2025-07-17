import 'package:flutter/material.dart';
import 'package:flyt_app/presentation/core/widget/common_separator.dart';
import '../../../data/models/local/packing_model.dart';

class PackingItem extends StatefulWidget {
  const PackingItem({super.key, required this.item, required this.onTap });
  final Packing item;
  final Function(String) onTap;

  @override
  State<PackingItem> createState() => _PackingItemState();
}

class _PackingItemState extends State<PackingItem> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    onTap: () => widget.onTap(widget.item.id),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                  Radius.circular(24.0)
              ),
              color: Theme.of(context).hoverColor,
            ),
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.account_circle_rounded,
                      size: 18,
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        widget.item.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 15,
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.account_circle_outlined,
                      size: 18,
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        "${widget.item.packingPackage} Pax",
                      ),
                    ),
                  ],
                ),
                const CommonSeparator(
                  color: Colors.grey,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            widget.item.confirm == 'true' ? Icons.check_circle_outline_rounded : Icons.remove_circle_outline_rounded,
                            size: 18,
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            widget.item.confirm == 'true' ? "Confirmed" : "Unconfirmed",
                          )
                        ],
                      )
                    ),
                    const SizedBox(width: 8.0),
                    Flexible(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          widget.item.category,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.right,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16.0,
          )
        ],
      )
    );
  }

}
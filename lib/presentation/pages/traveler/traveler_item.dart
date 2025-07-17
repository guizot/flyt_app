import 'package:flutter/material.dart';
import '../../../data/models/local/traveler_model.dart';

class TravelerItem extends StatefulWidget {
  const TravelerItem({super.key, required this.item, required this.onTap });
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
                        Icons.arrow_circle_right,
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
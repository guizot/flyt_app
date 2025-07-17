import 'package:flutter/material.dart';
import 'package:flyt_app/data/models/local/event_model.dart';

class EventItem extends StatefulWidget {
  const EventItem({super.key, required this.event, required this.isSelected, required this.onEdit, required this.onSelect });
  final Event event;
  final bool isSelected;
  final Function(String) onEdit;
  final Function(Event) onSelect;

  @override
  State<EventItem> createState() => _EventItemState();
}

class _EventItemState extends State<EventItem> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            widget.onSelect(widget.event);
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                  Radius.circular(24.0)
              ),
              color: Theme.of(context).hoverColor,
            ),
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        widget.event.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    GestureDetector(
                        onTap: () {
                          widget.onEdit(widget.event.id);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                                Radius.circular(24.0)
                            ),
                            color: Theme.of(context).colorScheme.surfaceDim,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          child: const Text(
                            "Edit",
                            style: TextStyle(
                                fontWeight: FontWeight.w600
                            ),
                          ),
                        )
                    ),
                    const SizedBox(width: 12.0),
                    SizedBox(
                      child: widget.isSelected ? Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            shape: BoxShape.circle
                        ),
                        padding: const EdgeInsets.all(4.0),
                        child: const Icon(
                          Icons.check,
                          size: 18,
                        ),
                      ) : Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surfaceDim,
                            shape: BoxShape.circle
                        ),
                        padding: const EdgeInsets.all(4.0),
                        child: const Icon(
                          Icons.check,
                          size: 18,
                          color: Colors.transparent,
                        ),
                      )
                    )
                  ],
                ),
              ],
            ),
          )
        ),
        const SizedBox(
          height: 16.0,
        )
      ],
    );
  }

}
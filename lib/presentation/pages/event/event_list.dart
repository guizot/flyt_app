import 'package:flutter/material.dart';
import '../../../data/models/local/event_model.dart';
import 'event_item.dart';

class EventList extends StatefulWidget {
  const EventList({
    super.key,
    required this.events,
    required this.onEdit,
    required this.onSelect,
    required this.onBack,
  });

  final List<Event> events;
  final Function(String) onEdit;
  final Function(Event) onSelect;
  final Function onBack;

  @override
  State<EventList> createState() => _EventList();
}

class _EventList extends State<EventList> {

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16.0),
        width: double.infinity,
        child: Column(
          children: [
            Container(
              height: 5.0,
              width: MediaQuery.of(context).size.width / 4,
              decoration: BoxDecoration(
                color: Theme.of(context).hoverColor,
                borderRadius: const BorderRadius.all(Radius.circular(25.0)),
              ),
            ),
            const SizedBox(height: 24.0),
            ...widget.events.map((event) {
              return EventItem(
                event: event,
                isSelected: event.selected,
                onEdit: widget.onEdit,
                onSelect: (Event item) {
                  widget.onSelect(item);
                  setState(() { });
                  widget.onBack();
                },
              );
            }),
            // AddItem(
            //   name: "Add Event +",
            //   onAdd: widget.onAdd,
            // ),
          ],
        )
    );
  }
}

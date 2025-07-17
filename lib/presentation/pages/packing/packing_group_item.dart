import 'package:flutter/material.dart';
import 'package:flyt_app/presentation/pages/packing/packing_item.dart';
import '../../core/handler/dialog_handler.dart';
import '../../core/model/common/packing_group.dart';

class PackingGroupItem extends StatefulWidget {
  final List<PackingGroup> packings;
  final void Function(String) onDelete;
  final void Function(String) onClick;
  final void Function(String) onSelect;

  const PackingGroupItem({
    super.key,
    required this.packings,
    required this.onDelete,
    required this.onClick,
    required this.onSelect,
  });

  @override
  PackingGroupItemState createState() => PackingGroupItemState();
}

class PackingGroupItemState extends State<PackingGroupItem> {
  final Map<String, bool> _expandedGroups = {};

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      itemCount: widget.packings.length,
      itemBuilder: (context, index) {
        final group = widget.packings[index];
        final isExpanded = _expandedGroups[group.group] ?? true;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            GestureDetector(
              onTap: () {
                setState(() {
                  _expandedGroups[group.group] = !isExpanded;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                child: Row(
                  children: [
                    Text(group.groupIcon, style: const TextStyle(fontSize: 20)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        group.group,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(isExpanded ? Icons.expand_less : Icons.expand_more)
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),

            if (isExpanded)
              ...group.items.map((item) =>
                  Dismissible(
                    key: Key(item.id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      margin: const EdgeInsets.only(bottom: 16.0),
                      // Match the vertical spacing between items
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(24.0)),
                      ),
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: const Icon(Icons.delete, color: Colors.white, size: 32),
                    ),
                    confirmDismiss: (direction) async {
                      final result = await DialogHandler.showConfirmBottomSheet(
                        context: context,
                        title: 'Confirmation',
                        description:
                        'Are you sure you want to delete this item? This action cannot be undone.',
                        confirmText: 'Delete',
                        cancelText: 'Cancel',
                      );
                      return result == true;
                    },
                    onDismissed: (direction) async => widget.onDelete(item.id),
                    child: PackingItem(
                        item: item,
                        onClick: widget.onClick,
                        onSelect: widget.onSelect
                    ),
                  )
              ),
            const SizedBox(height: 8),
          ],
        );
      },
    );
  }
}
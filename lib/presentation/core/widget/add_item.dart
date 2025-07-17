import 'package:flutter/material.dart';
import 'package:flyt_app/presentation/core/widget/dashed_container.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key, required this.name, required this.onAdd });
  final String name;
  final Function onAdd;

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            widget.onAdd();
          },
          child: DashedBorderContainer(
            borderColor: Colors.grey,
            borderRadius: 20.0,
            child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 22.0, horizontal: 24.0),
                child: Center(
                    child: Text(
                      widget.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey
                      ),
                    )
                )
            ),
          )
        ),
        const SizedBox(height: 16.0)
      ],
    );
  }

}
import 'package:flutter/material.dart';

class HeaderItem extends StatefulWidget {
  const HeaderItem({super.key, required this.name, required this.onAdd });
  final String name;
  final Function onAdd;

  @override
  State<HeaderItem> createState() => _HeaderItemState();
}

class _HeaderItemState extends State<HeaderItem> {

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "The Wedding of",
                          style: TextStyle(
                              fontSize: 16
                          ),
                        ),
                        Text(
                          widget.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 22
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  GestureDetector(
                    onTap: () {
                      widget.onAdd();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          shape: BoxShape.circle
                      ),
                      padding: const EdgeInsets.all(4.0),
                      child: const Icon(
                        Icons.add,
                        size: 24,
                      ),
                    )
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
    );
  }

}
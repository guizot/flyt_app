import 'package:flutter/material.dart';

class CommonSeparator extends StatelessWidget {
  final Color color;
  final double dashWidth;
  final double dashSpace;
  final double height;
  final bool isDashed;

  const CommonSeparator({
    super.key,
    this.color = Colors.black,
    this.dashWidth = 5.0,
    this.dashSpace = 3.0,
    this.height = 0.5,
    this.isDashed = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16.0),
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (isDashed) {
              final dashCount = (constraints.constrainWidth() / (dashWidth + dashSpace)).floor();
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(dashCount, (index) {
                  return SizedBox(
                    width: dashWidth,
                    height: height,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(0.5),
                      ),
                    ),
                  );
                }),
              );
            } else {
              return Container(
                width: constraints.constrainWidth(),
                height: height,
                color: color,
              );
            }
          },
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}

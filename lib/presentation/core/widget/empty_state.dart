import 'package:flutter/material.dart';
import 'dashed_container.dart';

class EmptyState extends StatelessWidget {
  final String title;
  final String subtitle;
  final String tapText;
  final VoidCallback onTap;
  final VoidCallback onLearn;

  const EmptyState({
    super.key,
    required this.title,
    required this.subtitle,
    required this.tapText,
    required this.onTap,
    required this.onLearn,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8.0),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24.0),
                DashedBorderContainer(
                    borderColor: Colors.grey,
                    borderRadius: 20.0,
                    child: GestureDetector(
                        onTap: onTap,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 21, horizontal: 24),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: Theme.of(context).hoverColor,
                          ),
                          child: Text(
                            tapText,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                    )
                ),
                const SizedBox(height: 20.0),
                GestureDetector(
                  onTap: onLearn,
                  child: const Text(
                    "Learn Data Protection",
                    style: TextStyle(
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                    ),
                    textAlign: TextAlign.center,
                  )
                ),
              ],
            )
        )
    );
  }

}
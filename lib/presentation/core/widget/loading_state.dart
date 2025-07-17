import 'package:flutter/material.dart';

class LoadingState extends StatelessWidget {
  final String title;

  const LoadingState({
    super.key,
    this.title = "Loading",
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
                Center(
                  child: SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                ),
                const SizedBox(height: 24.0),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            )
        )
    );
  }

}
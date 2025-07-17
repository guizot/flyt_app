import 'package:flutter/material.dart';

class DialogHandler {
  static void showBottomSheet({
    required BuildContext context,
    required Widget child,
    bool isCancelable = true,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: isCancelable,
      enableDrag: isCancelable,
      builder: (BuildContext context) {
        final maxHeight = MediaQuery.of(context).size.height * 0.8;
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: maxHeight),
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SingleChildScrollView(child: child),
            ),
          ),
        );
      },
    );
  }

  static void showSnackBar({
    required BuildContext context,
    required String message,
    Color? color,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor: color ?? Theme.of(context).iconTheme.color,
        margin: const EdgeInsets.only(bottom: 80.0, left: 16.0, right: 16.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    );
  }

  static void showConfirmDialog({
    required BuildContext context,
    required String title,
    required String description,
    required String confirmText,
    required VoidCallback onConfirm,
    bool isCancelable = true,
  }) {
    showBottomSheet(
      context: context,
      isCancelable: isCancelable,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
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
              const SizedBox(height: 18.0),
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
                description,
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: onConfirm,
                      style: FilledButton.styleFrom(
                        backgroundColor: Theme.of(context).iconTheme.color,
                        padding: const EdgeInsets.all(16.0),
                      ),
                      child: Text(confirmText),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Future<bool?> showConfirmBottomSheet({
    required BuildContext context,
    required String title,
    required String description,
    required String confirmText,
    String cancelText = 'Cancel',
    bool isCancelable = true,
  }) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      isDismissible: isCancelable,
      enableDrag: isCancelable,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        final maxHeight = MediaQuery.of(context).size.height * 0.8;
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: maxHeight),
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 5.0,
                        width: MediaQuery.of(context).size.width / 4,
                        decoration: BoxDecoration(
                          color: Theme.of(context).hoverColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(25.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 18.0),
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
                        description,
                        style: const TextStyle(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.all(16.0),
                              ),
                              child: Text(
                                  cancelText,
                                style: TextStyle(
                                  color: Theme.of(context).iconTheme.color
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12.0),
                          Expanded(
                            child: FilledButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              style: FilledButton.styleFrom(
                                backgroundColor: Theme.of(
                                  context,
                                ).iconTheme.color,
                                padding: const EdgeInsets.all(16.0),
                              ),
                              child: Text(confirmText),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

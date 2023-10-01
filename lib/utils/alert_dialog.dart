import 'package:flutter/material.dart';

class CustomAlertDialog {
  AlertDialog _alertDialog({
    required BuildContext context,
    required String title,
    required String content,
  }) {
    return AlertDialog(
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('حسنا'),
        ),
      ],
    );
  }

  void showCustomAlert({
    required BuildContext context,
    required String title,
    required String content,
  }) {
    showDialog(
      context: context,
      builder: (context) => _alertDialog(
        context: context,
        title: title,
        content: content,
      ),
    );
  }
}

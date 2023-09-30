import 'dart:async';

import 'package:flutter/material.dart';

class CustomDialog {
  Future<void> showCustomDialog(
      BuildContext context, String description) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Dialog(
        alignment: Alignment.center,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              colors: [
                Colors.indigo,
                Colors.deepOrange,
              ],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              stops: [
                0,
                0.9,
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const CircularProgressIndicator(
                color: Colors.orange,
              ),
              Text(
                description,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void popCurrentDialog(BuildContext context) {
    Navigator.of(context).pop();
  }
}

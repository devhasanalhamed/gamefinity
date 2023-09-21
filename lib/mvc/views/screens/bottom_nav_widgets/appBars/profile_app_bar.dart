import 'package:flutter/material.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(
      kToolbarHeight); // Define the desired height of your custom AppBar

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'devhassanmohammed',
            textDirection: TextDirection.ltr,
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

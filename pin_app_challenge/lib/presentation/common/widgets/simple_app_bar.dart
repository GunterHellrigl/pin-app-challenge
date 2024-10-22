import 'package:flutter/material.dart';

class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SimpleAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Row(
        children: [
          Text(
            'Pin',
            style: TextStyle(
              fontSize: 25,
              color: Color(0xFFCD2C1E),
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'App ',
            style: TextStyle(
              fontSize: 25,
              color: Color(0xFF51B2E2),
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Challenge',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

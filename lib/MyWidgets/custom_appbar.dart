import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    //handeled in theme/////////////////////////////////////////////////////////////////////////////////////
    return AppBar(
      title: Text(title),
      backgroundColor: Colors.blue,
      centerTitle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
      ),
      foregroundColor: Colors.white,
      titleSpacing: 2,
      titleTextStyle: const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 20,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}

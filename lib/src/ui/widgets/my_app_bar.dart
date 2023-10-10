import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;

  const MyAppBar({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      centerTitle: true,
      elevation: 0,
      iconTheme: const IconThemeData(
        color: Colors.black
      ),
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
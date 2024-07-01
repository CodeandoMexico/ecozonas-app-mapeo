import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final bool hideBackButton;

  const MyAppBar({super.key, this.title, this.hideBackButton = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      centerTitle: true,
      elevation: 0,
      leading: hideBackButton ? Container() : null,
      iconTheme: const IconThemeData(
        color: Colors.black
      ),
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
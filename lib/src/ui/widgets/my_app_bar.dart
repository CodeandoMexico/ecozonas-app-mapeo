import 'package:flutter/material.dart';

import '../utils/constants.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconData? iconData;

  const MyAppBar({super.key, required this.title, this.iconData});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: iconData == null ?
        Text(title) : 
        Row(
        children: [
          Icon(iconData),
          const SizedBox(width: Constants.paddingSmall),
          Text(title)
        ],
      ),
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
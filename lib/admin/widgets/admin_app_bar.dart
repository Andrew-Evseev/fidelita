import 'package:flutter/material.dart';

class AdminAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onLogout;

  const AdminAppBar({
    super.key,
    required this.title,
    this.onLogout,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF8B7355),
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
      iconTheme: const IconThemeData(color: Color(0xFF8B7355)),
      actions: [
        if (onLogout != null)
          IconButton(
            onPressed: onLogout,
            icon: const Icon(Icons.logout),
            tooltip: 'Выйти',
          ),
      ],
    );
  }
}
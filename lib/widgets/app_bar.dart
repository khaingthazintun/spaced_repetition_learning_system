// widgets/app_bar.dart
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final List<Widget>? actions;
  final bool showBackButton;
  final VoidCallback? onBackPressed; // Optional custom back handler

  // Add onBackPressed to constructor parameters
  const CustomAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.actions,
    this.showBackButton = false,
    this.onBackPressed, // Add this
  });

  @override
  Size get preferredSize => const Size.fromHeight(80);

  void _handleBack(BuildContext context) {
    if (onBackPressed != null) {
      onBackPressed!(); // Use custom handler if provided
    } else if (Navigator.canPop(context)) {
      Navigator.pop(context); // Only pop if there's something to pop
    }
    // If can't pop and no custom handler, do nothing
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: showBackButton
          ? IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
        onPressed: () {
          if (onBackPressed != null) {
            onBackPressed!(); // Use custom handler
          } else if (Navigator.canPop(context)) {
            Navigator.pop(context); // Default pop
          } else {
            // If no screens to pop, you could navigate to home
            // Example: Navigator.pushReplacementNamed(context, '/home');
          }
        },
      )
          : null,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          if (subtitle != null)
            Text(
              subtitle!,
              style: Theme.of(context).textTheme.bodySmall,
            ),
        ],
      ),
      actions: actions,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0x08FFFFFF),
              const Color(0x03FFFFFF).withValues(alpha: 0.01),
            ],
          ),
        ),
      ),
    );
  }
}
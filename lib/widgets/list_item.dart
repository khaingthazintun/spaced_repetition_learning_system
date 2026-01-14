// lib/widgets/list_item.dart
import 'package:flutter/material.dart';
import '../widgets/progress_bar.dart';

class ListItem extends StatelessWidget {
  final Widget title;
  final String? subtitle;
  final double? progress;
  final VoidCallback? onTap;
  final Widget? trailing;

  const ListItem({
    super.key,
    required this.title,
    this.subtitle,
    this.progress,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0x05FFFFFF),
          border: Border.all(color: const Color(0x14FFFFFF)),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFE6EDF7),
                  ),
                  child: title,
                ),
                if (trailing != null) trailing!,
              ],
            ),
            if (subtitle != null)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  subtitle!,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF9FB0C7),
                  ),
                ),
              ),
            if (progress != null)
              ProgressBar(progress: progress!),
          ],
        ),
      ),
    );
  }
}
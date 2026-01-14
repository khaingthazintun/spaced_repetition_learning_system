// widgets/chip.dart
import 'package:flutter/material.dart';

class Chip extends StatelessWidget {
  final String label;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;

  const Chip({
    super.key,
    required this.label,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor ?? const Color(0x05FFFFFF),
        border: Border.all(color: borderColor ?? const Color(0x14FFFFFF)),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          color: textColor ?? const Color(0xD9FFFFFF),
        ),
      ),
    );
  }
}
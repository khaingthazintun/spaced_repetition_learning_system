// widgets/banner.dart
import 'package:flutter/material.dart';

class BannerWidget extends StatelessWidget {
  final Widget child;

  const BannerWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0x1A6EE7B7),
        border: Border.all(color: const Color(0x386EE7B7)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: DefaultTextStyle(
        style: const TextStyle(
          fontSize: 12,
          color: Color(0xEBFFFFFF),
          height: 1.35,
        ),
        child: child,
      ),
    );
  }
}
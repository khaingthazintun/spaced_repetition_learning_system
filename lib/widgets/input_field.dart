import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final IconData icon;
  final String? initialValue;
  final String? hintText;
  final bool isTextArea;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;

  const InputField({
    super.key,
    required this.icon,
    this.initialValue,
    this.hintText,
    this.isTextArea = false,
    this.onChanged,
    this.controller, // Added to constructor
  });

  @override
  Widget build(BuildContext context) {
    // Note: We use the passed controller. 
    // If a controller is provided, initialValue should be handled by the controller itself.
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0x05FFFFFF),
        border: Border.all(color: const Color(0x14FFFFFF)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: isTextArea ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: isTextArea ? 12 : 0),
            child: Icon(icon, size: 20, color: const Color(0x99FFFFFF)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              maxLines: isTextArea ? 4 : 1,
              onChanged: onChanged,
              style: const TextStyle(color: Color(0xFFE6EDF7), fontSize: 13),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: const TextStyle(color: Color(0x99FFFFFF)),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
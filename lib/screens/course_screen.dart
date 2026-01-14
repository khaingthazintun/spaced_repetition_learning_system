// lib/screens/course_screen.dart
import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/card.dart';
import '../widgets/list_item.dart';
import '../widgets/chip.dart' as custom;
import '../models/course_model.dart';
import 'module_screen.dart'; // For navigating to modules



class CourseScreen extends StatelessWidget {
  final Course course;
  final VoidCallback? onBackPressed;

  const CourseScreen({super.key, required this.course, this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Math 101',
        subtitle: 'Course Code: MTH101-7Q2K',
        showBackButton: true,
        actions: [
          ElevatedButton(
            onPressed: () {
              // Add navigation or action here
              // Example: Navigator.push(...) or show dialog
            },
            child: const Text('Open modules'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          // Course info chips
          const Row(
            children: [
              custom.Chip(label: 'Course'),
              SizedBox(width: 8),
              Text('•', style: TextStyle(color: Color(0xFF9FB0C7))),
              SizedBox(width: 8),
              Text('2 modules', style: TextStyle(color: Color(0xFF9FB0C7))),
              SizedBox(width: 8),
              Text('•', style: TextStyle(color: Color(0xFF9FB0C7))),
              SizedBox(width: 8),
              Text('12 topics', style: TextStyle(color: Color(0xFF9FB0C7))),
            ],
          ),
          const SizedBox(height: 12),
          
          // Modules list
          AppCard(
            title: 'Modules',
            child: Column(
              children: [
                ListItem(
                  title: const Text('Integral'),
                  subtitle: '6 topics • Mastery 55%',
                  progress: 0.55,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ModuleScreen()),
                    );
                  },
                ),
                const SizedBox(height: 10),
                ListItem(
                  title: const Text('Differential'),
                  subtitle: '6 topics • Mastery 61%',
                  progress: 0.61,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ModuleScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
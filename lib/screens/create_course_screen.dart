import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/card.dart';
import '../widgets/input_field.dart';
import '../models/course_model.dart';

class CreateCourseScreen extends StatefulWidget {
  const CreateCourseScreen({super.key});

  @override
  State<CreateCourseScreen> createState() => _CreateCourseScreenState();
}

class _CreateCourseScreenState extends State<CreateCourseScreen> {
  // 1. Define the controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();


  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Create course',
        subtitle: 'Build → share with a course code',
        showBackButton: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          AppCard(
            title: 'Course details',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InputField(
                  icon: Icons.book,
                  controller: _nameController,
                  hintText: 'Course name',
                ),
                const SizedBox(height: 10),
                InputField(
                  icon: Icons.description,
                  controller: _descController,
                  hintText: 'Course description',
                ),
                InputField(icon: Icons.vpn_key, controller: _codeController, hintText: 'Course code'),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          final newCourse = Course(
                            title: _nameController.text,
                            description: _descController.text,
                            code: "AUTO-123", 
                          );
                          Navigator.pop(context, newCourse);
                        },
                        child: const Text('Create'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
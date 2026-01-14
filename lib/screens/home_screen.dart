import 'package:flutter/material.dart';
import 'package:spaced_repetition_learning_system/screens/create_topic_screen.dart';
import 'package:spaced_repetition_learning_system/screens/create_course_screen.dart'; // Add this
import '../widgets/app_bar.dart';
import '../widgets/card.dart';
import '../widgets/banner.dart';
import '../widgets/chip.dart' as custom;
import '../models/course_model.dart';
import 'progress_screen.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback? onBackPressed;
  final Function(int)? switchToTab;
  final List<Course> courses;
  final Function(Course) onAddCourse;



  const HomeScreen({
    super.key,
    this.onBackPressed,
    this.switchToTab,
    required this.courses,
    required this.onAddCourse,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // This list will hold the courses you create
  final List<Course> _myCourses = [];

  // Function to navigate and catch the new course
  void _createNewCourse() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateCourseScreen()),
    );

    if (result != null && result is Course) {
      setState(() {
        _myCourses.add(result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Today',
        subtitle: 'Reviews: questions + notes',
        showBackButton: false,
        onBackPressed: widget.onBackPressed,
        actions: [
          TextButton(
            onPressed: () {
              // Navigate to ProgressScreen instead of switching tabs
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProgressScreen(
                    onBackPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              );
            },
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF5DD6FF),
              side: const BorderSide(color: Color(0x24FFFFFF)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            child: const Text('Progress'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          const BannerWidget(
            child: Row(
              children: [
                Text('Due now: '),
                Text('12 reviews', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(' • '),
                Text('⭐ Starred: ', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('4 • '),
                Text('📝 Notes: ', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('2'),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Display Course List if not empty
          if (_myCourses.isNotEmpty) ...[
            const Text('My Courses', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 8),
            ..._myCourses.map((course) => _buildCourseCard(course)),
            const SizedBox(height: 12),
          ],

          AppCard(
            title: 'Continue',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Course: Math 101 → Module: Integral → Topic: What is Integral?',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 10),
                const Wrap(
                  spacing: 8,
                  children: [
                    custom.Chip(label: 'Mastery: 58%'),
                    custom.Chip(label: 'Course Code: MTH101-7Q2K'),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0x1A5DD6FF),
                        foregroundColor: const Color(0xFFE6EDF7),
                        side: const BorderSide(color: Color(0x595DD6FF)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      child: const Text('Open topic'),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        if (widget.switchToTab != null) {
                          widget.switchToTab!(2);
                        }
                      },
                      child: const Text('Start reviews'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          AppCard(
            title: 'Quick actions',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: _createNewCourse, // Updated to trigger course creation
                      child: const Text(' Courses'),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CreateTopicScreen(),
                          ),
                        );
                      },
                      child: const Text('Create topic'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Notes review uses the same SRS rating screen.',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Visual card for the course
  Widget _buildCourseCard(Course course) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: ListTile(
        leading: const Icon(Icons.book, color: Color(0xFF5DD6FF)),
        title: Text(course.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: Text(course.description, style: const TextStyle(color: Color(0x99FFFFFF), fontSize: 12)),
        trailing: const Icon(Icons.chevron_right, color: Colors.white24),
        onTap: () {
            // Future logic: Open the Course Screen for this specific course
        },
      ),
    );
  }
}
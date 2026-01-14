import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/card.dart';
import '../widgets/list_item.dart';
import 'login_menu_screen.dart';
import 'settings_screen.dart';
import 'members_screen.dart';
import 'clone_course_screen.dart';
import 'course_settings_screen.dart';
import 'course_screen.dart';
import 'login_menu_screen.dart';
import '../models/course_model.dart';

class MenuScreen extends StatelessWidget {
  final VoidCallback? onBackPressed;
  final Function(int)? switchToTab;
  final List<Course> courses;

  const MenuScreen({
    super.key,
    this.onBackPressed,
    this.switchToTab,
    required this.courses,
  });

  @override
  Widget build(BuildContext context) {
    // Sample course for demo - MUST BE DEFINED HERE
    final demoCourse = courses.isNotEmpty
        ? courses.first
        : Course(
      title: 'Math 101',
      description: 'Introduction to calculus with spaced repetition',
      code: 'MTH101-DEMO',
    );

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Menu',
        subtitle: 'Prototype shortcuts',
        showBackButton: true,
        onBackPressed: onBackPressed,
      ),
      body: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          AppCard(
            title: 'Menu',
            child: Column(
              children: [
                _buildMenuItem(
                  context,
                  icon: Icons.login,
                  label: 'Login',
                  subtitle: 'Auth screens',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginMenuScreen(
                          onBackPressed: () => Navigator.pop(context),                      ),
                    ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                _buildMenuItem(
                  context,
                  icon: Icons.settings,
                  label: 'Settings',
                  subtitle: 'Notifications',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingsScreen(
                          onBackPressed: () => Navigator.pop(context),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                _buildMenuItem(
                  context,
                  icon: Icons.settings_applications,
                  label: 'Course Settings',
                  subtitle: 'Visibility / members',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CourseSettingsScreen(
                          onBackPressed: () => Navigator.pop(context),
                          course: demoCourse, // Use the demoCourse variable
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                _buildMenuItem(
                  context,
                  icon: Icons.people,
                  label: 'Members',
                  subtitle: 'Add / remove',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MembersScreen(
                          onBackPressed: () => Navigator.pop(context),
                          course: demoCourse, // Use the demoCourse variable
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                _buildMenuItem(
                  context,
                  icon: Icons.copy,
                  label: 'Clone Course',
                  subtitle: 'Duplicate structure',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CloneCourseScreen(
                          onBackPressed: () => Navigator.pop(context),
                          course: demoCourse, // Use the demoCourse variable
                          onCourseCloned: (newCourse) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Cloned course: ${newCourse.title}'),
                              ),
                            );
                          },
                        ),
                      ),
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

  Widget _buildMenuItem(
      BuildContext context, {
        required IconData icon,
        required String label,
        required String subtitle,
        required VoidCallback onTap,
      }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0x05FFFFFF),
            border: Border.all(color: const Color(0x14FFFFFF)),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0x08FFFFFF),
                  border: Border.all(color: const Color(0x14FFFFFF)),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: const Color(0xFF9FB0C7),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFE6EDF7),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF9FB0C7),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right,
                size: 20,
                color: Color(0x99FFFFFF),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
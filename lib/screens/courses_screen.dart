// courses_screen.dart - Updated version
import 'package:flutter/material.dart';
import 'package:spaced_repetition_learning_system/models/course_model.dart';
import '../widgets/app_bar.dart';
import '../widgets/card.dart';
import '../widgets/list_item.dart';
import '../widgets/input_field.dart';
import 'create_course_screen.dart';
import 'course_screen.dart';
import '../models/course_model.dart';

class CoursesScreen extends StatelessWidget {
  final VoidCallback? onBackPressed; 
  final List<Course> courses;
  final Function(Course)? onAddCourse;


  const CoursesScreen({
    super.key,
    this.onBackPressed,
    required this.courses,
    this.onAddCourse,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Courses',
        subtitle: 'Join with code or open your library',
        showBackButton: true,
        onBackPressed: onBackPressed, // ← USE THE PARAMETER HERE!
        actions: [
          ElevatedButton(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreateCourseScreen()),
              );
              if(result != null && result is Course && onAddCourse != null){
                onAddCourse!(result);
            }
            },
            child: const Text('Create'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          AppCard(
            title: 'Join a course',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enter a course code (shared by another user).',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 10),
                const InputField(
                  icon: Icons.search,
                  initialValue: 'MTH101-7Q2K',
                  hintText: 'Course code',
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CourseScreen(
                                course: Course(
                                  title: 'Math 101',
                                  description: 'Sample Mathematics Course',
                                  code: 'MTH101-7Q2K',
                                ),
                              ),
                            ),
                          );
                        },
                        child: const Text('Join'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const CreateCourseScreen()),
                          );

                          if (result != null && result is Course && onAddCourse != null) {
                            onAddCourse!(result); // This updates the master list in TabContainer
                          }
                        },
                        child: const Text('Create new'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          AppCard(
            title: 'Your library',
            child: Column(
              children: [
                // 1. If the list is empty, show a small hint
                if (courses.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      'No courses created yet.',
                      style: TextStyle(color: Colors.white24, fontSize: 13),
                    ),
                  ),

                // 2. Map through your REAL courses list
                ...courses.map((course) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ListItem(
                      title: Text(course.title),
                      subtitle: 'Code: ${course.code}',
                      progress: 0.0, // Default for new courses
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  CourseScreen(course: course),
                          ),
                        );
                      },
                    ),
                  );
                }),

                // 3. Keep one hardcoded example or remove it once you're testing
                const Divider(color: Colors.white10, height: 20),
                ListItem(
                  title: const Text('Math 101 (Sample)'),
                  subtitle: '2 modules • 12 topics • Code: MTH101-7Q2K',
                  progress: 0.58,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CourseScreen(
                        course: Course(
                          title: 'Math 101',
                          description: 'Sample Mathematics Course',
                          code: 'MTH101-7Q2K',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/card.dart';
import 'courses_screen.dart';
import '../models/course_model.dart';

class CloneCourseScreen extends StatefulWidget {
  final VoidCallback? onBackPressed;
  final Course course;
  final Function(Course)? onCourseCloned;

  const CloneCourseScreen({
    super.key,
    this.onBackPressed,
    required this.course,
    this.onCourseCloned,
  });

  @override
  State<CloneCourseScreen> createState() => _CloneCourseScreenState();
}

class _CloneCourseScreenState extends State<CloneCourseScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  bool _isDuplicable = true;

  @override
  void initState() {
    super.initState();
    _titleController.text = '${widget.course.title} (Clone)';
    _codeController.text = 'CLONE-${widget.course.code}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Clone Course',
        subtitle: 'Duplicate structure',
        showBackButton: true,
        onBackPressed: widget.onBackPressed,
      ),
      body: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          AppCard(
            title: 'Clone Settings',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.course.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFE6EDF7),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Original course',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: widget.course.code.contains('DEMO')
                            ? const Color(0x1A5DD6FF)
                            : const Color(0x1A6EE7B7),
                        border: Border.all(
                          color: widget.course.code.contains('DEMO')
                              ? const Color(0x385DD6FF)
                              : const Color(0x386EE7B7),
                        ),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        widget.course.code,
                        style: TextStyle(
                          fontSize: 11,
                          color: widget.course.code.contains('DEMO')
                              ? const Color(0xFF5DD6FF)
                              : const Color(0xFF6EE7B7),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Hybrid clone (copy-on-write)',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE6EDF7),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Content structure is copied. Media is referenced to avoid storage explosion. '
                      'If you replace media in the clone, a new mediaId is created and ownership transfers to the clone.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 16),
                _buildCopyItem('What gets copied', 'title, notes, MCQs, ⭐ flags', true),
                const SizedBox(height: 10),
                _buildCopyItem('What gets referenced', 'topic videos, question images, option images', false),
                const SizedBox(height: 16),
                const Divider(color: Color(0x14FFFFFF)),
                const SizedBox(height: 16),
                const Text(
                  'New Course Details',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE6EDF7),
                  ),
                ),
                const SizedBox(height: 12),
                _buildInputField('Course title', _titleController),
                const SizedBox(height: 12),
                _buildInputField('Course code', _codeController),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Duplicable',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFE6EDF7),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Allow others to clone your clone',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF9FB0C7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: _isDuplicable,
                      onChanged: (value) {
                        setState(() {
                          _isDuplicable = value;
                        });
                      },
                      activeColor: const Color(0xFF5DD6FF),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _createClone,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0x1A5DD6FF),
                    foregroundColor: const Color(0xFFE6EDF7),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text('Create Clone'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCopyItem(String title, String description, bool isCopied) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: isCopied
                ? const Color(0x1A5DD6FF)
                : const Color(0x1A9FB0C7),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            isCopied ? Icons.copy_all : Icons.link,
            size: 18,
            color: isCopied
                ? const Color(0xFF5DD6FF)
                : const Color(0xFF9FB0C7),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFE6EDF7),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF9FB0C7),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: isCopied
                ? const Color(0x1A5DD6FF)
                : const Color(0x1A9FB0C7),
            border: Border.all(
              color: isCopied
                  ? const Color(0x385DD6FF)
                  : const Color(0x389FB0C7),
            ),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            isCopied ? 'Deep copy' : 'Reference',
            style: TextStyle(
              fontSize: 11,
              color: isCopied
                  ? const Color(0xFF5DD6FF)
                  : const Color(0xFF9FB0C7),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInputField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFFE6EDF7),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0x05FFFFFF),
            border: Border.all(color: const Color(0x14FFFFFF)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: controller,
            style: const TextStyle(color: Color(0xFFE6EDF7), fontSize: 14),
            decoration: InputDecoration(
              hintText: 'Enter $label',
              hintStyle: const TextStyle(color: Color(0x99FFFFFF)),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  void _createClone() {
    final title = _titleController.text.trim();
    final code = _codeController.text.trim();

    if (title.isEmpty || code.isEmpty) {
      _showToast('Please fill in all fields');
      return;
    }

    // Create the cloned course
    final clonedCourse = Course(
      title: title,
      description: 'Cloned from ${widget.course.title}',
      code: code,
    );

    // Show success message
    _showToast('Course cloned successfully!');

    // Call the callback if provided
    if (widget.onCourseCloned != null) {
      widget.onCourseCloned!(clonedCourse);
    }

    // Navigate back to CoursesScreen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CoursesScreen(
          onBackPressed: () => Navigator.pop(context), 
          courses: [clonedCourse], // Pass the cloned course
          onAddCourse: (course) {
            // Handle adding more courses if needed
          },
        ),
      ),
    );
  }

  void _showToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF162033),
        content: Text(
          message,
          style: const TextStyle(color: Color(0xFFE6EDF7)),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
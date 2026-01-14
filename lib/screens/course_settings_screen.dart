import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/card.dart';
import '../widgets/list_item.dart';
import '../models/course_model.dart';
import 'members_screen.dart'; // Add this import

class CourseSettingsScreen extends StatefulWidget {
  final VoidCallback? onBackPressed;
  final Course course;

  const CourseSettingsScreen({
    super.key,
    this.onBackPressed,
    required this.course,
  });

  @override
  State<CourseSettingsScreen> createState() => _CourseSettingsScreenState();
}

class _CourseSettingsScreenState extends State<CourseSettingsScreen> {
  bool _isPublic = true;
  bool _isDuplicable = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Course Settings',
        subtitle: 'Visibility / members',
        showBackButton: true,
        onBackPressed: widget.onBackPressed,
      ),
      body: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          AppCard(
            title: 'Course Information',
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
                              fontSize: 18,
                              color: Color(0xFFE6EDF7),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.course.description,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF9FB0C7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0x1A5DD6FF),
                        border: Border.all(color: const Color(0x385DD6FF)),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        widget.course.code,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF5DD6FF),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(color: Color(0x14FFFFFF)),
                const SizedBox(height: 16),
                const Text(
                  'Creator-only controls',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE6EDF7),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Changes affect all members immediately.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          AppCard(
            title: 'Visibility Settings',
            child: Column(
              children: [
                ListItem(
                  title: const Text('Public course'),
                  subtitle: 'If OFF, course becomes private and only members can read. Non-members lose access immediately.',
                  trailing: Switch(
                    value: _isPublic,
                    onChanged: (value) {
                      setState(() {
                        _isPublic = value;
                      });
                      _showToast('Course is now ${value ? 'public' : 'private'}');
                    },
                    activeColor: const Color(0xFF5DD6FF),
                  ),
                  onTap: () {
                    setState(() {
                      _isPublic = !_isPublic;
                    });
                    _showToast('Course is now ${_isPublic ? 'public' : 'private'}');
                  },
                ),
                const SizedBox(height: 12),
                ListItem(
                  title: const Text('Duplicable'),
                  subtitle: 'If ON, any user who can read this course can clone it.',
                  trailing: Switch(
                    value: _isDuplicable,
                    onChanged: (value) {
                      setState(() {
                        _isDuplicable = value;
                      });
                      _showToast('Duplicable ${value ? 'enabled' : 'disabled'}');
                    },
                    activeColor: const Color(0xFF5DD6FF),
                  ),
                  onTap: () {
                    setState(() {
                      _isDuplicable = !_isDuplicable;
                    });
                    _showToast('Duplicable ${_isDuplicable ? 'enabled' : 'disabled'}');
                  },
                ),
                const SizedBox(height: 12),
                ListItem(
                  title: const Text('Members'),
                  subtitle: _isPublic
                      ? 'Members are optional for public courses.'
                      : 'Only members can read this course.',
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0x1A5DD6FF),
                      border: Border.all(color: const Color(0x385DD6FF)),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: const Text(
                      'Manage',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF5DD6FF),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MembersScreen(
                          onBackPressed: () => Navigator.pop(context),
                          course: widget.course,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          AppCard(
            title: 'Danger Zone',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Media deletion uses soft-delete to protect clones.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF9FB0C7),
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    _showDeleteDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0x1AFF6B6B),
                    foregroundColor: const Color(0xFFFF6B6B),
                    minimumSize: const Size(double.infinity, 44),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text('Delete a media file (simulate)'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF162033),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Delete Media File',
          style: TextStyle(color: Color(0xFFFF6B6B)),
        ),
        content: const Text(
          'This will soft-delete the media file. Clones will show a "Media unavailable" warning but keep their structure.',
          style: TextStyle(color: Color(0xFF9FB0C7)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.white54)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showToast('Media soft-deleted (isDeleted=true; clones show warning)');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF6B6B),
              foregroundColor: Colors.black,
            ),
            child: const Text('Delete'),
          ),
        ],
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
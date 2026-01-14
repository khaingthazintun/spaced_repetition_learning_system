import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/card.dart';
import '../widgets/list_item.dart';
import '../models/course_model.dart';

class MembersScreen extends StatefulWidget {
  final VoidCallback? onBackPressed;
  final Course course;

  const MembersScreen({
    super.key,
    this.onBackPressed,
    required this.course,
  });

  @override
  State<MembersScreen> createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  final TextEditingController _emailController = TextEditingController();
  final List<Map<String, dynamic>> _members = [
    {'uid': 'uid_demo_creator', 'email': 'creator@demo.com', 'role': 'owner'},
    {'uid': 'uid_demo_user', 'email': 'haru@example.com', 'role': 'student'},
    {'uid': 'uid_1', 'email': 'student1@example.com', 'role': 'student'},
    {'uid': 'uid_2', 'email': 'student2@example.com', 'role': 'student'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Members',
        subtitle: 'Add / remove',
        showBackButton: true,
        onBackPressed: widget.onBackPressed,
      ),
      body: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          AppCard(
            title: 'Add Member',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Add member by email',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF9FB0C7),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0x05FFFFFF),
                    border: Border.all(color: const Color(0x14FFFFFF)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.email_outlined, size: 20, color: Color(0x99FFFFFF)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _emailController,
                          style: const TextStyle(color: Color(0xFFE6EDF7), fontSize: 13),
                          decoration: const InputDecoration(
                            hintText: 'student@example.com',
                            hintStyle: TextStyle(color: Color(0x99FFFFFF)),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _addMember,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0x1A5DD6FF),
                          foregroundColor: const Color(0xFFE6EDF7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text('Add Member'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          AppCard(
            title: 'Member List',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Removing a member triggers SRS cleanup via Cloud Function (real app).',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF9FB0C7),
                  ),
                ),
                const SizedBox(height: 12),
                ..._members.asMap().entries.map((entry) {
                  final index = entry.key;
                  final member = entry.value;
                  final isOwner = member['role'] == 'owner';

                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(12),
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
                            color: isOwner
                                ? const Color(0x1AFFD166)
                                : const Color(0x1A5DD6FF),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isOwner
                                  ? const Color(0x38FFD166)
                                  : const Color(0x385DD6FF),
                            ),
                          ),
                          child: Icon(
                            isOwner ? Icons.star : Icons.person,
                            size: 20,
                            color: isOwner
                                ? const Color(0xFFFFD166)
                                : const Color(0xFF5DD6FF),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                member['email'],
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFE6EDF7),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                member['role'],
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF9FB0C7),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isOwner)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0x1AFFD166),
                              border: Border.all(color: const Color(0x38FFD166)),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.star, size: 12, color: Color(0xFFFFD166)),
                                const SizedBox(width: 4),
                                const Text(
                                  'Owner',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFFFFD166),
                                  ),
                                ),
                              ],
                            ),
                          )
                        else
                          ElevatedButton(
                            onPressed: () => _removeMember(index),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0x1AFF6B6B),
                              foregroundColor: const Color(0xFFFF6B6B),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: const Text('Remove'),
                          ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _addMember() {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      _showToast('Please enter an email');
      return;
    }

    if (!email.contains('@') || !email.contains('.')) {
      _showToast('Please enter a valid email address');
      return;
    }

    // Check if email already exists
    if (_members.any((member) => member['email'] == email)) {
      _showToast('This email is already a member');
      return;
    }

    setState(() {
      _members.add({
        'uid': 'uid_${DateTime.now().millisecondsSinceEpoch}',
        'email': email,
        'role': 'student',
      });
    });

    _emailController.clear();
    _showToast('$email added as a member');
  }

  void _removeMember(int index) {
    final email = _members[index]['email'];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF162033),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Remove Member',
          style: TextStyle(color: Color(0xFFFF6B6B)),
        ),
        content: Text(
          'Remove $email from this course? This will revoke their access and clean up their SRS data.',
          style: const TextStyle(color: Color(0xFF9FB0C7)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.white54)),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _members.removeAt(index);
              });
              Navigator.pop(context);
              _showToast('$email removed from course');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF6B6B),
              foregroundColor: Colors.black,
            ),
            child: const Text('Remove'),
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
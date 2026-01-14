import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/card.dart';
import '../widgets/list_item.dart';

class SettingsScreen extends StatefulWidget {
  final VoidCallback? onBackPressed;

  const SettingsScreen({super.key, this.onBackPressed});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _dailyReminderEnabled = true;
  String _reminderTime = '20:00';

  // Demo due items for debug
  final List<Map<String, dynamic>> _demoDueItems = [
    {
      'type': 'question',
      'starred': true,
      'course': 'Math 101',
      'module': 'Integral',
      'topic': 'What is Integral?',
      'prompt': 'What does an integral represent?'
    },
    {
      'type': 'note',
      'starred': true,
      'course': 'Math 101',
      'module': 'Integral',
      'topic': 'What is Integral?',
      'prompt': 'Recall the notes: integral = accumulation / area under a curve.'
    },
    {
      'type': 'question',
      'starred': false,
      'course': 'Math 101',
      'module': 'Integral',
      'topic': 'Area Under the Curve',
      'prompt': 'Which method approximates area under a curve?'
    },
    {
      'type': 'question',
      'starred': true,
      'course': 'Math 101',
      'module': 'Differential',
      'topic': 'Basic Differentiation',
      'prompt': '⭐ What does the derivative represent?'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Settings',
        subtitle: 'Notifications',
        showBackButton: true,
        onBackPressed: widget.onBackPressed,
      ),
      body: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          AppCard(
            title: 'Notification Settings',
            child: Column(
              children: [
                ListItem(
                  title: const Text('Daily review reminder'),
                  subtitle: 'Sends one reminder per day when you have due reviews',
                  trailing: Switch(
                    value: _dailyReminderEnabled,
                    onChanged: (value) {
                      setState(() {
                        _dailyReminderEnabled = value;
                      });
                      _showToast('Daily reminder ${value ? 'enabled' : 'disabled'}');
                    },
                    activeColor: const Color(0xFF5DD6FF),
                  ),
                  onTap: () {
                    setState(() {
                      _dailyReminderEnabled = !_dailyReminderEnabled;
                    });
                    _showToast('Daily reminder ${_dailyReminderEnabled ? 'enabled' : 'disabled'}');
                  },
                ),
                const SizedBox(height: 12),
                ListItem(
                  title: const Text('Reminder time'),
                  subtitle: 'Local device time. Used only when daily reminder is enabled.',
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0x05FFFFFF),
                      border: Border.all(color: const Color(0x14FFFFFF)),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      _reminderTime,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF9FB0C7),
                      ),
                    ),
                  ),
                  onTap: () {
                    _showTimePicker(context);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          AppCard(
            title: 'Debug',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Prototype-only tools.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF9FB0C7),
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    _showToast('Cleared all due items');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0x1A5DD6FF),
                    foregroundColor: const Color(0xFFE6EDF7),
                    minimumSize: const Size(double.infinity, 44),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text('Clear due items'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    _showToast('Loaded ${_demoDueItems.length} review items');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0x1A6EE7B7),
                    foregroundColor: const Color(0xFFE6EDF7),
                    minimumSize: const Size(double.infinity, 44),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text('Restore sample queue'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showTimePicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF162033),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Select Time',
          style: TextStyle(color: Color(0xFF5DD6FF)),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTimeOption('08:00', 'Morning'),
            const SizedBox(height: 8),
            _buildTimeOption('12:00', 'Noon'),
            const SizedBox(height: 8),
            _buildTimeOption('20:00', 'Evening'),
            const SizedBox(height: 8),
            _buildTimeOption('22:00', 'Night'),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeOption(String time, String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _reminderTime = time;
        });
        Navigator.pop(context);
        _showToast('Reminder time set to $time');
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _reminderTime == time
              ? const Color(0x1A5DD6FF)
              : const Color(0x05FFFFFF),
          border: Border.all(
            color: _reminderTime == time
                ? const Color(0x595DD6FF)
                : const Color(0x14FFFFFF),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  time,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE6EDF7),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF9FB0C7),
                  ),
                ),
              ],
            ),
            if (_reminderTime == time)
              const Icon(Icons.check_circle, color: Color(0xFF5DD6FF), size: 20),
          ],
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
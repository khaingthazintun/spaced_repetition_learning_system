// screens/reviews_screen.dart - Updated version
import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/card.dart';
import '../widgets/list_item.dart';
import 'progress_screen.dart';


class ReviewsScreen extends StatelessWidget {
  final VoidCallback? onBackPressed; // Add this
  final Function(int)? switchToTab; // Add this



  const ReviewsScreen({
    super.key,
    this.onBackPressed,
    this.switchToTab, // Add this
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(
        title: 'Due reviews',
        subtitle: '⭐ prioritized + 📝 notes included',
        showBackButton: true,
        onBackPressed: onBackPressed, // ← USE THE PARAMETER

      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(14),
              children: [
                AppCard(
                  title: 'Queue',
                  child: Column(
                    children: [
                      ListItem(
                        title: const Row(
                          children: [
                            Icon(Icons.star, color: Color(0xFFFFD166), size: 14),
                            SizedBox(width: 4),
                            Text('Math 101 → Integral → Q12'),
                          ],
                        ),
                        subtitle: 'Due now • Starred',
                        onTap: () {},
                      ),
                      const SizedBox(height: 10),
                      ListItem(
                        title: const Row(
                          children: [
                            Icon(Icons.note, color: Color(0xFF6EE7B7), size: 14),
                            SizedBox(width: 4),
                            Text('Math 101 → Integral → Notes'),
                          ],
                        ),
                        subtitle: 'Due now • Note review (self-rating)',
                        onTap: () {},
                      ),
                      const SizedBox(height: 10),
                      ListItem(
                        title: const Text('Math 101 → Integral → Q13'),
                        subtitle: 'Due now',
                        onTap: () {},
                      ),
                      const SizedBox(height: 10),
                      ListItem(
                        title: const Text('Physics 101 → Kinematics → Q7'),
                        subtitle: 'Due now',
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Add buttons at the bottom (above the TabBar)
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  const Color(0xFF0B1220).withValues(alpha: 0.85),
                  const Color(0xFF0B1220).withValues(alpha: 0.95),
                ],
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Start first'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
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
                    child: const Text('See progress'),
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
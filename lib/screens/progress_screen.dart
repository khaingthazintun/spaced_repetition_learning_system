// lib/screens/progress_screen.dart
import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/card.dart';
import '../widgets/list_item.dart';
import '../widgets/kpi_card.dart';

class ProgressScreen extends StatelessWidget {
  final VoidCallback? onBackPressed; // Add this

  const ProgressScreen({super.key, this.onBackPressed}); // Update constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(
        title: 'Progress',
        subtitle: 'By course',
        showBackButton: true,
        onBackPressed: onBackPressed, // ← USE THE PARAMETER

      ),
      body: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          AppCard(
            title: 'Mastery snapshot',
            child: Column(
              children: [
                const SizedBox(height: 8),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1.5,
                  children: const [
                    KPICard(value: '51%', label: 'Overall'),
                    KPICard(value: '12', label: 'Due today'),
                    KPICard(value: '4', label: '⭐ Starred due'),
                    KPICard(value: '2', label: '📝 Notes due'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          AppCard(
            title: 'By course',
            child: Column(
              children: [
                ListItem(
                  title: const Text('Math 101'),
                  subtitle: 'Mastery 58%',
                  progress: 0.58,
                  onTap: () {},
                ),
                const SizedBox(height: 10),
                ListItem(
                  title: const Text('Physics 101'),
                  subtitle: 'Mastery 34%',
                  progress: 0.34,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
      // bottomNavigationBar: const CustomTabBar(selectedIndex: 3),
    );
  }
}
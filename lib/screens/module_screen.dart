// lib/screens/module_screen.dart
import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/card.dart';
import '../widgets/list_item.dart';
//import 'topic_screen.dart'; // For navigating to topics
//import 'create_topic_screen.dart'; // For creating new topics
//import 'reviews_screen.dart'; // For due reviews

class ModuleScreen extends StatelessWidget {
  const ModuleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Integral',
        subtitle: 'Math 101 → Module',
        showBackButton: true,
        actions: [
          ElevatedButton(
            onPressed: null,
            child: Text('+ Topic'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          AppCard(
            title: 'Topics',
            child: Column(
              children: [
                ListItem(
                  title: const Text('What is Integral?'),
                  subtitle: 'Video + notes + quiz • Est 10 min',
                  progress: 0.58,
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => const TopicScreen()),
                    // );
                  },
                ),
                const SizedBox(height: 10),
                ListItem(
                  title: const Text('Area Under Curve'),
                  subtitle: 'Video + notes + quiz • Est 12 min',
                  progress: 0.44,
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => const TopicScreen()),
                    // );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
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
              child: OutlinedButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const ReviewsScreen()),
                  // );
                },
                child: const Text('Due reviews'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const CreateTopicScreen()),
                  // );
                },
                child: const Text('Create topic'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
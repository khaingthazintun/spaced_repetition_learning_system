import 'package:flutter/material.dart';
import '../widgets/tab_bar.dart';
import 'home_screen.dart';
import 'courses_screen.dart';
import 'review_screen.dart';
import 'progress_screen.dart';
import '../models/course_model.dart'; // Ensure this matches your model filename
import 'menu_screen.dart';
import 'settings_screen.dart';
import 'members_screen.dart';
import 'clone_course_screen.dart';

class TabContainer extends StatefulWidget {
  final int initialTab;

  const TabContainer({super.key, this.initialTab = 0});

  @override
  State<TabContainer> createState() => _TabContainerState();
}

class _TabContainerState extends State<TabContainer> {
  late int _currentTab;

  // --- 1. DATA STATE MANAGEMENT ---
  // This is the master list that shares data between all tabs
  final List<Course> _allCourses = [];

  @override
  void initState() {
    super.initState();
    _currentTab = widget.initialTab;
  }

  // --- 2. STATE MODIFICATION LOGIC ---
  // This callback is passed to children to update the master list
  void _addCourse(Course newCourse) {
    setState(() {
      _allCourses.add(newCourse);
    });
  }

  void _onTabChanged(int index) {
    setState(() {
      _currentTab = index;
    });
  }

  // Public method to switch tabs programmatically (passed to children)
  void switchTab(int index) {
    setState(() {
      _currentTab = index.clamp(0, 2);
    });
  }

  // --- 3. DYNAMIC SCREEN RENDERING ---
  
  Widget _getCurrentScreen() {
    // Common back handler: switches to Home instead of exiting app
    void handleBack() {
      if (_currentTab != 0) {
        setState(() {
          _currentTab = 0; 
        });
      }
    }

    switch (_currentTab) {
      case 0:
        return HomeScreen(
          onBackPressed: handleBack,
          switchToTab: switchTab,
          courses: _allCourses,      // Pass the master list
          onAddCourse: _addCourse,   // Pass the update function
        );
      case 1:
        return ReviewsScreen(
          onBackPressed: handleBack,
          switchToTab: switchTab,
        );
      case 2:
        return MenuScreen(
          onBackPressed: handleBack,
          switchToTab: switchTab,
          courses: _allCourses,
        );
      default:
        return HomeScreen(
          onBackPressed: handleBack,
          switchToTab: switchTab,
          courses: _allCourses,
          onAddCourse: _addCourse,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // We use the getter to determine which screen to show
      body: _getCurrentScreen(),
      bottomNavigationBar: CustomTabBar(
        selectedIndex: _currentTab,
        onTabChanged: _onTabChanged,
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:spaced_repetition_learning_system/screens/mcq_editor_screen.dart';

class CreateTopicScreen extends StatefulWidget {
  const CreateTopicScreen({super.key});

  @override
  State<CreateTopicScreen> createState() => _CreateTopicScreenState();
}

class _CreateTopicScreenState extends State<CreateTopicScreen> {
  // List to store questions added from the MCQ Editor
  final List<MCQData> _savedQuestions = [];

  // Navigation logic to get data back from the MCQ Editor
  void _navigateAndAddMCQ(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MCQEditorScreen()),
    );

    // If result is not null, it means the user clicked 'Save'
    if (result != null && result is MCQData) {
      setState(() {
        _savedQuestions.add(result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Create Topic',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Topic Basics'),
            const SizedBox(height: 12),
            _buildInputField(Icons.label_outline, 'Topic Title (e.g., What is Integral?)'),
            const SizedBox(height: 16),
            _buildInputField(Icons.timer_outlined, 'Estimated time (e.g., 10 min)'),

            const SizedBox(height: 32),
            _buildSectionHeader('Topic Video'),
            const SizedBox(height: 12),
            _buildVideoPicker(),

            const SizedBox(height: 32),
            _buildSectionHeader('Notes'),
            const Text(
              'Notes can also be reviewed with SRS (self-rating).',
              style: TextStyle(color: Color(0xFF9FB0C7), fontSize: 12),
            ),
            const SizedBox(height: 12),
            _buildNotesField(),

            const SizedBox(height: 32),
            _buildSectionHeader('Questions'),
            const SizedBox(height: 12),

            // Display list of added questions
            if (_savedQuestions.isNotEmpty) ...[
              ..._savedQuestions.asMap().entries.map((entry) {
                return _buildQuestionSummaryCard(entry.key + 1, entry.value);
              }),
              const SizedBox(height: 16),
            ],

            _buildAddMCQButton(context),
            
            const SizedBox(height: 40),
            
            // Publish Button
            ElevatedButton(
              onPressed: () {
                // Logic to save whole topic to database goes here
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5DD6FF),
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 54),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text('Publish Topic', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // --- UI COMPONENTS ---

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildQuestionSummaryCard(int index, MCQData data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Icon(
            data.isStarred ? Icons.star : Icons.help_center_outlined,
            color: data.isStarred ? Colors.amber : const Color(0xFF5DD6FF),
            size: 20,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Question $index',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  data.question.isEmpty ? "No question text" : data.question,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Color(0xFF9FB0C7), fontSize: 12),
                ),
              ],
            ),
          ),
          const Icon(Icons.check_circle, color: Color(0xFF6EE7B7), size: 18),
        ],
      ),
    );
  }

  Widget _buildInputField(IconData icon, String hint) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: const Color(0xFF9FB0C7), size: 20),
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFF5E6D82), fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
        ),
      ),
    );
  }

  Widget _buildNotesField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: const TextField(
        maxLines: 6,
        style: TextStyle(color: Colors.white, height: 1.5),
        decoration: InputDecoration(
          hintText: 'Enter your study notes here...',
          hintStyle: TextStyle(color: Color(0xFF5E6D82), fontSize: 14),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(18),
        ),
      ),
    );
  }

  Widget _buildVideoPicker() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          const Icon(Icons.video_library_outlined, color: Color(0xFF5DD6FF)),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Add Topic Video (URL or File)',
              style: TextStyle(color: Color(0xFF9FB0C7), fontSize: 14),
            ),
          ),
          IconButton(
            onPressed: () {}, 
            icon: const Icon(Icons.add_circle_outline, color: Colors.white54),
          ),
        ],
      ),
    );
  }

  Widget _buildAddMCQButton(BuildContext context) {
    return InkWell(
      onTap: () => _navigateAndAddMCQ(context),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: const Color(0xFF5DD6FF).withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFF5DD6FF).withValues(alpha: 0.2),
          ),
        ),
        child: const Column(
          children: [
            Icon(Icons.add_circle_outline, color: Color(0xFF5DD6FF)),
            SizedBox(height: 8),
            Text(
              'Add Multiple Choice Question',
              style: TextStyle(color: Color(0xFF5DD6FF), fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
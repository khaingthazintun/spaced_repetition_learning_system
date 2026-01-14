import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class MCQEditorScreen extends StatefulWidget {
  const MCQEditorScreen({super.key});

  @override
  State<MCQEditorScreen> createState() => _MCQEditorScreenState();
}

class _MCQEditorScreenState extends State<MCQEditorScreen> {
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _questionController = TextEditingController();
  
  final List<TextEditingController> _optionControllers = [
    TextEditingController(),
    TextEditingController()
  ];
  final List<File?> _optionImages = [null, null]; // Syncs with controllers
  File? _questionImage;
  bool _isStarred = false;

  int? _correctOptionIndex;

  
  Future<void> _pickImage(int index, {bool isQuestion = false}) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() {
        if (isQuestion) {
          _questionImage = File(pickedFile.path);
        } else {
          _optionImages[index] = File(pickedFile.path);
        }
      });
    }
  }

  void _addOption() {
    setState(() {
      _optionControllers.add(TextEditingController());
      _optionImages.add(null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),
      appBar: AppBar(
        title: const Text('Add Question', style: TextStyle(fontSize: 18)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              _isStarred ? Icons.star : Icons.star_border,
              color: _isStarred ? Colors.amber : Colors.white54,
            ),
            onPressed: () => setState(() => _isStarred = !_isStarred),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Question Stem',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 12),
            _buildTextField(
            Icons.help_outline, 'Type your question...',
             maxLines: 3,
             controller: _questionController
            ),
            const SizedBox(height: 12),
            
            
            _buildImageUploader(
              'Add Question Image',
              _questionImage,
              () => _pickImage(0, isQuestion: true),
            ),

            const SizedBox(height: 30),
            const Text('Options',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 12),
 
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _optionControllers.length,
              itemBuilder: (context, index) {
                return _buildOptionItem(index, _optionControllers[index]);
              },
            ),

            TextButton.icon(
              onPressed: _addOption,
              icon: const Icon(Icons.add, size: 20, color: Color(0xFF5DD6FF)),
              label: const Text('Add another option',
                  style: TextStyle(color: Color(0xFF5DD6FF))),
            ),

            const SizedBox(height: 40),
            _buildSaveButton(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // --- UI HELPER METHODS ---

  Widget _buildOptionItem(int index, TextEditingController controller) {
    bool isCorrect = _correctOptionIndex == index;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Row(
            children: [
              // Number Circle
              CircleAvatar(
                radius: 12,
                backgroundColor: isCorrect ? const Color(0xFF5DD6FF) : const Color(0xFF1A2332),
                child: Text('${index + 1}',
                    style: TextStyle(fontSize: 11, color: isCorrect ? Colors.black : Colors.white)),
              ),
              const SizedBox(width: 12),
              // Text Field
              Expanded(
                child: _buildTextField(
                  Icons.edit, 
                  'Option text...', 
                  maxLines: 1, 
                  controller: controller
                ),
              ),
              const SizedBox(width: 8),
              // THE CORRECT ANSWER TOGGLE
              IconButton(
                onPressed: () => setState(() => _correctOptionIndex = index),
                icon: Icon(
                  isCorrect ? Icons.check_circle : Icons.radio_button_unchecked,
                  color: isCorrect ? const Color(0xFF6EE7B7) : Colors.white24,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 36, right: 48), // Align with text field
            child: _buildImageUploader(
              'Add image for this option',
              _optionImages[index],
              () => _pickImage(index),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageUploader(String label, File? imageFile, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        height: imageFile != null ? 180 : 54,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha:0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white10),
          image: imageFile != null
              ? DecorationImage(image: FileImage(imageFile), fit: BoxFit.cover)
              : null,
        ),
        child: imageFile == null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.image_outlined, color: Color(0xFF9FB0C7), size: 20),
                  const SizedBox(width: 10),
                  Text(label,
                      style: const TextStyle(color: Color(0xFF5E6D82), fontSize: 13)),
                ],
              )
            : Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                      color: Colors.black54, shape: BoxShape.circle),
                  child: const Icon(Icons.edit, color: Colors.white, size: 16),
                ),
              ),
      ),
    );
  }

  Widget _buildTextField(IconData icon, String hint, {int maxLines = 1, TextEditingController? controller}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha:0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: TextField(
        controller: controller, // <-- CONNECT IT HERE
        maxLines: maxLines,
        style: const TextStyle(color: Colors.white, fontSize: 14),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: const Color(0xFF9FB0C7), size: 18),
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFF5E6D82), fontSize: 13),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: () {
        if (_correctOptionIndex == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please select the correct answer')),
          );
          return;
        }

        // FIXED: Now passing correctOptionIndex to the constructor
        final newQuestion = MCQData(
          question: _questionController.text,
          options: _optionControllers.map((c) => c.text).toList(),
          correctOptionIndex: _correctOptionIndex, // Passed correctly here
          questionImage: _questionImage,
          optionImages: List.from(_optionImages),
          isStarred: _isStarred,
        );

        Navigator.pop(context, newQuestion);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF5DD6FF),
        foregroundColor: Colors.black,
        minimumSize: const Size(double.infinity, 54),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
      ),
      child: const Text('Save Question',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
    );
  }
  @override
  void dispose() {
    _questionController.dispose();
    for (var controller in _optionControllers) {
      controller.dispose();
   }
    super.dispose();
  }
}

class MCQData {
  final String question;
  final List<String> options;
  final int? correctOptionIndex; // Added this
  final File? questionImage;
  final List<File?> optionImages;
  final bool isStarred;

  MCQData({
    required this.question,
    required this.options,
    this.correctOptionIndex,
    this.questionImage,
    required this.optionImages,
    required this.isStarred,
  });
}
import 'package:flutter/material.dart';
import 'package:spaced_repetition_learning_system/screens/tab_container.dart';

class RegisterScreen extends StatelessWidget {
  final VoidCallback? onBackPressed;

  const RegisterScreen({super.key, this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0B1220), Color(0xFF162033)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Back button at top
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 20,
                        color: Color(0xFF9FB0C7),
                      ),
                      onPressed: onBackPressed ?? () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Back to Login',
                      style: TextStyle(
                        color: Color(0xFF9FB0C7),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      // Register section
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white.withOpacity(0.1)),
                        ),
                        child: Column(
                          children: [
                            // Document icon
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: const Color(0x1A5DD6FF),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: const Color(0x385DD6FF)),
                              ),
                              child: const Icon(
                                Icons.person_add_outlined,
                                size: 32,
                                color: Color(0xFF5DD6FF),
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Title
                            const Text(
                              'Create account',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFE6EDF7),
                              ),
                            ),
                            const SizedBox(height: 4),
                            // Subtitle
                            const Text(
                              'This is a UI-only prototype',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF9FB0C7),
                              ),
                            ),
                            const SizedBox(height: 24),
                            // Name field
                            _buildTextFieldWithLabel('Name', 'Your name', Icons.person_outline),
                            const SizedBox(height: 16),
                            // Email field
                            _buildTextFieldWithLabel('Email', 'you@example.com', Icons.email_outlined),
                            const SizedBox(height: 16),
                            // Password field
                            _buildTextFieldWithLabel('Password', '••••••••', Icons.lock_outline, isPassword: true),
                            const SizedBox(height: 24),
                            // Register button
                            ElevatedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Account created (prototype) → Home'),
                                    backgroundColor: Color(0xFF162033),
                                  ),
                                );
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) => const TabContainer()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF5DD6FF),
                                foregroundColor: Colors.black,
                                minimumSize: const Size(double.infinity, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                elevation: 0,
                              ),
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Already have account? Login
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Already have an account? ',
                                  style: TextStyle(
                                    color: Color(0xFF9FB0C7),
                                    fontSize: 14,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Login',
                                    style: TextStyle(
                                      color: Color(0xFF5DD6FF),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 60),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFieldWithLabel(String label, String hint, IconData icon, {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFFE6EDF7),
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 12),
                child: Icon(
                  icon,
                  color: const Color(0xFF9FB0C7),
                  size: 20,
                ),
              ),
              Expanded(
                child: TextField(
                  obscureText: isPassword,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: const TextStyle(color: Color(0xFF5E6D82)),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
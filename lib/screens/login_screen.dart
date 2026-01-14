import 'package:flutter/material.dart';
import 'package:spaced_repetition_learning_system/screens/tab_container.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void _showForgotPasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF162033),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Reset Password', style: TextStyle(color: Color(0xFF5DD6FF))),
        content: const Text(
          'Enter your email address and we will send you a link to reset your password.',
          style: TextStyle(color: Color(0xFF9FB0C7)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.white54)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF5DD6FF)),
            child: const Text('Send Link', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        width: double.infinity,
        height: double.infinity, // Ensure gradient covers full screen
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0B1220), Color(0xFF162033)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Image.asset('assets/logos/app_logo_rmbg.png', width: 100, height: 100),
                const SizedBox(height: 20),
                const Text(
                  'SRS Learning App',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    color: Color(0xFF5DD6FF),
                  ),
                ),
                const SizedBox(height: 40),
                _buildTextField(Icons.email_outlined, 'Email Address'),
                const SizedBox(height: 16),
                _buildTextField(Icons.lock_outline, 'Password', isPassword: true),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => _showForgotPasswordDialog(context), // Added popup
                    child: const Text(
                      'Forgot your password?',
                      style: TextStyle(color: Color(0xFF9FB0C7), fontSize: 13),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const TabContainer()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5DD6FF),
                    foregroundColor: Colors.black,
                    minimumSize: const Size(double.infinity, 54),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text('Login', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 40),
                const Text(
                  'log in with',
                  style: TextStyle(color: Color(0xFF9FB0C7), fontSize: 14),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _socialIcon('assets/logos/google_logo.png'),
                    const SizedBox(width: 25),
                    _socialIcon('assets/logos/facebook_logo.png'),
                    const SizedBox(width: 25),
                    _socialIcon('assets/logos/x_logo.png'),
                  ],
                ),
                const SizedBox(height: 40), // Bottom padding for scrolling
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(IconData icon, String hint, {bool isPassword = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: TextField(
        obscureText: isPassword,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: const Color(0xFF9FB0C7)),
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFF5E6D82)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
        ),
      ),
    );
  }

  Widget _socialIcon(String assetPath) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.all(5), // Adjusted padding for better look
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withValues(alpha: 0.05),
          border: Border.all(color: Colors.white10),
        ),
        child: Image.asset(assetPath, width: 30, height: 30),
      ),
    );
  }
}
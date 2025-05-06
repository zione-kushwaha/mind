import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  bool _isParent = true;
  bool _isLoading = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 0.95,
      end: 1.05,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _toggleUserType() {
    setState(() {
      _isParent = !_isParent;
    });
  }

  void _handleLogin() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate login process
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    // Navigate to home screen on success
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated Logo
                ScaleTransition(
                  scale: _animation,
                  child: Lottie.asset('assets/lottie/welcome.json', height: 50),
                ),

                SizedBox(height: 20),

                // Welcome Text
                Text(
                  'Welcome to LearnTogether!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenDyslexic',
                    color: Color(0xFF5D9CEC),
                  ),
                ),

                SizedBox(height: 30),

                // Parent/Child Toggle
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildToggleButton('Parent', true),
                      _buildToggleButton('Child', false),
                    ],
                  ),
                ),

                SizedBox(height: 30),

                // Login Form
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildInputField(
                        controller: _emailController,
                        label: 'Email/Username',
                        icon: Icons.email,
                        isPassword: false,
                      ),

                      SizedBox(height: 15),

                      _buildInputField(
                        controller: _passwordController,
                        label: 'Password',
                        icon: Icons.lock,
                        isPassword: true,
                      ),

                      SizedBox(height: 20),

                      // Login Button
                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF5D9CEC), Color(0xFF48CFAD)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF5D9CEC).withOpacity(0.3),
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(25),
                            onTap: _isLoading ? null : _handleLogin,
                            child: Center(
                              child:
                                  _isLoading
                                      ? CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation(
                                          Colors.white,
                                        ),
                                      )
                                      : Text(
                                        'LOGIN',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'OpenDyslexic',
                                        ),
                                      ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 15),

                // Forgot Password
                TextButton(
                  onPressed: () {
                    // Navigate to password recovery
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Color(0xFF5D9CEC),
                      fontFamily: 'OpenDyslexic',
                    ),
                  ),
                ),

                SizedBox(height: 10),

                // Sign Up
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account? ',
                      style: TextStyle(
                        fontFamily: 'OpenDyslexic',
                        color: Colors.grey[600],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigate to sign up
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Color(0xFFF6BB42),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenDyslexic',
                        ),
                      ),
                    ),
                  ],
                ),

                // Background decorative elements
                SizedBox(height: 20),
                _buildBackgroundElements(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildToggleButton(String text, bool isParentButton) {
    bool isSelected = _isParent == isParentButton;
    return GestureDetector(
      onTap: _toggleUserType,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF5D9CEC) : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[600],
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenDyslexic',
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required bool isPassword,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      style: TextStyle(fontFamily: 'OpenDyslexic'),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.grey[600],
          fontFamily: 'OpenDyslexic',
        ),
        prefixIcon: Icon(icon, color: Color(0xFF5D9CEC)),
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xFF5D9CEC), width: 2),
        ),
      ),
    );
  }

  Widget _buildBackgroundElements() {
    return SizedBox(
      height: 100,
      child: Stack(
        children: [
          Positioned(
            left: 20,
            bottom: 0,
            child: Lottie.asset(
              'assets/lottie/floating_circle.json',
              width: 100,
              height: 100,
            ),
          ),
          Positioned(
            right: 50,
            top: 0,
            child: Lottie.asset(
              'assets/lottie/floating_triangle.json',
              width: 800,
              height: 80,
            ),
          ),
        ],
      ),
    );
  }
}

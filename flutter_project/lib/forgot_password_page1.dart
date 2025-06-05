import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final padding = media.width * 0.05;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: media.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFF8C1C3), // light cherry red
                Color(0xFFB2204B),
                Color(0xFF4B0B2C), // deep red wine
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: padding,
              vertical: media.height * 0.04,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App Logo
                SizedBox(
                  height: media.height * 0.25,
                  child: Image.asset(
                    "assets/Untitled_design-removebg-preview.png",
                    fit: BoxFit.contain,
                  ),
                ),

                SizedBox(height: media.height * 0.02),

                // Illustration
                SizedBox(
                  height: media.height * 0.20,
                  child: Image.asset(
                    "assets/Forgot password-1.png",
                    fit: BoxFit.contain,
                  ),
                ),

                SizedBox(height: media.height * 0.02),

                Text(
                  "Please enter your provided email address",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: media.width * 0.045,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  "to receive a verification code",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: media.width * 0.04,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: media.height * 0.02),

                // Email Input
                Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: emailController,
                    style: const TextStyle(color: Colors.white),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      hintStyle: const TextStyle(color: Colors.white70),
                      prefixIcon: const Icon(Icons.email, color: Colors.white70),
                      filled: true,
                      fillColor: Colors.white.withAlpha(51),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Email is required';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value.trim())) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                ),

                SizedBox(height: media.height * 0.04),

                // Send Code Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        final email = emailController.text.trim();
                        Navigator.pushNamed(
                          context,
                          '/otp-verification',
                          arguments: email,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF4B0B2C),
                      padding: EdgeInsets.symmetric(
                        vertical: media.height * 0.018,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Send Code',
                      style: TextStyle(
                        fontSize: media.width * 0.045,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

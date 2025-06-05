import 'package:flutter/material.dart';

class EnterOldPasswordPage extends StatefulWidget {
  const EnterOldPasswordPage({super.key});

  @override
  State<EnterOldPasswordPage> createState() => _EnterOldPasswordPageState();
}

class _EnterOldPasswordPageState extends State<EnterOldPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();

  bool _obscure = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _oldPasswordController.dispose();
    super.dispose();
  }

  // Simulated async API call
  Future<bool> validateOldPassword(String inputPassword) async {
    await Future.delayed(const Duration(seconds: 2));
    const correctOldPassword = 'OldPass123';
    return inputPassword == correctOldPassword;
  }

  void _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);

      bool isValid = await validateOldPassword(_oldPasswordController.text);

      setState(() => _isLoading = false);

      if (isValid) {
        Navigator.pushNamed(context, '/resetPassword');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Incorrect old password.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF6e3177);
    const accentColor = Color(0xFF1a93ac);
    const backgroundColor = Color(0xFFD8D7DD);
    const buttonColor = Color(0xFF6e3177);
    const textFieldFillColor = Colors.white;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 🔼 Logo
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Image.asset(
                  'assets/Untitled_design-removebg-preview.png',
                  height: 150,
                  fit: BoxFit.contain,
                ),
              ),

              // 🔐 Form section
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(
                        'Enter Your Old Password',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // 🔒 Old password field
                      TextFormField(
                        controller: _oldPasswordController,
                        obscureText: _obscure,
                        decoration: InputDecoration(
                          hintText: 'Old Password',
                          filled: true,
                          fillColor: textFieldFillColor,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscure ? Icons.visibility_off : Icons.visibility,
                              color: primaryColor,
                            ),
                            onPressed: () => setState(() => _obscure = !_obscure),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: primaryColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: accentColor),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your old password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),

                      // 🔘 Submit button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _submit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: buttonColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: _isLoading
                              ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                              : const Text('Reset Password'),
                        ),
                      ),
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
}

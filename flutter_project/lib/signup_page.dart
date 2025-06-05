import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_theme.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  DateTime? selectedDate;
  final TextEditingController dobController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  Shader linearGradientShader(Rect bounds) {
    return const LinearGradient(
      colors: [Color(0xFFF8C1C3), Color(0xFF4B0B2C)],
    ).createShader(bounds);
  }

  Future<void> _selectDate() async {
    DateTime initialDate = selectedDate ?? DateTime(2000);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        dobController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF6e3177),
            Color(0xFFb43471),
            Color(0xFFe35d52),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 4),
                Image.asset(
                  'assets/Signup_illustration.png',
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 110,
                ),
                const SizedBox(height: 10),

                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    const CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, size: 45, color: Colors.grey),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 4,
                      child: InkWell(
                        onTap: () {},
                        child: const CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.purple,
                          child: Icon(Icons.camera_alt, size: 12, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                const Text("Add a profile picture (optional)", style: TextStyle(fontSize: 10, color: Colors.black54)),
                const SizedBox(height: 10),

                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'First Name',
                            prefixIcon: ShaderMask(
                              shaderCallback: linearGradientShader,
                              blendMode: BlendMode.srcIn,
                              child: const Icon(Icons.person),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Last Name',
                            prefixIcon: ShaderMask(
                              shaderCallback: linearGradientShader,
                              blendMode: BlendMode.srcIn,
                              child: const Icon(Icons.person_outline),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                SizedBox(
                  height: 39,
                  child: TextField(
                    controller: dobController,
                    readOnly: true,
                    onTap: _selectDate,
                    decoration: InputDecoration(
                      hintText: 'Date of Birth',
                      prefixIcon: ShaderMask(
                        shaderCallback: linearGradientShader,
                        blendMode: BlendMode.srcIn,
                        child: const Icon(Icons.cake),
                      ),
                      suffixIcon: ShaderMask(
                        shaderCallback: linearGradientShader,
                        blendMode: BlendMode.srcIn,
                        child: const Icon(Icons.calendar_today),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40,
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: 'Email ID',
                          prefixIcon: ShaderMask(
                            shaderCallback: linearGradientShader,
                            blendMode: BlendMode.srcIn,
                            child: const Icon(Icons.email),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'We will send a code for verification',
                      style: GoogleFonts.alegreya(
                        fontSize: 11,
                        fontWeight: FontWeight.w300,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),

                SizedBox(
                  height: 40,
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: 'Phone Number',
                      prefixIcon: ShaderMask(
                        shaderCallback: linearGradientShader,
                        blendMode: BlendMode.srcIn,
                        child: const Icon(Icons.phone),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                SizedBox(
                  height: 40,
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'New Password',
                      prefixIcon: ShaderMask(
                        shaderCallback: linearGradientShader,
                        blendMode: BlendMode.srcIn,
                        child: const Icon(Icons.lock),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 40,
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      prefixIcon: ShaderMask(
                        shaderCallback: linearGradientShader,
                        blendMode: BlendMode.srcIn,
                        child: const Icon(Icons.lock_outline),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                ElevatedButton(
                  onPressed: () {
                    final email = emailController.text.trim();
                    if (email.isNotEmpty && email.contains('@')) {
                      Navigator.pushNamed(
                        context,
                        '/emailVerification',
                        arguments: email,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please enter a valid email")),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFb43471),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 1),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black87,
                      ),
                    ),
                    ShaderMask(
                      shaderCallback: (bounds) {
                        return const LinearGradient(
                          colors: [Color(0xFFF8C1C3), Color(0xFF4B0B2C)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ).createShader(bounds);
                      },
                      blendMode: BlendMode.srcIn,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 1),
                const Text('Or sign up with', style: TextStyle(fontSize: 12, color: Colors.black54)),
                const SizedBox(height: 1),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(10),
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      child: Image.asset(
                        'assets/linkedin_logo.png',
                        width: 30,
                        height: 30,
                      ),
                    ),
                    const SizedBox(width: 11),
                    const Text('OR', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 11),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(10),
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      child: Image.asset(
                        'assets/github_logo.png',
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

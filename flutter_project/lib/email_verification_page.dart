import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailVerificationPage extends StatelessWidget {
  final String email;
  const EmailVerificationPage({super.key, required this.email});

  String maskedEmail(String email) {
    final parts = email.split('@');
    if (parts.length != 2) return email;
    final name = parts[0];
    final domain = parts[1];
    final maskedName = name.length > 2
        ? '${name.substring(0, 2)}***'
        : '${name[0]}***';
    return '$maskedName@$domain';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 20),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Image.asset(
                    'assets/Untitled_design-removebg-preview.png',
                    height: 130,
                  ),
                  const SizedBox(height: 3),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/emailverificationillustration.png',
                          height: 70,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Verify your email",
                          style: GoogleFonts.lato(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "We have sent a verification code to",
                          style: GoogleFonts.lato(fontSize: 12, color: Colors.black54),
                        ),
                        Text(
                          email,
                          style: GoogleFonts.lato(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 1),
                        Text(
                          "Please check your inbox and input the code below to activate your account",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(fontSize: 12, color: Colors.black54),
                        ),
                        const SizedBox(height: 10),

                        // OTP Input Boxes
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(4, (index) {
                            return SizedBox(
                              width: 50,
                              child: TextField(
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                maxLength: 1,
                                decoration: InputDecoration(
                                  counterText: '',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                        const SizedBox(height: 8),

                        // Verify Email Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              // Verification logic here
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              backgroundColor: const Color(0xFFB2204B),
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              "Verify Email",
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

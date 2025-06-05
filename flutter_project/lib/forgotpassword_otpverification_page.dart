import 'package:flutter/material.dart';

class OTPVerificationPage extends StatefulWidget {
  const OTPVerificationPage({super.key});

  @override
  State<OTPVerificationPage> createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  late String email;
  final List<TextEditingController> _controllers =
  List.generate(4, (index) => TextEditingController());
  final List<FocusNode> _focusNodes =
  List.generate(4, (index) => FocusNode());

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args is String) {
      email = args;
    } else {
      email = "Unknown";
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onVerifyPressed() {
    String otp = _controllers.map((e) => e.text).join();
    if (otp.length == 4) {
      Navigator.pushNamed(context, '/reset-password');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter all 4 digits of the OTP"),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final padding = media.width * 0.06;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFF8C1C3),
              Color(0xFFB2204B),
              Color(0xFF4B0B2C),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: padding, vertical: media.height * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: media.height * 0.010),
              Text(
                "Verify your email",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: media.width * 0.06,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: media.height * 0.01),

              // Logo
              SizedBox(
                height: media.height * 0.20,
                child: Image.asset(
                  "assets/Untitled_design-removebg-preview.png",
                  fit: BoxFit.contain,
                ),
              ),

              SizedBox(height: media.height * 0.01),

              // Illustration
              SizedBox(
                height: media.height * 0.19,
                child: Image.asset(
                  "assets/Forgot passord-emailOTP.png",
                  fit: BoxFit.contain,
                ),
              ),

              SizedBox(height: media.height * 0.02),
              Text(
                "Please enter the 4-digit code sent to",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: media.width * 0.045,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: media.height * 0.005),
              Text(
                email,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: media.width * 0.04,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: media.height * 0.02),

              // OTP Inputs
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  return SizedBox(
                    width: media.width * 0.15,
                    child: TextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: media.width * 0.05,
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                        filled: true,
                        fillColor: Color.fromRGBO(255, 255, 255, 0.2),
                          border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) {
                        if (value.length == 1) {
                          if (index < _focusNodes.length - 1) {
                            _focusNodes[index + 1].requestFocus();
                          } else {
                            _focusNodes[index].unfocus();
                          }
                        }
                      },
                    ),
                  );
                }),
              ),

              SizedBox(height: media.height * 0.02),

              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Resend code",
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                    fontSize: media.width * 0.04,
                  ),
                ),
              ),

              SizedBox(height: media.height * 0.02),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _onVerifyPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF4B0B2C),
                    padding: EdgeInsets.symmetric(
                      vertical: media.height * 0.018,
                    ),
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Verify',
                    style: TextStyle(
                      fontSize: media.width * 0.049,
                      fontWeight: FontWeight.bold,
                    ),
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

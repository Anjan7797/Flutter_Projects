import 'package:flutter/material.dart';
import 'package:flutter_project/app_theme.dart';
import 'package:flutter_project/drawer_calendar_page.dart';
import 'package:flutter_project/login_page.dart';
import 'package:flutter_project/forgotpassword_otpverification_page.dart';
import 'package:flutter_project/forgot_password_page1.dart';
import 'package:flutter_project/resetpassword_page.dart';
import 'package:flutter_project/home_page.dart';
import 'package:flutter_project/drawer_scanQR_page.dart';
import 'package:flutter_project/drawer_oldPassword_page.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Wavica());
}

class Wavica extends StatelessWidget {
  const Wavica({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mentos',
      theme: AppTheme.themeData,
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomePage(),
        '/calendar': (context) => CalendarPage(),
        '/scanQr': (context) => const ScanQrPage(),
        '/login': (context) =>  LoginPage(),
        '/forgot-password': (context) => ForgotPasswordPage(),
        '/otp-verification': (context) => OTPVerificationPage(),
        '/reset-password': (context) => const ResetPasswordPage(),//sign up page password creation
        '/enterOldPassword': (context) => const EnterOldPasswordPage(),
        '/resetPassword': (context) => const ResetPasswordPage(),//home page drawer reset password navigation
      },
    );
  }
}

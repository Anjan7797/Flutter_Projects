import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Call {
  final String name;
  final String date;
  final String duration;

  Call({required this.name, required this.date, required this.duration});
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  bool _showDrawer = false;
  late final AnimationController _controller;
  late final Animation<Offset> _drawerSlide;
  final TextEditingController _codeController = TextEditingController();

  static const Color primaryColor = Color(0xFFB2204B);
  static const Color drawerColor = Color(0xFFFDEFEF);
  static const Color gradientTop = Color(0xFFF8C1C3);
  static const Color gradientBottom = Color(0xFF4B0B2C);

  final List<Call> recentCalls = [
    Call(name: 'Alice', date: 'May 15, 10:00 AM', duration: '15 min'),
    Call(name: 'Bob', date: 'May 14, 4:30 PM', duration: '25 min'),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _drawerSlide = Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [gradientTop, primaryColor, gradientBottom],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: _showDrawer ? drawerColor : Colors.transparent,
          elevation: _showDrawer ? 4 : 0,
          titleSpacing: 16,
          title: Row(
            children: [
              Image.asset('assets/Untitled_design-removebg-preview.png', height: 100),
              const SizedBox(width: 3),
              Image.asset('assets/wavica_logo_loginpage.png', height: 18),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _showDrawer = true;
                  });
                  _controller.forward();
                },
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  foregroundColor: primaryColor,
                  child: Icon(Icons.person),
                ),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            _buildMainContent(context),
            if (_showDrawer) ...[
              GestureDetector(
                onTap: () {
                  _controller.reverse();
                  setState(() {
                    _showDrawer = false;
                  });
                },
                child: Container(
                  color: Colors.black.withAlpha(128),
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              SlideTransition(
                position: _drawerSlide,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: MediaQuery.of(context).size.width < 600
                        ? MediaQuery.of(context).size.width * 0.7
                        : 400,
                    height: double.infinity,
                    decoration: const BoxDecoration(
                      color: drawerColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    child: SafeArea(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 16),
                            _buildDrawerItem(Icons.person, 'Profile', '/profile', Colors.pink),
                            _buildDrawerItem(Icons.contacts, 'Contacts', '/contacts', Colors.teal),
                            _buildDrawerItem(Icons.calendar_month, 'Calendar', '/calendar', Colors.blueAccent),
                            _buildDrawerItem1(Icons.lock_reset, 'Reset Password', '/resetPassword', Colors.cyan),
                            _buildDrawerItem(Icons.qr_code_scanner_sharp, 'Scan QR Code', '/scanQr', Colors.black54),
                            _buildDrawerItem(Icons.history_sharp, 'Call History', '/recentCalls', Color(0xFFB2204B)),
                            _buildDrawerItem(Icons.help_outline, 'Help & Feedback', '/help', Colors.blueGrey),
                            _buildDrawerItem(Icons.info_outline, 'About', '/about', Colors.black54),
                            _buildDrawerItem(Icons.share, 'Share', '/share', Colors.blue),
                            _buildDrawerItem(Icons.logout, 'Log Out', '/logoutPage', Colors.red.shade900),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          child: const Icon(Icons.video_call),
          onPressed: () => Navigator.pushNamed(context, '/startCall'),
        ),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi, User! 👋',
              style: GoogleFonts.alegreya(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'Ready to connect with your world.',
              style: TextStyle(color: Colors.white.withAlpha(230)),
            ),
            const SizedBox(height: 30),

            ElevatedButton.icon(
              style: _elevatedButtonStyle(),
              icon: const Icon(Icons.add_ic_call_sharp),
              label: const Text('Start a New Audio Call'),
              onPressed: () => Navigator.pushNamed(context, '/startAudioCall'),
            ),
            const SizedBox(height: 14),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: _elevatedButtonStyle(),
                    icon: const Icon(Icons.video_call),
                    label: const Text('Video Call'),
                    onPressed: () => Navigator.pushNamed(context, '/startCall'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    style: _elevatedButtonStyle(),
                    icon: const Icon(Icons.meeting_room),
                    label: const Text('Join Code'),
                    onPressed: () => _showJoinDialog(context),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),

            Text(
              'Recent Calls',
              style: GoogleFonts.alegreya(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: recentCalls.length,
              itemBuilder: (context, index) {
                final call = recentCalls[index];
                return Card(
                  color: Colors.white.withAlpha(230),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.call, color: primaryColor),
                    title: Text('Call with ${call.name}'),
                    subtitle: Text('${call.date} - ${call.duration}'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  ButtonStyle _elevatedButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: drawerColor,
      foregroundColor: primaryColor,
      minimumSize: const Size.fromHeight(50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  void _showJoinDialog(BuildContext context) {
    _codeController.clear();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: drawerColor,
        title: const Text('Enter Meeting Code'),
        content: TextField(
          controller: _codeController,
          decoration: const InputDecoration(hintText: 'Meeting Code'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              final code = _codeController.text.trim();
              if (code.isNotEmpty) {
                Navigator.pop(context);
                // TODO: Implement join meeting logic here
              }
            },
            child: const Text('Join'),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String label, String route, Color color) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(label),
      onTap: () {
        _controller.reverse();
        setState(() {
          _showDrawer = false;
        });
        if (label == 'Log Out') {
          Navigator.pushReplacementNamed(
              context,
              '/login',
            arguments: 'Your account has been successfully logged out',
          );
        } else {
          Navigator.pushNamed(context, route);
        }
      },
    );
  }
  Widget _buildDrawerItem1(IconData icon, String label, String route, Color color) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(label),
      onTap: () {
        _controller.reverse();
        setState(() {
          _showDrawer = false;
        });
        if (label == 'Log Out') {
          Navigator.pushReplacementNamed(
            context,
            '/login',
            arguments: 'Your account has been successfully logged out',
          );
        } else if (label == 'Reset Password') {
          Navigator.pushNamed(context, '/enterOldPassword');
        } else {
          Navigator.pushNamed(context, route);
        }
      },
    );
  }

}

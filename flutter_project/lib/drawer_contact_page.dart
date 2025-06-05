// import 'package:flutter/material.dart';
// import 'package:contacts_service/contacts_service.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class ContactsPage extends StatefulWidget {
//   const ContactsPage({Key? key}) : super(key: key);
//
//   @override
//   State<ContactsPage> createState() => _ContactsPageState();
// }
//
// class _ContactsPageState extends State<ContactsPage> {
//   List<Contact> _contacts = [];
//   List<Contact> _filteredContacts = [];
//   final TextEditingController _searchController = TextEditingController();
//
//   // Only the gradient is defined now
//   final LinearGradient backgroundGradient = const LinearGradient(
//     colors: [
//       Color(0xFFF8C1C3),
//       Color(0xFFB2204B),
//       Color(0xFF4B0B2C),
//     ],
//     begin: Alignment.topCenter,
//     end: Alignment.bottomCenter,
//   );
//
//   // Picked colors sampled from the gradient for usage
//   final Color primaryColor = const Color(0xFFB2204B);   // middle gradient color
//   final Color accentColor = const Color(0xFF4B0B2C);    // bottom gradient color
//   final Color textFieldFillColor = const Color(0xFFF8C1C3); // top gradient color (lightest)
//
//   @override
//   void initState() {
//     super.initState();
//     _requestPermissionAndFetchContacts();
//     _searchController.addListener(_filterContacts);
//   }
//
//   Future<void> _requestPermissionAndFetchContacts() async {
//     var status = await Permission.contacts.status;
//
//     if (status.isDenied || status.isRestricted) {
//       status = await Permission.contacts.request();
//     }
//
//     if (status.isGranted) {
//       _fetchContacts();
//     } else if (status.isPermanentlyDenied) {
//       _showPermissionDialog();
//     }
//   }
//
//   Future<void> _fetchContacts() async {
//     final contacts = await ContactsService.getContacts(withThumbnails: false);
//     setState(() {
//       _contacts = contacts.toList();
//       _filteredContacts = _contacts;
//     });
//   }
//
//   void _showPermissionDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Permission Required'),
//         content: const Text(
//             'Contacts permission is permanently denied. Please enable it from app settings to view contacts.'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               openAppSettings();
//               Navigator.pop(context);
//             },
//             child: const Text('Open Settings'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _filterContacts() {
//     final query = _searchController.text.toLowerCase();
//     setState(() {
//       _filteredContacts = _contacts.where((contact) {
//         final name = contact.displayName?.toLowerCase() ?? '';
//         return name.contains(query);
//       }).toList();
//     });
//   }
//
//   Widget _buildContactTile(Contact contact) {
//     final initials = (contact.initials() ?? '').toUpperCase();
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: ListTile(
//         leading: CircleAvatar(
//           backgroundColor: accentColor,
//           child: Text(initials, style: const TextStyle(color: Colors.white)),
//         ),
//         title: Text(
//           contact.displayName ?? 'No Name',
//           style: const TextStyle(color: Colors.black87),
//         ),
//         subtitle: contact.phones!.isNotEmpty
//             ? Text(
//           contact.phones!.first.value ?? '',
//           style: const TextStyle(color: Colors.black54),
//         )
//             : null,
//         trailing: IconButton(
//           icon: Icon(Icons.call, color: primaryColor),
//           onPressed: () {
//             // TODO: Handle call functionality
//           },
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: primaryColor,
//         title: const Text('Contacts'),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: backgroundGradient,
//         ),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: TextField(
//                 controller: _searchController,
//                 style: const TextStyle(color: Colors.black87),
//                 decoration: InputDecoration(
//                   hintText: 'Search contacts...',
//                   hintStyle: const TextStyle(color: Colors.black45),
//                   fillColor: textFieldFillColor,
//                   filled: true,
//                   prefixIcon: const Icon(Icons.search, color: Colors.black54),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: _filteredContacts.isEmpty
//                   ? const Center(
//                 child: Text(
//                   'No contacts found.',
//                   style: TextStyle(color: Colors.white, fontSize: 16),
//                 ),
//               )
//                   : ListView.builder(
//                 itemCount: _filteredContacts.length,
//                 itemBuilder: (context, index) =>
//                     _buildContactTile(_filteredContacts[index]),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }
// }

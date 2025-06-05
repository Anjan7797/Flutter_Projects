
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final Map<DateTime, Map<String, dynamic>> _events = {};

  String _scheduleType = 'Event';
  bool _allDay = true;
  String _repeat = 'Does not repeat';
  String _notification = 'Add Notification';
  Color _selectedColor = Colors.red;
  final TextEditingController _eventDescriptionController = TextEditingController();

  final List<Color> _colors = [
    Colors.red,
    Colors.pink,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.teal,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ];

  final List<String> _weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  List<String> _customRepeatDays = [];

  void _showRepeatDialog(Function setModalState) {
    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Repeat'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              'Does not repeat',
              'Every day',
              'Every week',
              'Every month',
              'Every year',
              'Custom',
            ].map((option) => RadioListTile(
              title: Text(option),
              value: option,
              groupValue: _repeat,
              onChanged: (value) {
                setState(() => _repeat = value!);
                setModalState(() => _repeat = value!);
                if (value == 'Custom') {
                  _showCustomRepeatDialog(setModalState);
                } else {
                  Navigator.pop(context);
                }
              },
            )).toList(),
          ),
        ),
      ),
    );
  }

  void _showCustomRepeatDialog(Function setModalState) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Select Repeat Days'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: _weekdays.map((day) => CheckboxListTile(
            title: Text(day),
            value: _customRepeatDays.contains(day),
            onChanged: (checked) {
              setState(() {
                if (checked!) {
                  _customRepeatDays.add(day);
                } else {
                  _customRepeatDays.remove(day);
                }
                setModalState(() {});
              });
            },
          )).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Done"),
          )
        ],
      ),
    );
  }

  void _showNotificationDialog(Function setModalState) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add Notification'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            'On the day at 9 AM',
            'The day before at 9 AM',
            '2 days before at 9 AM'
          ].map((option) => RadioListTile(
            title: Text(option),
            value: option,
            groupValue: _notification,
            onChanged: (value) {
              setModalState(() => _notification = value!);
              Navigator.pop(context);
            },
          )).toList(),
        ),
      ),
    );
  }

  void _showScheduleBottomSheet(DateTime day) {
    _selectedDay = day;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 24,
            left: 16,
            right: 16,
          ),
          child: Wrap(
            children: [
              Center(
                child: Text(
                  "Create Schedule",
                  style: GoogleFonts.alegreya(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFB2204B),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ToggleButtons(
                isSelected: [
                  _scheduleType == 'Event',
                  _scheduleType == 'Task',
                  _scheduleType == 'Birthday'
                ],
                onPressed: (index) {
                  setModalState(() {
                    _scheduleType = ['Event', 'Task', 'Birthday'][index];
                  });
                },
                children: const [
                  Padding(padding: EdgeInsets.symmetric(horizontal: 12), child: Text("Event")),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 12), child: Text("Task")),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 12), child: Text("Birthday")),
                ],
              ),
              const SizedBox(height: 16),
              if (_scheduleType != 'Birthday')
                SwitchListTile(
                  title: const Text("All Day"),
                  value: _allDay,
                  onChanged: (val) => setModalState(() => _allDay = val),
                ),
              if (!_allDay && _scheduleType != 'Birthday')
                ListTile(
                  title: const Text("Select Time"),
                  subtitle: const Text("09:00 AM - 10:00 AM (example)"),
                  onTap: () {},
                ),
              if (_scheduleType != 'Birthday')
                ListTile(
                  title: Text("$_repeat"),
                  onTap: () => _showRepeatDialog(setModalState),
                ),
              ListTile(
                title: Text("$_notification"),
                onTap: () => _showNotificationDialog(setModalState),
              ),
              if (_scheduleType == 'Task')
                TextField(
                  controller: _eventDescriptionController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: "Task Description",
                    border: OutlineInputBorder(),
                  ),
                ),
              const SizedBox(height: 12),
              const Text("Default Colour"),
              Wrap(
                spacing: 8,
                children: _colors.map((color) => GestureDetector(
                  onTap: () => setModalState(() => _selectedColor = color),
                  child: CircleAvatar(
                    backgroundColor: color,
                    child: _selectedColor == color ? const Icon(Icons.check, color: Colors.white) : null,
                  ),
                )).toList(),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFB2204B)),
                    onPressed: () {
                      setState(() {
                        _events[_selectedDay!] = {
                          'type': _scheduleType,
                          'description': _eventDescriptionController.text,
                          'color': _selectedColor,
                        };
                      });
                      Navigator.pop(context);
                    },
                    child: const Text("Save"),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFF8C1C3), Color(0xFFB2204B), Color(0xFF4B0B2C)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: const Color(0xFFFDEFEF),
          elevation: 4,
          title: Text(
            'Calendar',
            style: GoogleFonts.alegreya(
              color: const Color(0xFFB2204B),
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Color(0xFFB2204B)),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildCalendar(),
                const SizedBox(height: 24),
                _buildSelectedDateInfo(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFDEFEF),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: TableCalendar(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
          _showScheduleBottomSheet(selectedDay);
        },
        calendarStyle: CalendarStyle(
          selectedDecoration: BoxDecoration(
            color: _selectedColor,
            shape: BoxShape.circle,
          ),
          todayDecoration: BoxDecoration(
            color: Colors.black.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          defaultTextStyle: const TextStyle(color: Colors.black),
          weekendTextStyle: const TextStyle(color: Colors.black54),
        ),
        headerStyle: HeaderStyle(
          titleTextStyle: const TextStyle(
            color: Color(0xFFB2204B),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          formatButtonVisible: false,
          titleCentered: true,
          leftChevronIcon: const Icon(Icons.chevron_left, color: Color(0xFFB2204B)),
          rightChevronIcon: const Icon(Icons.chevron_right, color: Color(0xFFB2204B)),
        ),
      ),
    );
  }

  Widget _buildSelectedDateInfo() {
    if (_selectedDay == null) {
      return Text(
        'Select a date to view details',
        style: GoogleFonts.alegreya(
          color: Colors.white,
          fontSize: 16,
        ),
      );
    }

    final event = _events[_selectedDay];

    if (event == null) {
      return Column(
        children: [
          const SizedBox(height: 16),
          Image.asset(
            "assets/calendar.png",
            height: 200,
          ),
          const SizedBox(height: 12),
          Text(
            "No event scheduled",
            style: GoogleFonts.alegreya(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ],
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(230),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${event['type']} on ${_selectedDay!.day}/${_selectedDay!.month}/${_selectedDay!.year}',
            style: GoogleFonts.alegreya(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFB2204B),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            event['description'] ?? '',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

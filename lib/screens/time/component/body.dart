import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newdoor/services/notification_serive.dart'; // Ensure this path is correct
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ScheduleMeetingForm extends StatefulWidget {
  final String? propertyOwnerUid; // Property owner UID received from PropertyDetailPage

  const ScheduleMeetingForm({Key? key, required this.propertyOwnerUid}) : super(key: key);

  @override
  _ScheduleMeetingFormState createState() => _ScheduleMeetingFormState();
}

class _ScheduleMeetingFormState extends State<ScheduleMeetingForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    NotificationService.initialize();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      _timeController.text = picked.format(context);
    }
  }

  Future<void> _scheduleMeeting() async {
    if (_formKey.currentState!.validate()) {
      // Prepare the meeting data
      final String date = _dateController.text;
      final String time = _timeController.text;
      final String message = _messageController.text;

      // Store meeting data in Firestore
      try {
        await FirebaseFirestore.instance.collection('meetings').add({
          'propertyOwnerUid': widget.propertyOwnerUid,
          'date': date,
          'time': time,
          'message': message,
          'createdAt': Timestamp.now(),
        });

        // Send notification to the specific user
        await FirebaseFirestore.instance.collection('notifications').add({
          'uid': widget.propertyOwnerUid, // Add the property owner's UID here
          'title': 'Scheduled Meeting',
          'body': 'Meeting scheduled on $date at $time: $message',
          'timestamp': FieldValue.serverTimestamp(),
        });

        // Show a local notification immediately
        await NotificationService.showNotification(
          'Scheduled Meeting',
          'Your meeting on $date at $time has been scheduled.',
        );

        // Clear the form
        _clearForm();
      } catch (e) {
        print('Error scheduling meeting: $e'); // Log the error
      }
    }
  }


  void _clearForm() {
    _dateController.clear();
    _timeController.clear();
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Schedule Meeting')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _dateController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Select Date',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () => _selectDate(context),
                validator: (value) => value == null || value.isEmpty ? 'Please select a date' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _timeController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Select Time',
                  suffixIcon: Icon(Icons.access_time),
                ),
                onTap: () => _selectTime(context),
                validator: (value) => value == null || value.isEmpty ? 'Please select a time' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _messageController,
                decoration: const InputDecoration(labelText: 'Enter Message'),
                validator: (value) => value == null || value.isEmpty ? 'Please enter a message' : null,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _scheduleMeeting,
                    child: const Text('Schedule'),
                  ),
                  ElevatedButton(
                    onPressed: _clearForm,
                    child: const Text('Clear'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

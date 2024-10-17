import 'package:flutter/material.dart';
import 'package:newdoor/screens/time/component/body.dart';

class TimeScreen extends StatefulWidget {
  final String propertyOwnerUid; // Add a field to receive UID

  const TimeScreen({Key? key, required this.propertyOwnerUid}) : super(key: key);

  @override
  State<TimeScreen> createState() => _TimeScreenState();
}

class _TimeScreenState extends State<TimeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScheduleMeetingForm(propertyOwnerUid: widget.propertyOwnerUid), // Pass the UID
    );
  }
}

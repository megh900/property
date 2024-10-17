import 'package:flutter/material.dart';
import 'package:newdoor/screens/contactus/component/body.dart';

class contactus extends StatefulWidget {
  const contactus({super.key});

  @override
  State<contactus> createState() => _contactusState();
}

class _contactusState extends State<contactus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ContactUsScreen(),
    );
  }
}

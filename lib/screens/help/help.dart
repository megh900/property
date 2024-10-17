import 'package:flutter/material.dart';
import 'package:newdoor/screens/help/component/body.dart';

class help extends StatefulWidget {
  const help({super.key});

  @override
  State<help> createState() => _helpState();
}

class _helpState extends State<help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HelpScreen(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:newdoor/screens/seeprofile/component/body.dart';

class seeprofile extends StatefulWidget {
  const seeprofile({super.key});

  @override
  State<seeprofile> createState() => _seeprofileState();
}

class _seeprofileState extends State<seeprofile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PropertyPlanScreen(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:newdoor/screens/noti/component/body.dart';

class noti extends StatefulWidget {
  const noti({super.key});

  @override
  State<noti> createState() => _notiState();
}

class _notiState extends State<noti> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotiScreen(),
    );
  }
}

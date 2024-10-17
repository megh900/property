import 'package:flutter/material.dart';
import 'package:newdoor/screens/buy/component/body.dart';

class buy extends StatefulWidget {
  const buy({super.key});

  @override
  State<buy> createState() => _buyState();
}

class _buyState extends State<buy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PropertyListPage(),
    );
  }
}

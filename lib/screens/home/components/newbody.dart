
import 'package:flutter/material.dart';
import 'package:newdoor/screens/home/components/header.dart';
import 'package:newdoor/screens/home/components/middle.dart';

class newbody extends StatelessWidget {
  const newbody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            header(),
            Middle(),

          ],
        ),
      ),
    );
  }
}

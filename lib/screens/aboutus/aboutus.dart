
import 'package:flutter/material.dart';
import 'package:newdoor/screens/aboutus/component/body.dart';

class about extends StatelessWidget {
  const about({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AboutUsScreen(),
        // appBar: AppBar(
        //     backgroundColor: Colors.brown.shade100,
        //     title: Text("About Us",
        //       style: TextStyle(
        //           fontWeight: FontWeight.w800,
        //           decoration: TextDecoration.underline,
        //         fontSize: 28
        //       ),
        //     )),
    );
  }
}

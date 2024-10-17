
import 'package:flutter/material.dart';
import 'package:newdoor/screens/sign_up/components/header.dart';
import 'package:newdoor/screens/sign_up/components/sign_up_form.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          AppBar(),
          LayoutHeader(),
          SizedBox(
            height: 24,
          ),
          SignUpForm()
        ],
      ),
    );
  }
}

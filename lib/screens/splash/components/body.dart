import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newdoor/constants.dart';
import 'package:newdoor/preference/pref_utils.dart';
import 'package:newdoor/routes/app_route.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {

  @override
  void initState() {

    Timer(Duration(seconds: 3), () {
      FirebaseAuth.instance
          .authStateChanges()
          .listen((User? user) {
        if (user == null) {
          if(PrefUtils.getOnBoardingStatus()){
            // navigate to signIn
            Navigator.pushReplacementNamed(context, AppRoute.signInScreen);
          }else{
            // navigate to on boarding
            // navigate to on-boarding screen after 3 seconds
            Navigator.pushReplacementNamed(context, AppRoute.onBoardingScreen);
          }
        } else {
          Navigator.pushReplacementNamed(context, AppRoute.homeScreen);
        }
      });
      // if(PrefUtils.getLoginStatus()){
      //   // navigate to home screen
      //   // navigate to home screen after 3 seconds
      //   Navigator.pushReplacementNamed(context, AppRoute.homeScreen);
      // }else{
      //   if(PrefUtils.getOnBoardingStatus()){
      //     // navigate to signIn
      //     Navigator.pushReplacementNamed(context, AppRoute.signInScreen);
      //   }else{
      //     // navigate to on boarding
      //     // navigate to on-boarding screen after 3 seconds
      //     Navigator.pushReplacementNamed(context, AppRoute.onBoardingScreen);
      //   }
      // }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              gradient: backgroundGradient
          ),
        ),
        Center(
          child: Image.asset(
            'assets/images/user.png',
            height: 240,
            width: 240,
          ),
        )
      ],
    );
  }
}

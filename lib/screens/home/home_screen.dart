
import 'package:flutter/material.dart';
import 'package:newdoor/screens/home/components/home_screen_drawer.dart';
import 'package:newdoor/screens/home/components/newbody.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: newbody(),
      drawer: HomeScreenDrawer(),
      // floatingActionButton: FloatingActionButton(onPressed: () {
      //   Navigator.pushNamed(context, AppRoute.sellformscreen);
      // },child: Icon(Icons.add)),
    );
  }
}

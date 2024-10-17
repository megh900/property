import 'package:flutter/material.dart';
import 'package:newdoor/screens/viewer/component/body.dart';

class viewer extends StatefulWidget {
  const viewer({super.key});

  @override
  State<viewer> createState() => _viewerState();
}

class _viewerState extends State<viewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProfileViewerSubscriptionScreen(),
    );
  }
}

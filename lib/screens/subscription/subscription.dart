import 'package:flutter/material.dart';
import 'package:newdoor/screens/subscription/component/body.dart';

class subscription extends StatefulWidget {
  const subscription({super.key});

  @override
  State<subscription> createState() => _subscriptionState();
}

class _subscriptionState extends State<subscription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SubscriptionScreen(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:newdoor/model/property.dart';
import 'package:newdoor/screens/detailbuy/component/body.dart'; // Assuming Body contains PropertyDetailPage

class detailBuy extends StatefulWidget {
  final Property property; // Define the property as final to avoid reassignments

  detailBuy({required this.property}); // Use required to ensure the property is passed

  @override
  State<detailBuy> createState() => _detailBuyState();
}

class _detailBuyState extends State<detailBuy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PropertyDetailPage(property: widget.property), // Access via widget
    );
  }
}

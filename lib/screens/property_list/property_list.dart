import 'dart:io';

import 'package:flutter/material.dart';
import 'package:newdoor/screens/property_list/component/body.dart';

class propertylist extends StatefulWidget {
  // const propertylist({super.key, required String propertyName, File? mainImage, required String price});

  @override
  State<propertylist> createState() => _propertylistState();
}

class _propertylistState extends State<propertylist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: PropertyListPage(),
    );
  }
}

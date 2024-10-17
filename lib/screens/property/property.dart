import 'package:flutter/material.dart';
import 'package:newdoor/model/property.dart';
import 'package:newdoor/screens/property/component/body.dart';

class propertyscreen extends StatelessWidget {


  Property? property;


  propertyscreen({this.property});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor:Colors.blue,title: Text(property == null? 'Add Property': 'Update Property'),),
      body: PropertyForm(property: property,),
    );
  }
}

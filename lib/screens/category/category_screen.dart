
import 'package:flutter/material.dart';
import 'package:newdoor/model/category.dart';
import 'package:newdoor/screens/category/component/body.dart';


class CategoryScreen extends StatelessWidget {

  Category? category;


  CategoryScreen({this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(category == null? 'Add Category': 'Update Category'),),
      body: Body(category),
    );
  }
}

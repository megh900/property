
import 'package:flutter/material.dart';
import 'package:newdoor/screens/category_list/component/body.dart';


class CategoryListScreen extends StatelessWidget {
  const CategoryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Category List'),),
      body: Body(),
    );
  }
}

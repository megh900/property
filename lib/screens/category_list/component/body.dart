import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newdoor/database/db_helper.dart';
import 'package:newdoor/model/category.dart';


import '../../../routes/app_route.dart';

class Body extends StatefulWidget {
 Category? category;
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {

  var categoryList = <Category>[];
   int? id;
  DbHelper _dbHelper = DbHelper();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getCategoryList();
  }
  // Future<void> deleteCategory(int? id, BuildContext context) async {
  //     id= await _dbHelper.delete(id!);
  //
  //   if (id != 0) {
  //     print('category updated successfully');
  //     Navigator.pop(context, id);
  //   } else {
  //     print('getting error');
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var category =
          await Navigator.pushNamed(context, AppRoute.categoryScreen);

          if (category is Category) {
            setState(() {
              categoryList.add(category);
            });
          }
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: ListView.builder(
        itemCount: categoryList.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () async {
              var category = await Navigator.pushNamed(
                  context, AppRoute.categoryScreen,
                  arguments: categoryList[index]);
              if (category is Category) {
                var index = categoryList
                    .indexWhere((element) => element.id == category.id);

                setState(() {
                  categoryList[index] = category;
                });
              }
            },
            leading: CircleAvatar(
              backgroundColor: Colors.amber.shade200,
              child: SvgPicture.file(
                File('${categoryList[index].imagePath}'),
                height: 24,
                colorFilter: ColorFilter.mode(Colors.amber, BlendMode.srcIn),
              ),
            ),
            trailing: GestureDetector(
              onTap: () async {
                // if(id!= 0) {
                //   deleteCategory(id, context);
                // }else{
                //   print("null");
                // }
                var respone = await _dbHelper.delete(id!);
                if(respone != 0){
                  print("response");
                }

              },
              child: Icon(Icons.delete),
            ),
            title: Text(categoryList[index].title!),
            subtitle: Text(categoryList[index].description!),
          );
        },
      ),
    );
  }

  Future<void> getCategoryList() async {
    var list = await _dbHelper.getCategoryList();
    setState(() {
      categoryList = list;
    });
  }
}

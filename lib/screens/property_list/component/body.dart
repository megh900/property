import 'dart:io';
import 'package:flutter/material.dart';
import 'package:newdoor/dbhelper/dbhelper2.dart';
import 'package:newdoor/firebase/firebase_service.dart';
import 'package:newdoor/model/property.dart';
import 'package:newdoor/services/auth_service.dart';
import '../../../routes/app_route.dart';

class PropertyListPage extends StatefulWidget {
  @override
  State<PropertyListPage> createState() => _PropertyListPageState();
}

class _PropertyListPageState extends State<PropertyListPage> {
  List<Property> propertyList = []; // List to hold properties
  DbHelper _dbHelper = DbHelper();
  String? currentUserUid;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getCurrentUserUid();
  }

  Future<void> getCurrentUserUid() async {
    currentUserUid = await AuthService().getCurrentUserUid();
    await getPropertyList();
  }

  Future<void> getPropertyList() async {
    if (currentUserUid != null) {
      setState(() {
        isLoading = true;
      });
      propertyList = await _dbHelper.getPropertyList(currentUserUid!);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Property List"),
        backgroundColor: Colors.blueAccent,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var property = await Navigator.pushNamed(context, AppRoute.propertyScreen);
          if (property is Property) {
            setState(() {
              propertyList.add(property);
            });
          }
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : propertyList.isEmpty
          ? Center(child: Text('No properties found', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)))
          : ListView.builder(
        itemCount: propertyList.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              onTap: () async {
                var updatedProperty = await Navigator.pushNamed(
                  context,
                  AppRoute.propertyScreen,
                  arguments: propertyList[index],
                );

                if (updatedProperty is Property) {
                  var updateResult = await _dbHelper.update(updatedProperty);
                  if (updateResult != 0) {
                    await getPropertyList();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to update property.')),
                    );
                  }
                }
              },
              leading: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.blueAccent.shade100,
                child: propertyList[index].mainImagePath != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.file(
                    File(propertyList[index].mainImagePath!),
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                )
                    : Icon(Icons.home, size: 40),
              ),
              title: Text('Name: ${propertyList[index].propertyName.toString()}'),
              subtitle: Text('Price: \$${propertyList[index].price?.toString() ?? 'N/A'}'),
              trailing: GestureDetector(
                onTap: () async {
                  bool? confirmDelete = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Delete Property'),
                        content: Text('Are you sure you want to delete this property?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                            child: Text('Delete'),
                          ),
                        ],
                      );
                    },
                  );

                  if (confirmDelete == true) {
                    var response = await _dbHelper.delete(propertyList[index].id!, currentUserUid!);
                    if (response != 0) {
                      await getPropertyList();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to delete property.')),
                      );
                    }
                  }
                },
                child: Icon(Icons.delete, color: Colors.red),
              ),
            ),
          );
        },
      ),
    );
  }
}

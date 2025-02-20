import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(bottom: 1),
      decoration: BoxDecoration(
        color: Colors.black38.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        textInputAction: TextInputAction.search,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: 'Search Product',
            prefixIcon: Icon(Icons.search),
            contentPadding: EdgeInsets.symmetric(horizontal: 20 , vertical: 12)
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class roundedbutton extends StatelessWidget {
  IconData iconData;
  VoidCallback onPressed;
  roundedbutton({required this.iconData, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 40,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40)
        ),
        padding: EdgeInsets.zero,
        color: Colors.white,
        child: Icon(iconData,color: Colors.black87),
        onPressed: onPressed,
      ),
    );
  }
}

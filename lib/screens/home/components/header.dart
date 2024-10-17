
import 'package:flutter/material.dart';
import 'package:newdoor/components/searchfeild.dart';
import 'package:newdoor/screens/buttons/roundedbutton.dart';
import 'package:newdoor/screens/noti/noti.dart';

class header extends StatelessWidget {
  const header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
         children: [
           roundedbutton(iconData:Icons.menu , onPressed:
           () {
                 Scaffold.of(context).openDrawer();
           },),
           SizedBox(width: 10,),
           const Expanded(
             child: Center(
               child: Text(
                 "NewDoor",
                 style: TextStyle(
                   fontSize: 32, // Elegant size
                   fontWeight: FontWeight.normal, // Normal weight for classic look
                   fontStyle: FontStyle.normal, // Not italic
                   color: Colors.black, // Main color
                   letterSpacing: 1.5, // Slight spacing for readability
                   // decoration: TextDecoration.underline, // Underline for emphasis
                   decorationColor: Colors.black54, // Slightly lighter black underline
                   decorationThickness: 1.5, // Thickness for distinction
                   decorationStyle: TextDecorationStyle.solid, // Solid underline
                   shadows: [
                     Shadow(
                       offset: Offset(2, 2), // Offset for depth
                       blurRadius: 5.0, // Smooth shadow
                       color: Colors.black26, // Medium black shade for shadow
                     ),
                     Shadow(
                       offset: Offset(4, 4), // Extra depth
                       blurRadius: 8.0,
                       color: Colors.black12, // Lighter black for secondary shadow
                     ),
                   ],
                 ),
                 textAlign: TextAlign.center, // Centered in widget
               ),
             ),
           ),

           SizedBox(width: 10,),
           roundedbutton(
             iconData:Icons.notifications ,
             onPressed: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context) => noti(),));
             },
           )
         ],
    );
  }
}

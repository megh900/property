import 'package:flutter/material.dart';
import 'package:newdoor/routes/app_route.dart';
import 'package:newdoor/screens/home/components/screen/Bunglow.dart';
import 'package:newdoor/screens/home/components/screen/B2.dart';
import 'package:newdoor/screens/home/components/screen/B3.dart';
import 'package:newdoor/screens/home/components/screen/F1.dart';
import 'package:newdoor/screens/home/components/screen/F2.dart';
import 'package:newdoor/screens/home/components/screen/F3.dart';
import 'package:newdoor/screens/home/components/screen/L1.dart';
import 'package:newdoor/screens/home/components/screen/L2.dart';
import 'package:newdoor/screens/home/components/screen/L3.dart';
import 'package:newdoor/screens/home/components/screen/O1.dart';
import 'package:newdoor/screens/home/components/screen/O2.dart';
import 'package:newdoor/screens/home/components/screen/O3.dart';
import 'package:newdoor/screens/home/components/screen/S1.dart';
import 'package:newdoor/screens/home/components/screen/S2.dart';
import 'package:newdoor/screens/home/components/screen/S3.dart';

class Middle extends StatefulWidget {
  const Middle({super.key});

  @override
  State<Middle> createState() => _MiddleState();
}

class _MiddleState extends State<Middle> {
  final List<String> propertyNames = [
    "Bunglow",
    "Flat",
    "Shop",
    "Land",
    "Office",
    "Bunglow",
    "Flat",
    "Shop",
    "Land",
    "Office",
    "Bunglow",
    "Flat",
    "Shop",
    "Land",
    "Office",
  ];

  // Method to build the custom buttons
  Widget _buildCustomButton(String text, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.blue,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  // Method to build the action buttons
  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            shadowColor: Colors.black54,
            elevation: 5,
          ),
          onPressed: () {
            Navigator.pushNamed(context, AppRoute.buyScreen);
          },
          child: const Text("BUY / RENT"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.greenAccent,
            shadowColor: Colors.black54,
            elevation: 5,
          ),
          onPressed: () {
            Navigator.pushNamed(context, AppRoute.propertydetailsScreen);
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Text("SELL"),
          ),
        ),
      ],
    );
  }

  // Method to build the title for each section
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(
          wordSpacing: 2,
          letterSpacing: 2,
          decoration: TextDecoration.underline,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // Method to build a horizontal scroll view of properties
  Widget _buildPropertyScrollView({required List<Map<String, dynamic>> images}) {
    return Container(
      height: 240, // Set a fixed height for the horizontal scroll area
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: InkWell(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => images[index]['screen'])),
              child: Container(
                width: 160, // Set a fixed width for each property card
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        images[index]['image'],
                        height: 140,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      propertyNames[index], // Use the name from the list
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blue.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              _buildActionButtons(),
              _buildSectionTitle("Upcoming Property"),
              _buildPropertyScrollView(
                images: [
                  {'image': 'assets/images/B1.jpeg', 'screen': Bunglow()},
                  {'image': 'assets/images/F1.jpeg', 'screen': F1()},
                  {'image': 'assets/images/S1.jpeg', 'screen': S1()},
                  {'image': 'assets/images/L1.jpeg', 'screen': L1()},
                  {'image': 'assets/images/O1.jpeg', 'screen': O1()},
                ],
              ),
              _buildSectionTitle("Latest Property"),
              _buildPropertyScrollView(
                images: [
                  {'image': 'assets/images/B2.jpeg', 'screen': B2()},
                  {'image': 'assets/images/F2.jpeg', 'screen': F2()},
                  {'image': 'assets/images/S2.jpeg', 'screen': S2()},
                  {'image': 'assets/images/L2.jpeg', 'screen': L2()},
                  {'image': 'assets/images/O2.jpeg', 'screen': O2()},
                ],
              ),
              _buildSectionTitle("Special Offer"),
              _buildPropertyScrollView(
                images: [
                  {'image': 'assets/images/B3.jpeg', 'screen': B3()},
                  {'image': 'assets/images/F3.jpeg', 'screen': F3()},
                  {'image': 'assets/images/S3.jpeg', 'screen': S3()},
                  {'image': 'assets/images/L3.jpeg', 'screen': L3()},
                  {'image': 'assets/images/O3.jpeg', 'screen': O3()},
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

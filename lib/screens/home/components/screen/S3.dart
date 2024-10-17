import 'package:flutter/material.dart';

class S3 extends StatefulWidget {
  const S3({super.key});

  @override
  State<S3> createState() => _S3State();
}

class _S3State extends State<S3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shop"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/images/S3.jpeg',
                  width: MediaQuery.of(context).size.width, // Make the image full width
                  height: 200,
                  fit: BoxFit.cover, // Ensures the image covers the available space
                ),
              ),
              const SizedBox(height: 15),
              _buildInfoCard("Property Owner:", "Amit"),
              _buildInfoCard("Owner Contact No.:", "9963256547"),
              _buildInfoCard("Owner Email:", "amit1@gmail.com"),
              _buildInfoCard("Property Price:", "35,00,000 INR", price: true),
              _buildInfoCard("Property Area:", "1800 sqft", area: true),
              _buildInfoCard("Property Location:", "Vadodara, Gujarat"),
              const SizedBox(height: 20),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, {bool price = false, bool area = false}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                color: price ? Colors.green : (area ? Colors.blue : Colors.black),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

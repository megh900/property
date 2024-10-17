import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to NewDoor!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Our Mission',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'At NewDoor, we aim to revolutionize the way people buy, sell, and rent properties. Our mission is to provide a seamless and efficient platform that connects buyers and sellers, ensuring a smooth real estate experience for everyone involved.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Our Values',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '1. **Integrity**: We believe in maintaining transparency and honesty in all our dealings.\n'
                    '2. **Innovation**: We continuously strive to improve and innovate our services to meet the evolving needs of our users.\n'
                    '3. **Customer Focus**: Our customers are at the heart of everything we do. We listen to their feedback and strive to exceed their expectations.\n'
                    '4. **Community**: We aim to build a community of trust and support among our users, fostering relationships that go beyond transactions.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Join Us',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'We invite you to join us on this exciting journey as we open new doors for property buyers and sellers. Together, we can create a brighter future in real estate.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

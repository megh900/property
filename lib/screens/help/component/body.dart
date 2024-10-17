import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help & Support'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Welcome to NewDoor Help Center!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Frequently Asked Questions (FAQs)',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Divider(),
            _buildFAQItem(
              question: '1. How do I create an account?',
              answer:
              'To create an account, click on the "Sign Up" button on the home screen and fill in your details.',
            ),
            _buildFAQItem(
              question: '2. How can I reset my password?',
              answer:
              'If you forget your password, click on the "Forgot Password?" link on the sign-in page and follow the instructions.',
            ),
            _buildFAQItem(
              question: '3. How do I search for properties?',
              answer:
              'Use the search bar at the top of the property list page to type in the name or location of the property you are looking for.',
            ),
            _buildFAQItem(
              question: '4. How can I filter property listings?',
              answer:
              'Tap on the filter icon in the app bar to set your criteria like price, type, and more.',
            ),
            _buildFAQItem(
              question: '5. How can I add a property?',
              answer:
              'To add a property, go to the "Add Property" screen from the main menu, fill out the required details including name, type, price, and upload images, then click "Submit".',
            ),
            _buildFAQItem(
              question: '6. What should I do if I encounter an error?',
              answer:
              'If you experience any issues, please contact our support team via the "Contact Us" section.',
            ),
            SizedBox(height: 20),
            Text(
              'Contact Us',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'For further assistance, please email us at support@newdoor.com',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQItem({required String question, required String answer}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ExpansionTile(
        title: Text(
          question,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(answer),
          ),
        ],
      ),
    );
  }
}

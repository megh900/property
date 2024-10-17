import 'package:flutter/material.dart';

class PropertyPlanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plan Your Property'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Interested in Selling or Renting Your Property?',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'If you want to attract interested buyers or renters for your property, the first step is to create a plan. Here are some tips to get started:',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              _buildTipCard(
                title: '1. Market Research',
                description: 'Understand your target market and what potential buyers or renters are looking for.',
              ),
              _buildTipCard(
                title: '2. Set a Competitive Price',
                description: 'Evaluate the pricing of similar properties in your area to set a competitive price.',
              ),
              _buildTipCard(
                title: '3. Enhance Property Appeal',
                description: 'Consider minor renovations or staging to make your property more appealing.',
              ),
              _buildTipCard(
                title: '4. Choose the Right Platforms',
                description: 'List your property on popular real estate platforms to reach a wider audience.',
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigate to another screen or perform an action
                },
                child: Text('Get Started'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTipCard({required String title, required String description}) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

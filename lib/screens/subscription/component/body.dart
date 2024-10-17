import 'package:flutter/material.dart';

class SubscriptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subscription Plans'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Choose a Subscription Plan',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              _buildSubscriptionPlan(
                title: 'Basic Plan',
                price: '\$9.99/month',
                features: ['Access to basic features', 'Email support', 'Community access'],
                onSelect: () {
                  // Add logic to handle subscription
                  _subscribe(context, 'Basic Plan');
                },
              ),
              SizedBox(height: 20),
              _buildSubscriptionPlan(
                title: 'Standard Plan',
                price: '\$19.99/month',
                features: ['Access to all features', 'Priority email support', 'Community access'],
                onSelect: () {
                  // Add logic to handle subscription
                  _subscribe(context, 'Standard Plan');
                },
              ),
              SizedBox(height: 20),
              _buildSubscriptionPlan(
                title: 'Premium Plan',
                price: '\$29.99/month',
                features: ['Access to all features', '24/7 support', 'Community access', 'Exclusive content'],
                onSelect: () {
                  // Add logic to handle subscription
                  _subscribe(context, 'Premium Plan');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubscriptionPlan({
    required String title,
    required String price,
    required List<String> features,
    required VoidCallback onSelect,
  }) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              price,
              style: TextStyle(fontSize: 18, color: Colors.green),
            ),
            SizedBox(height: 10),
            Text(
              'Features:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ...features.map((feature) => Text('- $feature')).toList(),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: onSelect,
              child: Text('Subscribe'),
            ),
          ],
        ),
      ),
    );
  }

  void _subscribe(BuildContext context, String plan) {
    // Implement subscription logic here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Subscribed to $plan!')),
    );
  }
}

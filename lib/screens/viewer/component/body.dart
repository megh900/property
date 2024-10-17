import 'package:flutter/material.dart';

class ProfileViewerSubscriptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Viewers'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'See Who Viewed Your Profile!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'To view the list of users who have viewed your profile, please subscribe to our premium plan.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            _buildPlanDetailCard(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the subscription plan page or process
              },
              child: Text('Subscribe Now'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanDetailCard() {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Premium Plan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '• View profile visitors\n'
                  '• Exclusive features and insights\n'
                  '• Cancel anytime',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

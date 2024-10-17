import 'package:flutter/material.dart';

class ContactUsScreen extends StatefulWidget {
  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  String _feedbackMessage = '';

  void _submitForm() {
    if (_nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _messageController.text.isNotEmpty) {
      setState(() {
        _feedbackMessage = 'Your complaint has been filed successfully!';
      });
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    } else {
      setState(() {
        _feedbackMessage = 'Please fill in all fields!';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'We\'d love to hear from you!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'For any inquiries, suggestions, or feedback, please reach out to us using the following methods:',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              _buildContactMethod(
                title: 'Email',
                content: 'support@newdoor.com',
              ),
              _buildContactMethod(
                title: 'Phone',
                content: '+1 (234) 567-8901',
              ),
              _buildContactMethod(
                title: 'Address',
                content: '123 NewDoor Street, Suite 100\nCity, State, Zip',
              ),
              SizedBox(height: 20),
              Text(
                'You can also fill out the form below:',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              _buildContactForm(),
              SizedBox(height: 20),
              if (_feedbackMessage.isNotEmpty)
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.all(8),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Text(
                      _feedbackMessage,
                      style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactMethod({required String title, required String content}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(height: 4),
          Text(content, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildContactForm() {
    return Column(
      children: [
        TextField(
          controller: _nameController,
          decoration: InputDecoration(
            labelText: 'Your Name',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            labelText: 'Your Email',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: _messageController,
          decoration: InputDecoration(
            labelText: 'Message',
            border: OutlineInputBorder(),
          ),
          maxLines: 5,
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: _submitForm,
          child: Text('Send Message'),
        ),
      ],
    );
  }
}

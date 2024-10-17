import 'dart:io';
import 'package:flutter/material.dart';
import 'package:newdoor/model/property.dart';
import 'package:newdoor/routes/app_route.dart';

import 'package:newdoor/screens/time/component/body.dart'; // Import the ScheduleMeetingForm

class PropertyDetailPage extends StatefulWidget {
  final Property property;

  const PropertyDetailPage({Key? key, required this.property}) : super(key: key);

  @override
  State<PropertyDetailPage> createState() => _PropertyDetailPageState();
}

class _PropertyDetailPageState extends State<PropertyDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          widget.property.propertyName ?? 'Property Details',
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 28,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildImage(widget.property.mainImagePath ?? ''),
            const SizedBox(height: 16),
            ..._buildPropertyDetails(),
            const SizedBox(height: 24),
            _buildMultipleImages(widget.property.multipleImagesPaths ?? []),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Pass the UID to the ScheduleMeetingForm
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScheduleMeetingForm(propertyOwnerUid: widget.property.uid),
                  ),
                );
              },
              child: const Text('Schedule Meeting'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 20),
                textStyle: const TextStyle(fontSize: 18),
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(String imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: imagePath.isEmpty
          ? Container(
        height: 300,
        width: double.infinity,
        color: Colors.grey[300],
        child: const Icon(Icons.image, size: 100, color: Colors.grey),
      )
          : (Uri.tryParse(imagePath)?.isAbsolute ?? false)
          ? Image.network(
        imagePath,
        fit: BoxFit.cover,
        height: 300,
        width: double.infinity,
        errorBuilder: (context, error, stackTrace) => _placeholderImage(),
      )
          : Image.file(
        File(imagePath),
        fit: BoxFit.cover,
        height: 300,
        width: double.infinity,
        errorBuilder: (context, error, stackTrace) => _placeholderImage(),
      ),
    );
  }

  Widget _placeholderImage() {
    return Container(
      height: 300,
      width: double.infinity,
      color: Colors.grey[300],
      child: const Icon(Icons.broken_image, size: 100, color: Colors.grey),
    );
  }

  List<Widget> _buildPropertyDetails() {
    final property = widget.property;

    return [
      const Text(
        'Owner Details',
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24, decoration: TextDecoration.underline),
      ),
      _buildDetailRow('Owner', property.ownerName),
      _buildDetailRow('Email', property.ownerEmail),
      _buildDetailRow('Contact', property.ownerContact),
      _buildDetailRow('User Type', property.usertype),
      const Text(
        'Property Details',
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24, decoration: TextDecoration.underline),
      ),
      _buildDetailRow('Type', property.propertyType),
      _buildDetailRow('For', property.rentOrSell),
      _buildDetailRow('Description', property.description),
      _buildDetailRow('Price', '${property.price?.toStringAsFixed(2)} INR', color: Colors.green),
      _buildDetailRow('Area', '${property.area} sq ft'),
      _buildDetailRow('Furnished', property.furnished == true ? 'Yes' : 'No'),
      _buildDetailRow('Bedrooms', '${property.bedrooms}'),
      _buildDetailRow('Bathrooms', '${property.bathrooms}'),
      const Text(
        'Property Location',
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24, decoration: TextDecoration.underline),
      ),
      _buildDetailRow('Address', property.propertyAddress),
      _buildDetailRow('Pincode', property.pinCode),
      _buildDetailRow('City', property.city),
      _buildDetailRow('State', property.state),
      _buildDetailRow('Date', DateTime.fromMillisecondsSinceEpoch(property.date ?? 0).toString()),
      _buildDetailRow('UID', property.uid),
    ];
  }

  Widget _buildDetailRow(String title, String? value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title: ',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value ?? 'N/A',
              style: TextStyle(fontSize: 18, color: color ?? Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMultipleImages(List<String> images) {
    if (images.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Additional Images:',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            itemBuilder: (context, index) {
              final imagePath = images[index];
              return Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    File(imagePath),
                    height: 250,
                    width: 250,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => _placeholderImage(),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

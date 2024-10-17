import 'package:flutter/material.dart';
import 'package:newdoor/screens/filter/component/body.dart'; // Adjust this import if necessary

class Filter extends StatefulWidget {
  const Filter({Key? key}) : super(key: key);

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  List<String> selectedTypes = []; // Initialize selected types
  int? selectedBedrooms; // Store selected bedrooms
  int? selectedBathrooms; // Store selected bathrooms
  String? selectedRentOrSell; // Store selected rent or sell option
  String? selectedUsertype; // Store selected user type
  String? selectedAreaRange; // Store selected area range as String
  String? selectedPriceRange; // Store selected price range as String

  // Function to handle filter application
  void onApplyFilters(
      List<String> types,
      int? bedrooms,
      int? bathrooms,
      String? rentOrSell,
      String? usertype,
      String? areaRange,
      String? priceRange, // Keep as String for UI display
      ) {
    double? areaValue;
    double? priceValue;

    // Parse areaRange to double for filtering logic
    if (areaRange != null) {
      List<String> parts = areaRange.split(' to ');
      if (parts.length == 2) {
        areaValue = double.tryParse(parts[1]); // Use upper limit for filtering
      } else if (parts[0] == 'More than 1000') {
        areaValue = 1000; // Assuming this means "more than 1000"
      } else {
        areaValue = double.tryParse(parts[0]); // If only one value is selected
      }
    }

    // Parse priceRange to double for filtering logic
    if (priceRange != null) {
      List<String> priceParts = priceRange.split(' to ');
      if (priceParts.length == 2) {
        priceValue = double.tryParse(priceParts[1]); // Use upper limit for filtering
      } else if (priceParts[0] == 'More than 100000') {
        priceValue = 100000; // Assuming this means "more than 100000"
      } else {
        priceValue = double.tryParse(priceParts[0]); // If only one value is selected
      }
    }

    // Update state with selected filters
    setState(() {
      selectedTypes = types; // Update selected types
      selectedBedrooms = bedrooms; // Update selected bedrooms
      selectedBathrooms = bathrooms; // Update selected bathrooms
      selectedRentOrSell = rentOrSell; // Update rent or sell option
      selectedUsertype = usertype; // Update user type
      selectedAreaRange = areaRange; // Store as String for UI
      selectedPriceRange = priceRange; // Store as String for UI
    });

    // Optionally, you can call a function to refresh the property list based on applied filters
    // For example: refreshPropertyList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
      ),
      body: FilterScreen(
        selectedTypes: selectedTypes, // Pass the selected types to the filter screen
        selectedBedrooms: selectedBedrooms, // Pass the selected bedrooms to the filter screen
        selectedBathrooms: selectedBathrooms, // Pass the selected bathrooms to the filter screen
        selectedRentOrSell: selectedRentOrSell, // Pass the selected rent or sell option
        selectedUsertype: selectedUsertype, // Pass the selected user type
        selectedArea: selectedAreaRange, // Pass the selected area range
        selectedPrice: selectedPriceRange, // Pass the selected price range
        onApplyFilters: onApplyFilters, // Pass the apply filters function
      ),
    );
  }
}

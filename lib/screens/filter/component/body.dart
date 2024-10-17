import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  final List<String> selectedTypes;
  final int? selectedBedrooms;
  final int? selectedBathrooms;
  final String? selectedRentOrSell;
  final String? selectedUsertype;
  final String? selectedArea;
  final String? selectedPrice;// Keeping as String for UI
  final Function(List<String>, int?, int?, String?, String?, String? , String?) onApplyFilters;

  const FilterScreen({
    Key? key,
    required this.selectedTypes,
    required this.selectedBedrooms,
    required this.selectedBathrooms,
    required this.selectedRentOrSell,
    required this.selectedUsertype,
    required this.selectedArea,
    required this.selectedPrice,// Keeping as String for UI
    required this.onApplyFilters,
  }) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  late List<String> _selectedTypes;
  int? _selectedBedrooms;
  int? _selectedBathrooms;
  String? _selectedRentOrSell;
  String? _selectedUsertype;
  String? _selectedAreaRange;
  String? _selectedPriceRange;// Store the selected area range

  @override
  void initState() {
    super.initState();
    _selectedTypes = List.from(widget.selectedTypes);
    _selectedBedrooms = widget.selectedBedrooms;
    _selectedBathrooms = widget.selectedBathrooms;
    _selectedRentOrSell = widget.selectedRentOrSell;
    _selectedUsertype = widget.selectedUsertype;
    _selectedAreaRange = widget.selectedArea;
    _selectedPriceRange = widget.selectedPrice;// Initialize selected area range
  }

  void _clearFilters() {
    setState(() {
      _selectedTypes.clear();
      _selectedBedrooms = null;
      _selectedBathrooms = null;
      _selectedRentOrSell = null;
      _selectedUsertype = null;
      _selectedAreaRange = null;
      _selectedPriceRange = null;// Reset area range
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPropertyTypeCard(),
              _buildBedroomsAndBathroomsCard(),
              _buildRentOrSellAndUserTypeCard(),
              _buildAreaFilterCard(),

              _buildPriceFilterCard(),
              _buildApplyFiltersButton(),
              const SizedBox(height: 10),
              _buildClearFiltersButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPropertyTypeCard() {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Select Property Type:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ..._buildPropertyTypeCheckboxes(),
          ],
        ),
      ),
    );
  }

  Widget _buildBedroomsAndBathroomsCard() {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildDropdownColumn<int?>(
              title: 'Select Bedrooms:',
              value: _selectedBedrooms,
              items: [1, 2, 3, 4, 5],
              onChanged: (value) => setState(() => _selectedBedrooms = value),
            ),
            const SizedBox(width: 20),
            _buildDropdownColumn<int?>(
              title: 'Select Bathrooms:',
              value: _selectedBathrooms,
              items: [1, 2, 3, 4, 5],
              onChanged: (value) => setState(() => _selectedBathrooms = value),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRentOrSellAndUserTypeCard() {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildDropdownColumn<String>(
              title: 'Select Rent or Sell:',
              value: _selectedRentOrSell,
              items: ['Rent', 'Sell'],
              onChanged: (value) => setState(() => _selectedRentOrSell = value),
            ),
            const SizedBox(width: 20),
            _buildDropdownColumn<String>(
              title: 'Select Owner or Broker:',
              value: _selectedUsertype,
              items: ['owner', 'broker'], // Capitalized for consistency
              onChanged: (value) => setState(() => _selectedUsertype = value),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAreaFilterCard() {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Select Area Range:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              hint: const Text('Select Area Range', style: TextStyle(color: Colors.grey)),
              value: _selectedAreaRange,
              items: [
                '0 to 100',
                '100 to 200',
                '200 to 500',
                '500 to 1000',
                'More than 1000'
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedAreaRange = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildPriceFilterCard() {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Select Price Range:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              hint: const Text('Select Price Range', style: TextStyle(color: Colors.grey)),
              value: _selectedPriceRange,
              items: [
                '0 to 100000',
                '100000 to 200000',
                '200000 to 500000',
                '500000 to 1000000',
                'More than 1000000'
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedPriceRange = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildApplyFiltersButton() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Keep the area range as String when calling onApplyFilters
          widget.onApplyFilters(
            _selectedTypes,
            _selectedBedrooms,
            _selectedBathrooms,
            _selectedRentOrSell,
            _selectedUsertype,
            _selectedAreaRange,
            _selectedPriceRange// Pass the area range as String
          );
          Navigator.pop(context); // Close the filter screen
        },
        child: const Text('Apply Filters'),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 20),
          textStyle: const TextStyle(fontSize: 18),
          backgroundColor: Colors.blueAccent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  Widget _buildClearFiltersButton() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _clearFilters, // Call clear filters method
        child: const Text('Clear Filters'),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 20),
          textStyle: const TextStyle(fontSize: 18),
          backgroundColor: Colors.redAccent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  List<Widget> _buildPropertyTypeCheckboxes() {
    final propertyTypes = ['Apartment', 'House', 'Land', 'Commercial'];

    return propertyTypes.map((type) {
      return CheckboxListTile(
        title: Text(type),
        value: _selectedTypes.contains(type),
        onChanged: (bool? selected) {
          setState(() {
            if (selected == true) {
              _selectedTypes.add(type);
            } else {
              _selectedTypes.remove(type);
            }
          });
        },
      );
    }).toList();
  }

  Widget _buildDropdownColumn<T>({
    required String title,
    required T? value,
    required List<T> items,
    required ValueChanged<T?> onChanged,
  }) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          DropdownButton<T?>(
            hint: const Text('Select Option', style: TextStyle(color: Colors.grey)),
            value: value,
            items: items.map((T item) {
              return DropdownMenuItem<T?>(
                value: item,
                child: Text(item.toString()),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:newdoor/dbhelper/dbhelper2.dart';
import 'package:newdoor/model/property.dart';
import 'package:newdoor/routes/app_route.dart';
import 'package:newdoor/screens/filter/component/body.dart';

class PropertyListPage extends StatefulWidget {
  @override
  _PropertyListPageState createState() => _PropertyListPageState();
}

class _PropertyListPageState extends State<PropertyListPage> {
  late Future<List<Property>> _propertiesFuture;
  final DbHelper dbHelper = DbHelper();

  List<String> _selectedTypes = [];
  int? _selectedBedrooms;
  int? _selectedBathrooms;
  String? _selectedRentOrSell;
  String? _selectedUserType;
  String? _selectedAreaRange;
  String? _selectedPriceRange;

  List<Property> _allProperties = [];
  List<Property> _filteredProperties = [];
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    _fetchProperties();
  }

  void _fetchProperties() async {
    final properties = await dbHelper.getAllProperties();
    setState(() {
      _allProperties = properties;
      _filteredProperties = _applyFilters(properties);
    });
  }

  List<Property> _applyFilters(List<Property> properties) {
    List<Property> filtered = properties.where((property) {
      bool matchesType = _selectedTypes.isEmpty || _selectedTypes.contains(property.propertyType);
      bool matchesBedrooms = _selectedBedrooms == null || property.bedrooms == _selectedBedrooms;
      bool matchesBathrooms = _selectedBathrooms == null || property.bathrooms == _selectedBathrooms;
      bool matchesRentOrSell = _selectedRentOrSell == null || property.rentOrSell == _selectedRentOrSell;
      bool matchesUserType = _selectedUserType == null || property.usertype == _selectedUserType;
      bool matchesArea = _matchesArea(property.area);
      bool matchesPrice = _matchesPrice(property.price);
      bool matchesSearch = _searchQuery.isEmpty ||
          (property.propertyName?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false) ||
          (property.city?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false);

      return matchesType &&
          matchesBedrooms &&
          matchesBathrooms &&
          matchesRentOrSell &&
          matchesUserType &&
          matchesArea &&
          matchesPrice &&
          matchesSearch;
    }).toList();

    return filtered;
  }

  bool _matchesArea(double? area) {
    if (_selectedAreaRange == null) return true;
    List<String> rangeParts = _selectedAreaRange!.split(' to ');

    if (rangeParts.length == 2) {
      double lowerBound = double.parse(rangeParts[0]);
      double upperBound = double.parse(rangeParts[1]);
      return (area != null && area >= lowerBound && area <= upperBound);
    } else if (_selectedAreaRange!.startsWith('More than')) {
      double lowerBound = double.parse(_selectedAreaRange!.split(' ')[2]);
      return (area != null && area > lowerBound);
    } else {
      return false;
    }
  }
  bool _matchesPrice(double? price) {
    if (_selectedPriceRange == null) return true;
    List<String> rangeParts = _selectedPriceRange!.split(' to ');

    if (rangeParts.length == 2) {
      double lowerBound = double.parse(rangeParts[0]);
      double upperBound = double.parse(rangeParts[1]);
      return (price != null && price >= lowerBound && price <= upperBound);
    } else if (_selectedPriceRange!.startsWith('More than')) {
      double lowerBound = double.parse(_selectedPriceRange!.split(' ')[2]);
      return (price != null && price > lowerBound);
    } else {
      return false;
    }
  }

  void _filterProperties(String query) {
    setState(() {
      _searchQuery = query;
      _filteredProperties = _applyFilters(_allProperties);
    });
  }

  Future<void> _openFilterScreen() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FilterScreen(
          selectedTypes: _selectedTypes,
          selectedBedrooms: _selectedBedrooms,
          selectedBathrooms: _selectedBathrooms,
          selectedRentOrSell: _selectedRentOrSell,
          selectedUsertype: _selectedUserType,
          selectedArea: _selectedAreaRange,
          selectedPrice: _selectedPriceRange,
          onApplyFilters: (types, bedrooms, bathrooms, rentOrSell, userType, area, price) {
            setState(() {
              _selectedTypes = types;
              _selectedBedrooms = bedrooms;
              _selectedBathrooms = bathrooms;
              _selectedRentOrSell = rentOrSell;
              _selectedUserType = userType;
              _selectedAreaRange = area;
              _selectedPriceRange = price;

              _filteredProperties = _applyFilters(_allProperties);
            });
          },
        ),
      ),
    );
    _fetchProperties();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Properties'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list_alt),
            onPressed: _openFilterScreen,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchField(),
          Expanded(
            child: _filteredProperties.isEmpty
                ? const Center(child: Text('No properties found.'))
                : ListView.builder(
              itemCount: _filteredProperties.length,
              itemBuilder: (context, index) {
                final property = _filteredProperties[index];
                return _buildPropertyCard(property);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: _filterProperties,
        decoration: InputDecoration(
          hintText: 'Search by name or location',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }

  Widget _buildPropertyCard(Property property) {
    return Card(
      margin: const EdgeInsets.all(8),
      elevation: 4,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            AppRoute.detailbuyScreen,
            arguments: property,
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(property.mainImagePath ?? ''),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    property.propertyName ?? 'Unknown Property',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'City: ${property.city ?? 'Unknown City'}',
                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Price: ${property.price?.toStringAsFixed(2) ?? 'N/A'} INR',
                    style: const TextStyle(fontSize: 16, color: Colors.green),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(String imagePath) {
    if (imagePath.isEmpty) {
      return Container(
        height: 200,
        width: double.infinity,
        color: Colors.grey[300],
        child: const Icon(Icons.image, size: 100, color: Colors.grey),
      );
    }

    return Image.file(
      File(imagePath),
      fit: BoxFit.cover,
      height: 200,
      width: double.infinity,
      errorBuilder: (context, error, stackTrace) {
        return _buildImagePlaceholder();
      },
    );
  }

  Widget _buildImagePlaceholder() {
    return Container(
      height: 200,
      width: double.infinity,
      color: Colors.grey[300],
      child: const Icon(Icons.broken_image, size: 100, color: Colors.grey),
    );
  }
}

import 'package:newdoor/model/property.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  // Database name and version
  static final String _dbName = 'property.db';
  static final int _dbVersion = 5; // Incremented version due to UID change

  // Table name and column names
  static final String _tableProperty = 'property'; // Ensure this matches your table name
  static final String _id = 'id';
  static final String _propertyName = 'property_name';
  static final String _ownerName = 'owner_name';
  static final String _propertyAddress = 'property_address';
  static final String _city = 'city';
  static final String _state = 'state';
  static final String _description = 'description';
  static final String _propertyAddressLink = 'property_address_link'; // Corrected to match the column name
  static final String _price = 'price';
  static final String _ownerContact = 'owner_contact';
  static final String _ownerEmail = 'owner_email';
  static final String _pinCode = 'pin_code';
  static final String _area = 'area';
  static final String _bedrooms = 'bedrooms';
  static final String _bathrooms = 'bathrooms';
  static final String _propertyType = 'property_type';
  static final String _furnished = 'furnished';
  static final String _rentOrSell = 'rent_or_sell';
  static final String _userType = 'user_type'; // Changed to user_type for consistency
  static final String _mainImage = 'main_image_path';
  static final String _multipleImages = 'multiple_images_paths';
  static final String _date = 'date';
  static final String _uid = 'uid'; // Added UID

  static Database? _database;
  static final DbHelper _instance = DbHelper._internal();

  factory DbHelper() {
    return _instance;
  }

  DbHelper._internal();

  Future<Database?> getDatabase() async {
    if (_database == null) {
      _database = await createDatabase();
    }
    return _database;
  }

  Future<Database> createDatabase() async {
    var path = join(await getDatabasesPath(), _dbName);
    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: (db, version) {
        return db.execute('CREATE TABLE $_tableProperty('
            '$_id INTEGER PRIMARY KEY AUTOINCREMENT, '
            '$_propertyName TEXT, '
            '$_ownerName TEXT, '
            '$_propertyAddress TEXT, '
            '$_city TEXT, '
            '$_state TEXT, '
            '$_description TEXT, '
            '$_propertyAddressLink TEXT, ' // Use correct column name
            '$_price REAL, '
            '$_ownerContact TEXT, '
            '$_ownerEmail TEXT, '
            '$_pinCode TEXT, '
            '$_area REAL, '
            '$_bedrooms INTEGER, '
            '$_bathrooms INTEGER, '
            '$_propertyType TEXT, '
            '$_furnished INTEGER, '
            '$_rentOrSell TEXT, '
            '$_mainImage TEXT, '
            '$_multipleImages TEXT, '
            '$_date INTEGER, '
            '$_uid TEXT, '  // User ID
            '$_userType TEXT)'); // Correct column name for user type
      },
      onUpgrade: onUpgrade,
    );
  }

  Future<void> onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 4) {
      await db.execute('ALTER TABLE $_tableProperty ADD COLUMN $_userType TEXT');
    }
    if (oldVersion < 5) {
      await db.execute('ALTER TABLE $_tableProperty ADD COLUMN $_propertyAddressLink TEXT');
    }
  }

  // Insert a new property
  Future<int?> insert(Property property) async {
    final db = await getDatabase();
    return await db?.insert(_tableProperty, property.toMap());
  }

  // Fetch properties for the logged-in user
  Future<List<Property>> getPropertyList(String uid) async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db!.query(
      _tableProperty,
      where: '$_uid = ?',
      whereArgs: [uid], // Fetch only properties belonging to the current user
    );

    // Convert List<Map<String, dynamic>> to List<Property
    return List<Property>.generate(maps.length, (i) {
      return Property.fromMap(maps[i]);
    });
  }

  // Update a property
  Future<int> update(Property property) async {
    final db = await getDatabase();

    if (db == null) {
      print("Database connection failed.");
      return -1;
    }

    // Log the property being updated
    print("Updating Property: ID: ${property.id}, UID: ${property.uid}");

    // Ensure the property exists by using both id and uid for the WHERE clause
    int result = await db.update(
      _tableProperty,
      property.toMap(),
      where: '$_id = ? AND $_uid = ?',
      whereArgs: [property.id, property.uid],
    );

    if (result == 0) {
      print("No rows updated. Check if ID: ${property.id} and UID: ${property.uid} exist.");
      return -1; // No rows were updated
    }

    print("Property updated successfully. Rows affected: $result");
    return result;
  }

  // Delete a property
  Future<int> delete(int id, String uid) async {
    final db = await getDatabase();

    // Delete the specified property
    int deleteResult = await db!.delete(
      _tableProperty,
      where: '$_id = ? AND $_uid = ?', // Ensure user can only delete their own property
      whereArgs: [id, uid],
    );

    // Check if deletion was successful
    if (deleteResult > 0) {
      print("Property deleted successfully: ID: $id");
      // Optionally reorder IDs of remaining properties
      await db.rawUpdate('UPDATE $_tableProperty SET $_id = $_id - 1 WHERE $_id > ?', [id]);
    } else {
      print("Failed to delete property: ID: $id");
    }
    return deleteResult;
  }

  // Fetch all properties (regardless of UID)
  Future<List<Property>> getAllProperties() async {
    final db = await getDatabase();

    if (db == null) {
      print("Database connection failed.");
      return [];
    }

    // Query the database to get a List<Map<String, dynamic>>
    final List<Map<String, dynamic>> maps = await db.query(_tableProperty);

    // Convert the List<Map<String, dynamic>> to List<Property>
    return List<Property>.generate(maps.length, (i) => Property.fromMap(maps[i]));
  }
  Future<List<Property>> getFilteredProperties(
      List<String> selectedTypes,
      int? bedrooms,
      int? bathrooms,
      String? rentOrSell,
      String? usertype,
      double? area,
      double? price// Keep as double?
      ) async {
    // Fetch all properties first (assuming you have a method for this)
    List<Property> allProperties = await getAllProperties();
    List<Property> filteredProperties = [];

    for (var property in allProperties) {
      // Check if the property matches the selected types
      bool matchesType = selectedTypes.isEmpty || selectedTypes.contains(property.propertyType);

      // Check if the property matches the selected number of bedrooms
      bool matchesBedrooms = bedrooms == null || property.bedrooms == bedrooms;

      // Check if the property matches the selected number of bathrooms
      bool matchesBathrooms = bathrooms == null || property.bathrooms == bathrooms;

      // Check if the property matches the rent or sell option
      bool matchesRentOrSell = rentOrSell == null || property.rentOrSell == rentOrSell;

      // Check if the property matches the user type
      bool matchesUserType = usertype == null || property.usertype == usertype;

      // Check if the property matches the area range
      bool matchesArea = area == null || (property.area != null && property.area! <= area);
      bool matchesPrice = price == null || (property.price != null && property.price! <= price);
      // If property matches all criteria, add it to the filtered list
      if (matchesType && matchesBedrooms && matchesBathrooms && matchesRentOrSell && matchesUserType && matchesArea && matchesPrice) {
        filteredProperties.add(property);
      }
    }

    return filteredProperties; // Return the filtered properties
  }

  Future<List<Property>> searchProperties(String query) async {
    final db = await getDatabase();

    // Perform a search in the propertyName and city fields
    final List<Map<String, dynamic>> results = await db!.query(
      'properties',
      where: 'propertyName LIKE ? OR city LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
    );

    // Convert the list of maps to a list of Property objects
    return results.map((map) => Property.fromMap(map)).toList();
  }



}

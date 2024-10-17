class Property {
  int? id;
  String? propertyName;
  String? ownerName;
  String? propertyAddress;
  String? city;
  String? state;
  String? description;
  String? propertyaddresslink;
  double? price;
  String? ownerContact;
  String? ownerEmail;
  String? pinCode;
  double? area;
  int? bedrooms;
  int? bathrooms;
  String? propertyType;
  bool? furnished;  // Nullable bool
  String? rentOrSell;
  String? usertype;// "Rent" or "Sell"
  String? mainImagePath;
  List<String>? multipleImagesPaths;  // Multiple image paths as a list of strings
  int? date;  // Timestamp for date
  String? uid;  // Added UID field

  Property({
    this.id,
    this.propertyName,
    this.ownerName,
    this.propertyAddress,
    this.city,
    this.state,
    this.description,
    this.propertyaddresslink,
    this.price,
    this.ownerContact,
    this.ownerEmail,
    this.pinCode,
    this.area,
    this.bedrooms,
    this.bathrooms,
    this.propertyType,
    this.furnished,
    this.rentOrSell,
    this.usertype,
    this.mainImagePath,
    this.multipleImagesPaths,
    this.date,
    this.uid,  // Initialize UID
  });

  // Convert to Map (for database insertion)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'property_name': propertyName,
      'owner_name': ownerName,
      'property_address': propertyAddress,
      'city': city,
      'state': state,
      'description': description,
      'property_address_link': propertyaddresslink,
      'price': price,
      'owner_contact': ownerContact,
      'owner_email': ownerEmail,
      'pin_code': pinCode,
      'area': area,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'property_type': propertyType,
      'furnished': (furnished ?? false) ? 1 : 0,  // Default to false if null
      'rent_or_sell': rentOrSell,
      'user_type': usertype,
      'main_image_path': mainImagePath,
      'multiple_images_paths': multipleImagesPaths?.join(','),  // Convert List to comma-separated String
      'date': date,
      'uid': uid,  // Add UID to map
    };
  }

  // Convert from Map (to convert database result into an object)
  static Property fromMap(Map<String, dynamic> map) {
    return Property(
      id: map['id'] as int,
      propertyName: map['property_name'],
      ownerName: map['owner_name'],
      propertyAddress: map['property_address'],
      city: map['city'],
      state: map['state'],
      description: map['description'],
      propertyaddresslink: map['property_address_link'],
      price: map['price'],
      ownerContact: map['owner_contact'],
      ownerEmail: map['owner_email'],
      pinCode: map['pin_code'],
      area: map['area'],
      bedrooms: map['bedrooms'],
      bathrooms: map['bathrooms'],
      propertyType: map['property_type'],
      furnished: map['furnished'] == 1,  // Convert from int to bool
      rentOrSell: map['rent_or_sell'],
      usertype: map['user_type'],
      mainImagePath: map['main_image_path'],
      multipleImagesPaths: map['multiple_images_paths']?.split(','),  // Convert comma-separated String back to List
      date: map['date'],
      uid: map['uid'],  // Retrieve UID from the map
    );
  }
}

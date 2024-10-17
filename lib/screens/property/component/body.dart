import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:newdoor/model/property.dart';

import '../../../dbhelper/dbhelper2.dart';



class PropertyForm extends StatefulWidget {
  final Property? property; // Optional: Pass the property to edit

  PropertyForm({this.property});

  @override
  _PropertyFormState createState() => _PropertyFormState(property);
}




class _PropertyFormState extends State<PropertyForm> {
  final _formKey = GlobalKey<FormState>();

  Property? property;

  _PropertyFormState(this.property);  // Controllers for text input
  final propertyNameController = TextEditingController();
  final ownerNameController = TextEditingController();
  final propertyAddressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final descriptionController = TextEditingController();
  final propertyaddrresslinkcontroller = TextEditingController();
  final priceController = TextEditingController();
  final ownerContactController = TextEditingController();
  final ownerEmailController = TextEditingController();
  final ownerAddressController = TextEditingController();
  final pinCodeController = TextEditingController();
  final areaController = TextEditingController();
  final bedroomsController = TextEditingController();
  final bathroomsController = TextEditingController();
  String currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';

  @override
  void initState() {
    if(property != null){
      propertyNameController.text = property!.propertyName!;
      ownerNameController.text = property!.ownerName!;
      propertyAddressController.text = property!.propertyAddress!;
      cityController.text = property!.city!;
      stateController.text = property!.state!;
      descriptionController.text = property!.description!;
      propertyaddrresslinkcontroller.text = property!.propertyaddresslink!;
      priceController.text = property!.price?.toString() ?? '';
      ownerEmailController.text = property!.ownerEmail!;
      ownerContactController.text = property!.ownerContact!;
      pinCodeController.text = property!.pinCode!;
      areaController.text = property!.area?.toString()??'';
      bedroomsController.text = property!.bedrooms?.toString() ?? '';
      bathroomsController.text = property!.bathrooms?.toString() ?? '';
      isFurnished = property!.furnished ?? false;
      selectedPropertyType = property!.propertyType;
      selectedRentOrSell = property!.rentOrSell;
      selectedusertype = property!.usertype;
      mainImage = File(property!.mainImagePath!);
      multipleImages = property!.multipleImagesPaths!
          .map((imagePath) => File(imagePath))
          .toList();
    }
    super.initState();

    // Load existing property data if available
    if (widget.property != null) {
      // Load the data into the controllers
      propertyNameController.text = widget.property!.propertyName!;
      // ... (load other fields)

      // Check if the current user can edit this property
      if (widget.property!.uid != currentUserId) {
        // Show an error message and navigate back
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('You cannot edit this property.')),
        );
        Navigator.pop(context); // Close the form
      }
    }
  }

  DbHelper dbHelper = DbHelper();
  // Dropdown value for property type
  String? selectedPropertyType;
  List<String> propertyTypes = ['Apartment', 'House', 'Commercial', 'Land'];

  // Variables for image picker
  File? mainImage;
  List<File> multipleImages = [];

  bool isFurnished = false;
  String? selectedRentOrSell;
  List<String> rentOrSellOptions = ['Rent', 'Sell'];
  String? selectedusertype;
  List<String> usertype = ['owner', 'broker'];

  // Pick main image
  Future<void> pickMainImage() async {

    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        mainImage = File(pickedFile.path);
      });
    }
  }

  Future<void> addProperty(Property property, BuildContext context) async {
    int? id = await dbHelper.insert(property);

    if (id != -1) {
      print('category added successfully');
      property.id = id;
      Navigator.pop(context,property);
    } else {
      print('getting error');
    }
  }
  Future<void> updateProperty(Property property, BuildContext context) async {
    int? id = await dbHelper.update(property);

    if (id != -1) {
      print('category update successfully');
      property.id = id;
      Navigator.pop(context,property);
    } else {
      print('getting error');
    }
  }

  // Pick multiple images
  Future<void> pickMultipleImages() async {
    final pickedFiles = await ImagePicker().pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        multipleImages = pickedFiles.map((e) => File(e.path)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text("Owner Details",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 24,decoration: TextDecoration.underline,),),
            ),
              buildownername(),
              SizedBox(
                height: 15,
              ),
              buildownercontactnumber(),
              SizedBox(
                height: 15,
              ),
              buildowneremail(),
              SizedBox(
                height: 15,
              ),
              buildusertype(),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text("Property Details",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 24,decoration: TextDecoration.underline,),),
              ),
              buildpropertyname(),
              SizedBox(
                height: 15,
              ),
              buildpropertytype(),
              SizedBox(
                height: 15,
              ),
              builddescreption(),
              SizedBox(
                height: 15,
              ),
              buildprice(),
              SizedBox(height: 15),
              buildarea(),
              SizedBox(
                height: 15,
              ),
              buildrentorsell(),
              SizedBox(
                height: 15,
              ),
              buildbathroom(),

              SizedBox(
                height: 15,
              ),
              buildbedroom(),
              SizedBox(
                height: 15,
              ),


              buildfurnished(),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text("Property Images",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 24,decoration: TextDecoration.underline,),),
              ),
              Text('Property Main Image'),
              SizedBox(height: 10),
              // Inside the build method, in the mainImage section
              buildmainimage(),

              SizedBox(height: 20),
              Text('Property Multiple Images'),
              SizedBox(height: 10),
              // Inside the build method, for the multipleImages section
              buildmultipleimage(),

              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text("Property Location",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 24,decoration: TextDecoration.underline,),),
              ),


              buildpropertyaddress(),
              SizedBox(
                height: 15,
              ),
              buildpropertyaddresslink(),
              SizedBox(
                height: 15,
              ),
              buildpincond(),
              SizedBox(height: 15),
              buildcity(),
              SizedBox(
                height: 15,
              ),
             buildstate(),
              SizedBox(
                height: 15,
              ),

              buildAddpropertyButtonWidget(context)

            ],
          ),
        ),
      ),
    );
  }

  buildpincond() {
    return TextFormField(
      controller: pinCodeController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Pin Code',
        errorStyle: TextStyle(color: Colors.redAccent),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter pin code';
        }
        return null;
      },
    );
  }

  buildowneremail() {
    return TextFormField(
      controller: ownerEmailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(labelText: 'Owner Email'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter email';
        }
        return null;
      },
    );
  }

  buildownercontactnumber() {
    return TextFormField(
      controller: ownerContactController,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(labelText: 'Owner Contact Number'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter contact number';
        }
        return null;
      },
    );
  }

  buildmultipleimage() {
    return multipleImages.isNotEmpty
        ? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: multipleImages.map((file) {
            return Stack(
              children: [
                Image.file(
                  file,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    icon: Icon(Icons.cancel, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        multipleImages.remove(file); // Remove the image on cancel
                      });
                    },
                  ),
                ),
              ],
            );
          }).toList(),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: pickMultipleImages, // Option to add more images
          child: Text('Add More Images'),
        ),
      ],
    )
        : ElevatedButton(
      onPressed: pickMultipleImages,
      child: Text('Pick Multiple Images'),
    );
  }

  buildmainimage() {
    return mainImage != null
        ? Column(
      children: [
        Image.file(
          mainImage!,
          height: 200,
          width: 200,
          fit: BoxFit.cover,  // Ensures the image fits nicely
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: pickMainImage, // Option to change the image
          child: Text('Change Main Image'),
        ),
      ],
    )
        : ElevatedButton(
      onPressed: pickMainImage,
      child: Text('Pick Main Image'),
    );
  }

  builddescreption() {
    return TextFormField(
      controller: descriptionController,
      decoration: InputDecoration(labelText: 'Property Description'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter property description';
        }
        return null;
      },
    );
  }

  buildprice() {
    return TextFormField(
      controller: priceController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Price'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter price';
        }
        return null;
      },
    );
  }

  buildstate() {
    return  TextFormField(
      controller: stateController,
      decoration: InputDecoration(labelText: 'State'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter state';
        }
        return null;
      },
    );
  }

  buildcity() {
    return TextFormField(
      controller: cityController,
      decoration: InputDecoration(labelText: 'City'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter city';
        }
        return null;
      },
    );
  }

  buildpropertyaddress() {
    return TextFormField(
      controller: propertyAddressController,
      decoration: InputDecoration(labelText: 'Property Address'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter property address';
        }
        return null;
      },
    );
  }

  buildownername() {
    return TextFormField(
      controller: ownerNameController,
      decoration: InputDecoration(labelText: 'Owner Name'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter owner name';
        }
        return null;
      },
    );
  }

  buildpropertytype() {
    return DropdownButtonFormField<String>(
      value: selectedPropertyType,
      hint: Text('Select Property Type'),
      items: propertyTypes.map((type) {
        return DropdownMenuItem<String>(
          value: type,
          child: Text(type),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedPropertyType = value;
        });
      },
      validator: (value) {
        if (value == null) {
          return 'Please select a property type';
        }
        return null;
      },
    );
  }

  buildpropertyname() {
    return  TextFormField(
      controller: propertyNameController,
      decoration: InputDecoration(labelText: 'Property Name'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter property name';
        }
        return null;
      },
    );
  }

  buildarea() {
    return TextFormField(
      controller: areaController,
      decoration: InputDecoration(labelText: 'Area (sq ft/m)'),
      keyboardType: TextInputType.number,
      validator: (value) => value!.isEmpty ? 'Please enter the property area' : null,
    );
  }

  buildfurnished() {
    return Row(
      children: [
        Checkbox(
          value: isFurnished,
          onChanged: (bool? value) {
            setState(() {
              isFurnished = value ?? false;  // Update the boolean value
            });
          },
        ),
        Text('Furnished'),
      ],
    );
  }

  buildbathroom() {
    return TextFormField(
      controller: bathroomsController,
      decoration: InputDecoration(labelText: 'Bathrooms'),
      keyboardType: TextInputType.number,
      validator: (value) => value!.isEmpty ? 'Please enter number of bathrooms' : null,
    );
  }

  buildbedroom() {
    return TextFormField(
      controller: bedroomsController,
      decoration: InputDecoration(labelText: 'Bedrooms'),
      keyboardType: TextInputType.number,
      validator: (value) => value!.isEmpty ? 'Please enter number of bedrooms' : null,
    );
  }

  buildrentorsell() {
    return DropdownButton<String>(
      value: selectedRentOrSell,
      hint: Text('Select Rent or Sell'),
      onChanged: (String? newValue) {
        setState(() {
          selectedRentOrSell = newValue;
        });
      },
      items: rentOrSellOptions.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  buildAddpropertyButtonWidget(BuildContext context) {
    return MaterialButton(
      color: Colors.green,
      minWidth: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
      ),
      onPressed: () {
        // Gather input from text controllers and other inputs
        String propertyName = propertyNameController.text.trim();
        String ownerName = ownerNameController.text.trim();
        String propertyAddress = propertyAddressController.text.trim();
        String city = cityController.text.trim();
        String state = stateController.text.trim();
        String description = descriptionController.text.trim();
        String propertyaddresslink = propertyaddrresslinkcontroller.text.trim();
        double? price = double.tryParse(priceController.text.trim());
        String ownerContact = ownerContactController.text.trim();
        String ownerEmail = ownerEmailController.text.trim();
        String pinCode = pinCodeController.text.trim();
        double? area = double.tryParse(areaController.text.trim());
        int? bedrooms = int.tryParse(bedroomsController.text.trim());
        int? bathrooms = int.tryParse(bathroomsController.text.trim());
        int? date = DateTime.now().millisecondsSinceEpoch;  // Set the current timestamp
        String? propertyType = selectedPropertyType;  // Get the selected dropdown value
        String mainImagePath = mainImage?.path ?? '';
        List<String> imagePaths = multipleImages.map((image) => image?.path ?? '').toList();// Get image file path
        // Fetch the logged-in user's ID
        String currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';

        // Ensure a value is selected before submitting
        if (propertyType == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please select a property type')),
          );
          return;
        }
        String? rentOrSell = selectedRentOrSell;
        // Get the selected dropdown value
        String? usertype = selectedusertype;
        if (widget.property != null && widget.property!.uid != currentUserId) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('You cannot edit this property.')),
          );
          return;
        }
        // Ensure a value is selected before submitting
        if (rentOrSell == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please select Rent or Sell')),
          );
          return;
        }
        if (usertype == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please select Owner or Broker')),
          );
          return;
        }
        if (multipleImages.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please select at least one image.')),
          );
          return;
        }
        if (mainImage == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please select a main image.')),
          );
          return;
        }
        if (propertyAddress == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please enter a property address')),
          );
          return;
        }
        if (propertyaddresslink == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please enter a property address link')),
          );
          return;
        }
        if (ownerEmail == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please enter a email')),
          );
          return;
        }
        if (ownerContact == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please enter a contact number')),
          );
          return;
        }
        if (ownerName == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please enter a property owner name')),
          );
          return;
        }
        if (propertyName == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please enter a property name')),
          );
          return;
        }
        if (city == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please enter a city name')),
          );
          return;
        }
        if (state == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please enter a state name')),
          );
          return;
        }
        if (bedrooms == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please select number of bedroom')),
          );
          return;
        }
        if (bathrooms == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please select number of bathroom')),
          );
          return;
        }
        if (area == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please enter a area')),
          );
          return;
        }
        if (price == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please enter a price')),
          );
          return;
        }
        if (description == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please enter a property description')),
          );
          return;
        }
        if (pinCode == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please enter a pincode')),
          );
          return;
        }
        if(property != null){
          Property pro = Property(
            id:property!.id ,
            propertyName: propertyName,
            ownerName: ownerName,
            propertyAddress: propertyAddress,
            city: city,
            state: state,
            description: description,
            multipleImagesPaths: imagePaths,
            mainImagePath: mainImagePath,
            propertyaddresslink: propertyaddresslink,
            price: price,
            ownerContact: ownerContact,
            ownerEmail: ownerEmail,
            pinCode: pinCode,
            area: area,
            bedrooms: bedrooms,
            bathrooms: bathrooms,
            propertyType: propertyType,
            furnished: isFurnished,
            rentOrSell: rentOrSell,
            usertype: usertype,
            date: property!.date,
            uid: currentUserId, // Associate with the current user
          );
          updateProperty(pro, context);
        }else{
          Property property = Property(
            propertyName: propertyName,
            ownerName: ownerName,
            propertyAddress: propertyAddress,
            city: city,
            state: state,
            multipleImagesPaths: imagePaths,
            description: description,
            propertyaddresslink: propertyaddresslink,
            price: price,
            ownerContact: ownerContact,
            ownerEmail: ownerEmail,
            pinCode: pinCode,
            mainImagePath: mainImagePath,
            area: area,
            bedrooms: bedrooms,
            bathrooms: bathrooms,
            propertyType: propertyType,
            furnished: isFurnished,
            rentOrSell: rentOrSell,
            usertype: usertype,
            date: date,
            uid: currentUserId, // Associate with the current user
          );
          addProperty(property, context);
        }

      },
      child: Text(
        property == null? 'Add Property':'Update Property',
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
      ),
    );
  }

  buildusertype() {
    return DropdownButton<String>(
      value: selectedusertype,
      hint: Text('Select owner or broker'),
      onChanged: (String? newValue) {
        setState(() {
          selectedusertype = newValue;
        });
      },
      items: usertype.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  buildpropertyaddresslink() {
    return TextFormField(
      controller: propertyaddrresslinkcontroller,
      decoration: InputDecoration(labelText: 'Property Address Link'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter Property Address Link';
        }
        return null;
      },
    );
  }
}



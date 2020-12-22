import 'dart:io';
import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:minorityreport/Models/ratingModel.dart';
import 'package:minorityreport/Utils/Consts.dart';
import 'package:minorityreport/data_for_log_register/database.dart';

class DetailEntry extends StatefulWidget {
  @override
  _DetailEntryState createState() => _DetailEntryState();
}

class _DetailEntryState extends State<DetailEntry> {
  String _uploadedFileURL;
  double avgRate;
  TextEditingController _nameC = new TextEditingController();
  TextEditingController _categoryC = new TextEditingController();
  TextEditingController _addressLine1C = new TextEditingController();
  TextEditingController _addressLine2C = new TextEditingController();
  TextEditingController _cityC = new TextEditingController();
  TextEditingController _stateC = new TextEditingController();
  TextEditingController _countryC = new TextEditingController();
  TextEditingController _zipC = new TextEditingController();
  TextEditingController _phoneC = new TextEditingController();
  TextEditingController _emailC = new TextEditingController();
  TextEditingController _websiteC = new TextEditingController();
  TextEditingController _sDiscriptionC = new TextEditingController();
  TextEditingController _dDiscriptionC = new TextEditingController();
  double _rating = 0;
  bool _validate = false,
      _validatest = false,
      _validateC = false,
      _validateZ = false,
      _validateP = false,
      _validatedDis = false,
      _validatesD = false,
      _validateEm = false;
  DatabaseService _service = new DatabaseService();
  Future getImage() async {
    File file;
    try {
      FilePickerResult result = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: ['jpg']);

      if (result != null) {
        file = File(result.files.single.path);
      }
      _uploadImageToFirebase(file);
      setState(() {});
    } catch (e) {
      AlertDialog(
        title: Text("Please Select Image"),
      );
    }
  }

  Future<void> _uploadImageToFirebase(File image) async {
    try {
      // Make random image name.
      int randomNumber = Random().nextInt(100000);
      String imageLocation = 'images/image${randomNumber}.jpg';

      // Upload image to firebase.
      final StorageReference storageReference =
          FirebaseStorage().ref().child(imageLocation);
      final StorageUploadTask uploadTask = storageReference.putFile(image);
      await uploadTask.onComplete;
      _addPathToDatabase(imageLocation);
    } catch (e) {
      print(e.message);
    }
  }

  Future<void> _addPathToDatabase(String text) async {
    try {
      // Get image URL from firebase
      final ref = FirebaseStorage().ref().child(text);
      _uploadedFileURL = await ref.getDownloadURL();

      // Add location and url to database
      // await FirebaseFirestore.instance
      //     .collection('Bussiness List')
      //     .doc(u_id)
      //     .set({'url': _uploadedFileURL, 'location': text});
    } catch (e) {
      print(e.message);
    }
  }

  RatingModel _ratingModel = new RatingModel();
  DatabaseService _databaseService = new DatabaseService();
  clearAllTxt() {
    _nameC.clear();
    _categoryC.clear();
    _addressLine1C.clear();
    _addressLine2C.clear();
    _cityC.clear();
    _stateC.clear();
    _countryC.clear();
    _zipC.clear();
    _phoneC.clear();
    _emailC.clear();
    _websiteC.clear();
    _sDiscriptionC.clear();
    _dDiscriptionC.clear();
  }

  getAllData() async {
    String result;

    setState(() {
      _cityC.text.isEmpty ? _validate = true : _validate = false;
      _stateC.text.isEmpty ? _validatest = true : _validatest = false;
      _countryC.text.isEmpty ? _validateC = true : _validate = false;
      _zipC.text.isEmpty ? _validateZ = true : _validate = false;
      _phoneC.text.isEmpty ? _validateP = true : _validate = false;
      _dDiscriptionC.text.isEmpty ? _validatedDis = true : _validate = false;
      _sDiscriptionC.text.isEmpty ? _validatesD = true : _validate = false;
      _emailC.text.isEmpty ? _validateEm = true : _validate = false;
      // _categoryC.text.isEmpty ? _validateca = true : _validate = false;
    });
    if (!_validate &&
        !_validatest &&
        !_validateC &&
        !_validateZ &&
        !_validateP &&
        !_validatedDis &&
        !_validatesD &&
        !_validateEm) {
      try {
        _ratingModel = RatingModel(
            bussinessName: _nameC.text,
            bCategory: _selectedLocation,
            address: [_addressLine1C.text, _addressLine2C.text],
            city: _cityC.text,
            state: _stateC.text,
            country: _countryC.text,
            zip: _zipC.text,
            phone: _phoneC.text,
            email: _emailC.text,
            website: _websiteC.text,
            shortDisc: _sDiscriptionC.text,
            detailDescription: _dDiscriptionC.text,
            photoUrl: _uploadedFileURL,
            ratingBar: _rating);

        result = await _databaseService.createBussinessList(_ratingModel);
      } catch (e) {
        print(e.toString());
      }
    }
    if (result == "success") {
      clearAllTxt();
      await showMyDialog(context, "Success", "Data is saved successfully");
      Navigator.pushReplacementNamed(context, '/list');
    } else {
      //  clearAllTxt();
      await showMyDialog(context, "Alert", "Data not Saved . please try again");
    }
  }

////////////////////////////////
  List<String> locations = [
    'bar',
    'banks',
    'car',
    'FoodTrucks',
    'car',
    'Hotels',
    'Hospital',
    'Public_Transportations',
    'Resturant'
  ];
  String _selectedLocation = 'bar';
/////////////////////////////////////////////
  @override
  void dispose() {
    _nameC.dispose();
    _categoryC.dispose();
    _addressLine1C.dispose();
    _addressLine2C.dispose();
    _cityC.dispose();
    _stateC.dispose();
    _countryC.dispose();
    _zipC.dispose();
    _phoneC.dispose();
    _emailC.dispose();
    _websiteC.dispose();
    _sDiscriptionC.dispose();
    _dDiscriptionC.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Center(
                    child: Text(
                      'Details of Bussiness',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _nameC,
                    decoration: new InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: MyColors.PrimaryColor, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: MyColors.PrimaryColor, width: 1.0),
                        ),
                        labelText: 'Business Name',
                        hintText: 'Write name of bussiness',
                        hintStyle: TextStyle(fontSize: 12)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<String>(
                      value: _selectedLocation,
                      isExpanded: true,
                      items: locations.map((String val) {
                        return new DropdownMenuItem<String>(
                          value: val,
                          child: new Text(val),
                        );
                      }).toList(),
                      hint: Text("Please choose a Category of your Business"),
                      onChanged: (newVal) {
                        print(newVal);
                        //   _selectedLocation = newVal;
                        setState(() {
                          _selectedLocation = newVal;
                        });
                      }),
                ),
                Text(
                  'Adddress',
                  style: TextStyle(fontSize: 12),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _addressLine1C,
                    decoration: new InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: MyColors.PrimaryColor, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: MyColors.PrimaryColor, width: 1.0),
                      ),
                      labelText: 'Line 1',
                      hintText: 'Address line 1',
                      hintStyle: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _addressLine2C,
                    decoration: new InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: MyColors.PrimaryColor, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: MyColors.PrimaryColor, width: 1.0),
                      ),
                      labelText: 'Line 2 ',
                      hintText: 'Adress line 2',
                      hintStyle: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _cityC,
                    decoration: new InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: MyColors.PrimaryColor, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: MyColors.PrimaryColor, width: 1.0),
                      ),
                      errorText: _validate ? 'Value Can\'t Be Empty' : null,
                      labelText: 'City ',
                      hintText: 'Buffalo',
                      hintStyle: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _stateC,
                    decoration: new InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: MyColors.PrimaryColor, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: MyColors.PrimaryColor, width: 1.0),
                      ),
                      labelText: 'State ',
                      hintText: 'NY',
                      errorText: _validatest ? 'Value Can\'t Be Empty' : null,
                      hintStyle: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _countryC,
                    decoration: new InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: MyColors.PrimaryColor, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: MyColors.PrimaryColor, width: 1.0),
                      ),
                      labelText: 'Country ',
                      hintText: 'USA',
                      errorText: _validateC ? 'Value Can\'t Be Empty' : null,
                      hintStyle: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _zipC,
                    decoration: new InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: MyColors.PrimaryColor, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: MyColors.PrimaryColor, width: 1.0),
                      ),
                      labelText: 'Zip/Pin code',
                      hintText: ' 91234',
                      errorText: _validateZ ? 'Value Can\'t Be Empty' : null,
                      hintStyle: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _phoneC,
                    decoration: new InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: MyColors.PrimaryColor, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: MyColors.PrimaryColor, width: 1.0),
                      ),
                      labelText: 'Phone ',
                      hintText: '+1543453',
                      errorText: _validateP ? 'Value Can\'t Be Empty' : null,
                      hintStyle: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _emailC,
                    decoration: new InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: MyColors.PrimaryColor, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: MyColors.PrimaryColor, width: 1.0),
                      ),
                      labelText: 'Email ',
                      hintText: 'examle@hotmail.com',
                      hintStyle: TextStyle(fontSize: 12),
                      errorText: _validateEm ? 'Value Can\'t Be Empty' : null,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _websiteC,
                    decoration: new InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: MyColors.PrimaryColor, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: MyColors.PrimaryColor, width: 1.0),
                      ),
                      labelText: 'Website ',
                      hintText: 'www.goole.com',
                      hintStyle: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _sDiscriptionC,
                    maxLines: 4,
                    decoration: new InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: MyColors.PrimaryColor, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: MyColors.PrimaryColor, width: 1.0),
                      ),
                      labelText: 'Short Description ',
                      errorText: _validatesD ? 'Value Can\'t Be Empty' : null,
                      hintText: '..',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _dDiscriptionC,
                    keyboardType: TextInputType.multiline,
                    maxLines: 7,
                    decoration: new InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: MyColors.PrimaryColor, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: MyColors.PrimaryColor, width: 1.0),
                      ),
                      labelText: 'Detailed Description ',
                      hintText: '..',
                      errorText: _validatedDis ? 'Value Can\'t Be Empty' : null,
                    ),
                  ),
                ),
                RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    _rating = rating;

                    print(rating);
                  },
                ),
                Center(
                  child: Column(
                    children: <Widget>[
                      RaisedButton(
                        child: Icon(Icons.add_a_photo),
                        onPressed: () async {
                          await getImage();
                        },
                        color: Colors.cyan,
                      ),
                      Text('Uploaded Image'),
                      _uploadedFileURL != null
                          ? Image.network(
                              _uploadedFileURL,
                              height: 150,
                            )
                          : Container(),
                      RaisedButton(
                        child: Text("Submit"),
                        onPressed: () {
                          getAllData();
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )
          // bottomNavigationBar: MyButtons.footer(context),
          ),
    );
  }
}

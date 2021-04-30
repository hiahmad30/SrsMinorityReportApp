import 'dart:io';
import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:minorityreport/Models/ratingModel.dart';
import 'package:minorityreport/Pages/ListPage.dart';
import 'package:minorityreport/Utils/Consts.dart';
import 'package:minorityreport/ViewModel/loadinWidget.dart';
import 'package:minorityreport/controller/dbController.dart';

class DetailEntry extends StatefulWidget {
  final categoryEntry;

  const DetailEntry({Key key, this.categoryEntry}) : super(key: key);
  @override
  _DetailEntryState createState() => _DetailEntryState();
}

class _DetailEntryState extends State<DetailEntry> {
  String _uploadedFileURL;
  double avgRate;
  TextEditingController _nameC = new TextEditingController();
  TextEditingController _categoryC = new TextEditingController();
  TextEditingController _addressLine1C = new TextEditingController();
  // TextEditingController _addressLine2C = new TextEditingController();
  TextEditingController _cityC = new TextEditingController();
  TextEditingController _stateC = new TextEditingController();
  TextEditingController _countryC = new TextEditingController();
  TextEditingController _zipC = new TextEditingController();
  TextEditingController _phoneC = new TextEditingController();
  TextEditingController _emailC = new TextEditingController();
  TextEditingController _websiteC = new TextEditingController();
  TextEditingController _sDiscriptionC = new TextEditingController();
  TextEditingController _dDiscriptionC = new TextEditingController();
  int _radiogropValue = 1;
  double _rating = 0;
  bool _validate = false,
      _validateAdd = false,
      _validateName = false,
      _validatest = false,
      _validateC = false,
      _validateZ = false,
      _validateP = false,
      _validatedDis = false,
      _validateEm = false;

  File pic;
  Future getImage() async {
    File _file;
    try {
      FilePickerResult result = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: ['jpg']);

      if (result != null) {
        _file = File(result.files.single.path);
        pic = _file;
        if (mounted) setState(() {});
      }
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
      String imageLocation = 'images/image$randomNumber.jpg';

      // Upload image to firebase.
      final Reference storageReference =
          FirebaseStorage.instance.ref().child(imageLocation);
      final UploadTask uploadTask = storageReference.putFile(image);
      await uploadTask.whenComplete(() async {
        await _addPathToDatabase(imageLocation);
      });
    } catch (e) {
      print(e.message);
    }
  }

  Future<void> _addPathToDatabase(String text) async {
    try {
      // Get image URL from firebase
      final ref = FirebaseStorage.instance.ref().child(text);
      _uploadedFileURL = await ref.getDownloadURL();
      if (!mounted) return;
      setState(() {});
    } catch (e) {
      print(e.message);
    }
  }

  void deletPic() {
    pic = null;
    if (mounted) setState(() {});
  }

  RatingModel _ratingModel = new RatingModel();
  DatabaseController _databaseService = new DatabaseController();
  clearAllTxt() {
    _nameC.clear();
    _categoryC.clear();
    _addressLine1C.clear();
    //  _addressLine2C.clear();
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

  Future getAllData() async {
    bool result;
    Get.dialog(LoadingWidget());
    setState(() {
      _nameC.text.isEmpty ? _validateName = true : _validateName = false;
      _addressLine1C.text.isEmpty ? _validateAdd = true : _validateAdd = false;
      _cityC.text.isEmpty ? _validate = true : _validate = false;
      _stateC.text.isEmpty ? _validatest = true : _validatest = false;
      _countryC.text.isEmpty ? _validateC = true : _validateC = false;
      _zipC.text.isEmpty ? _validateZ = true : _validateZ = false;
      //  _phoneC.text.isEmpty ? _validateP = true : _validate = false;
      //   _dDiscriptionC.text.isEmpty ? _validatedDis = true : _validate = false;
      //   _emailC.text.isEmpty ? _validateEm = true : _validate = false;
      // _categoryC.text.isEmpty ? _validateca = true : _validate = false;
    });
    if (!_validateName && !_validatest && !_validateC
        // !_validateZ &&
        // !_validateP &&
        //  !_validatedDis &&
        //   !_validatesD //&&
        //  !_validateEm
        ) {
      await _uploadImageToFirebase(pic);
      try {
        _ratingModel = RatingModel(
            bussinessName: _nameC.text,
            bCategory: _selectedLocation,
            address: _addressLine1C.text,
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
            blackExperience: _radiogropValue,
            ratingBar: _rating);

        result = await _databaseService.createBussinessList(_ratingModel);
      } catch (e) {
        print(e.toString());
      }
    }
    if (result == true) {
      clearAllTxt();
      Get.back();
      await showMyDialog(context, "Success", "Data is saved successfully");
      Get.back();
    } else {
      //  clearAllTxt();
      Get.snackbar(
          "Error", "Data not Saved .Fill required fields ands try again");
    }
  }

////////////////////////////////
  List<String> locations = [
    'Airlines',
    'Bars',
    'Banks',
    'Car Rentals',
    'Clothing Store',
    'Emergency Services',
    'Food Trucks',
    'Hotels',
    'Hospital',
    'Medical Facilities',
    'New and used car lots',
    'Police',
    'Public Transportations',
    'Restaurants',
  ];
  String _selectedLocation = 'Airlines';
/////////////////////////////////////////////
  @override
  void initState() {
    _selectedLocation =
        widget.categoryEntry == '' ? 'Airlines' : widget.categoryEntry;

    super.initState();
  }

  @override
  void dispose() {
    _nameC.dispose();
    _categoryC.dispose();
    _addressLine1C.dispose();
    //  _addressLine2C.dispose();
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
                      'Detail of Business',
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
                      hintText: 'Write name of business',
                      hintStyle: TextStyle(fontSize: 12),
                      errorText: _validateName ? 'Value Can\'t Be Empty' : null,
                    ),
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
                      labelText: 'Address',
                      hintText: 'Address ',
                      hintStyle: TextStyle(fontSize: 12),
                      errorText: _validateAdd ? 'Value Can\'t Be Empty' : null,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  //   child: TextField(

                  // //    controller: _addressLine2C,
                  //     decoration: new InputDecoration(
                  //       focusedBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(
                  //             color: MyColors.PrimaryColor, width: 1.0),
                  //       ),
                  //       enabledBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(
                  //             color: MyColors.PrimaryColor, width: 1.0),
                  //       ),
                  //       labelText: 'Line 2 ',
                  //       hintText: 'Adress line 2',
                  //       hintStyle: TextStyle(fontSize: 12),
                  //     ),
                  //   ),
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
                  child: Text("Black Experience"),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Low",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    Radio(
                      value: 1,
                      groupValue: _radiogropValue,
                      onChanged: (value) {
                        setState(() {
                          _radiogropValue = value;
                        });
                      },
                    ),
                    Radio(
                      value: 2,
                      groupValue: _radiogropValue,
                      onChanged: (value) {
                        setState(() {
                          _radiogropValue = value;
                        });
                      },
                    ),
                    Radio(
                      value: 3,
                      groupValue: _radiogropValue,
                      onChanged: (value) {
                        setState(() {
                          _radiogropValue = value;
                        });
                      },
                    ),
                    Radio(
                      value: 4,
                      groupValue: _radiogropValue,
                      onChanged: (value) {
                        setState(() {
                          _radiogropValue = value;
                        });
                      },
                    ),
                    Radio(
                      value: 5,
                      groupValue: _radiogropValue,
                      onChanged: (value) {
                        setState(() {
                          _radiogropValue = value;
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "High",
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
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
                      // errorText: _validatesD ? 'Value Can\'t Be Empty' : null,
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
                  itemSize: 20,
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
                      SizedBox(
                        height: 20,
                      ),
                      !pic.isNull
                          ? ListTile(
                              title: Image.file(
                                pic,
                                height: 150,
                              ),
                              subtitle: IconButton(
                                onPressed: () async {
                                  await deletPic();
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            )
                          : RaisedButton(
                              child: Icon(Icons.add_a_photo),
                              onPressed: () async {
                                await getImage();
                              },
                              color: Colors.cyan,
                            ),
                      RaisedButton(
                        child: Text("Submit"),
                        onPressed: () async {
                          await getAllData();
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

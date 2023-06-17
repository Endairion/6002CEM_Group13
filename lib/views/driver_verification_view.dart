import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/utils/theme_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:mobile_app_development_cw2/viewmodels/driver_verification_viewmodel.dart';
import 'package:mobile_app_development_cw2/views/base_view.dart';
import 'package:mobile_app_development_cw2/views/navigation_menu_view.dart';
import 'package:mobile_app_development_cw2/views/profile_view.dart';

class DriverVerification extends StatefulWidget {
  const DriverVerification({Key? key}) : super(key: key);

  @override
  State<DriverVerification> createState() => _DriverVerificationState();
}

class _DriverVerificationState extends State<DriverVerification> {
  late final DriverVerificationViewModel _model;
  XFile? licensePlateImage;
  XFile? carImage;
  String? uploadedLicensePlateImageName;
  String? uploadedCarImageName;
  bool showLicensePlateButton = true;
  bool showCarImageButton = true;
  final ImagePicker picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseView<DriverVerificationViewModel>(
      onModelReady: (model) {
        _model = model;
        model.onModelReady();
      },
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text("Driver Verification"),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context); // Navigate back to the previous screen
            },
          ),
          backgroundColor: Color.fromRGBO(155, 214, 17, 1),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 5,
                        spreadRadius: 2,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'License Plate',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 5.0,
                                  spreadRadius: 2.0,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: TextFormField(
                              controller: _model.licensePlateController,
                              validator: _model.licensePlateValidator,
                              keyboardType: TextInputType.text,
                              decoration: ThemeHelper().editProfileInput(),
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            'Car Model',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 5.0,
                                  spreadRadius: 2.0,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: TextFormField(
                              controller: _model.carModelController,
                              validator: _model.carModelValidator,
                              keyboardType: TextInputType.text,
                              decoration: ThemeHelper().editProfileInput(),
                            ),
                          ),
                          const SizedBox(height: 6),
                          SizedBox(height: 16.0),
                          Text(
                            'Car Brand',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 5.0,
                                  spreadRadius: 2.0,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: TextFormField(
                              controller: _model.carBrandController,
                              validator: _model.carBrandValidator,
                              keyboardType: TextInputType.text,
                              decoration: ThemeHelper().editProfileInput(),
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            'License Plate Image',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 5.0,
                                  spreadRadius: 2.0,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                if (_model.showlPButton)
                                  ElevatedButton(
                                    onPressed: () {
                                      _model.uploadMenu(context, 'License Plate');
                                    },
                                    child: Text("Upload Photo"),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey[700],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      minimumSize: const Size(350, 40),
                                    ),
                                  ),
                                if (!_model.showlPButton && _model.uploadedlPImageName != null)
                                  DottedBorder(
                                    borderType: BorderType.RRect,
                                    strokeWidth: 1.0,
                                    color: Colors.black,
                                    dashPattern: [4, 4], // Adjust the dash pattern as needed
                                    radius: Radius.circular(8),
                                    child: Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Uploaded: ${_model.uploadedlPImageName}',
                                              style: TextStyle(fontSize: 16),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: (){
                                              _model.handleCancel('License Plate');
                                            },
                                            icon: Icon(Icons.cancel),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                              ],
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            'Car Image',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 5.0,
                                  spreadRadius: 2.0,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                if (_model.showCarButton)
                                  ElevatedButton(
                                    onPressed: () {
                                      _model.uploadMenu(context, 'Car');
                                    },
                                    child: Text("Upload Photo"),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey[700],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      minimumSize: const Size(350, 40),
                                    ),
                                  ),
                                if (!_model.showCarButton && _model.uploadedCarImageName != null)
                                  DottedBorder(
                                    borderType: BorderType.RRect,
                                    strokeWidth: 1.0,
                                    color: Colors.black,
                                    dashPattern: [4, 4], // Adjust the dash pattern as needed
                                    radius: Radius.circular(8),
                                    child: Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Uploaded: ${_model.uploadedCarImageName}',
                                              style: TextStyle(fontSize: 16),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: (){
                                              _model.handleCancel('Car');
                                            },
                                            icon: Icon(Icons.cancel),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          Center(
                            child: ElevatedButton(
                              onPressed: () => _model.submitVerification().then((value){
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(value),
                                    duration: const Duration(seconds: 2),
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    backgroundColor: value
                                        .contains('Driver verification successfully submitted')
                                        ? Colors.green[900]
                                        : Colors.red[900],
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 12),
                                  ),
                                );
                                if(value.contains('Driver verification successfully submitted')){
                                  Navigator.pop(context);

                                }
                              }),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green[900],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  minimumSize: const Size(200, 40)),
                              child: const Text('Submit Verification'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

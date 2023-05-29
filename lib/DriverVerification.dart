import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/common/theme_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:mobile_app_development_cw2/views/profile_view.dart';

class DriverVerification extends StatefulWidget {
  const DriverVerification({Key? key}) : super(key: key);

  @override
  State<DriverVerification> createState() => _DriverVerificationState();
}

class _DriverVerificationState extends State<DriverVerification> {
  XFile? licensePlateImage;
  XFile? carImage;
  String? uploadedLicensePlateImageName;
  String? uploadedCarImageName;
  bool showLicensePlateButton = true;
  bool showCarImageButton = true;
  final ImagePicker picker = ImagePicker();

  Future getLicensePlateImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      licensePlateImage = img;
    });

    uploadLicensePlateImage();
  }

  Future getCarImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      carImage = img;
    });
    uploadCarImage();

  }

  void handleLicensePlateUpload() {
    // Simulating the upload process
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media to select'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getLicensePlateImage(ImageSource.gallery);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[900],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      minimumSize: const Size(200, 40),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getLicensePlateImage(ImageSource.camera);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[900],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      minimumSize: const Size(200, 40),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });

    // Assume the file is successfully uploaded
  }

  void handleCarImageUpload() {
    // Simulating the upload process
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media to select'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getCarImage(ImageSource.gallery);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[900],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      minimumSize: const Size(200, 40),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getCarImage(ImageSource.camera);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[900],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      minimumSize: const Size(200, 40),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
    // Assume the file is successfully uploaded
  }

  void uploadLicensePlateImage() {
    if (licensePlateImage != null) {
        // Simulate the upload process for each image
        // Replace this with your actual upload code
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          uploadedLicensePlateImageName = licensePlateImage?.name;
          showLicensePlateButton = false;
        });
      });
    }
  }

  void uploadCarImage() {
    if (carImage != null) {
      // Simulate the upload process for each image
      // Replace this with your actual upload code
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          uploadedCarImageName = carImage?.name;
          showCarImageButton = false;
        });
      });
    }
  }

  void handleCancel(String imgType) {
    setState(() {
      switch(imgType){
        case 'License Plate':
          uploadedLicensePlateImageName = null;
          showLicensePlateButton = true;
          break;
        case 'Car':
          uploadedCarImageName = null;
          showCarImageButton = true;
          break;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        child: TextField(
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
                        child: TextField(
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
                        child: TextField(
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
                            if (showLicensePlateButton)
                              ElevatedButton(
                                onPressed: handleLicensePlateUpload,
                                child: Text("Upload Photo"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey[700],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  minimumSize: const Size(350, 40),
                                ),
                              ),
                            if (!showLicensePlateButton && uploadedLicensePlateImageName != null)
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
                                          'Uploaded: $uploadedLicensePlateImageName',
                                          style: TextStyle(fontSize: 16),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: (){
                                          handleCancel('License Plate');
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
                            if (showCarImageButton)
                              ElevatedButton(
                                onPressed: handleCarImageUpload,
                                child: Text("Upload Photo"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey[700],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  minimumSize: const Size(350, 40),
                                ),
                              ),
                            if (!showCarImageButton && uploadedCarImageName != null)
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
                                          'Uploaded: $uploadedCarImageName',
                                          style: TextStyle(fontSize: 16),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: (){
                                          handleCancel('Car');
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
                          onPressed: () async {
                            await ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text(
                                    'Verification submitted successfully'),
                                duration: const Duration(seconds: 2),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                backgroundColor: Colors.green[900],
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 12),
                              ),
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Profile()),
                            );
                          },
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
            ],
          ),
        ),
      ),
    );
  }
}

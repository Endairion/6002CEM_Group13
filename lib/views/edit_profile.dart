import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/utils/theme_helper.dart';
import 'package:mobile_app_development_cw2/viewmodels/edit_profile_viewmodel.dart';
import 'package:mobile_app_development_cw2/views/base_view.dart';
import 'package:mobile_app_development_cw2/views/navigation_menu_view.dart';
import 'package:mobile_app_development_cw2/views/profile_view.dart';


class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<EditProfileViewModel>(
      onModelReady: (model) => model.onModelReady(),
      builder: (context, model, child){
        TextEditingController nameController = model.nameController;
        TextEditingController emailController = model.emailController;
        TextEditingController dobController = model.dobController;
        TextEditingController contactController = model.contactController;
        TextEditingController ICNoController = model.icNoController;
        return Scaffold(
          appBar: AppBar(
            title: Text("Edit Profile"),
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
                            'Name',
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
                              controller: nameController,
                              decoration: ThemeHelper().editProfileInput(),
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            'Email',
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
                              controller: emailController,
                              decoration: ThemeHelper().editProfileInput(),
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            'Date of birth',
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
                            child: Stack(
                              alignment: Alignment.topRight,
                              children: [
                                TextField(
                                  controller: dobController,
                                  decoration: ThemeHelper().editProfileInput(),
                                ),
                                IconButton(
                                  icon: Icon(Icons.calendar_month),
                                  color: Colors.grey,
                                  onPressed: () async {
                                    DateTime initialDate = DateTime.now();
                                    if (dobController.text.isNotEmpty) {
                                      List<String> dateParts = dobController.text.split('/');
                                      if (dateParts.length == 3) {
                                        int day = int.tryParse(dateParts[0]) ?? initialDate.day;
                                        int month = int.tryParse(dateParts[1]) ?? initialDate.month;
                                        int year = int.tryParse(dateParts[2]) ?? initialDate.year;
                                        initialDate = DateTime(year, month, day);
                                      }
                                    }
                                    DateTime? selectedDate = await showDatePicker(
                                      context: context,
                                      initialDate: initialDate,
                                      firstDate: DateTime(1950),
                                      lastDate: DateTime.now(),
                                    );
                                    if (selectedDate != null) {
                                      String formattedDate =
                                          '${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year}';
                                      dobController.text = formattedDate;
                                      print(formattedDate);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            'Contact No',
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
                              controller: contactController,
                              decoration: ThemeHelper().editProfileInput(),
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            'IC No',
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
                              controller: ICNoController,
                              decoration: ThemeHelper().editProfileInput(),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Center(
                            child: ElevatedButton(
                              onPressed: () async {
                                model.updateUserProfile();
                                await ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text('Profile information changed successfully'),
                                    duration: const Duration(seconds: 2),
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    backgroundColor: Colors.green[900],
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                                  ),
                                );
                                Navigator.pop(
                                  context,
                                  MaterialPageRoute(builder: (context) => NavigationMenu()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green[900],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  minimumSize: const Size(150, 40)
                              ),
                              child: const Text('Edit Profile'),
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
    );
  }
}

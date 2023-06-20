import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/utils/theme_helper.dart';
import 'package:mobile_app_development_cw2/viewmodels/edit_profile_viewmodel.dart';
import 'package:mobile_app_development_cw2/views/base_view.dart';
import 'package:mobile_app_development_cw2/views/navigation_menu_view.dart';
import 'package:mobile_app_development_cw2/views/profile_view.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  late final EditProfileViewModel _model;

  @override
  Widget build(BuildContext context) {
    return BaseView<EditProfileViewModel>(onModelReady: (model) {
      _model = model;
      model.onModelReady();
    }, builder: (context, model, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Edit Profile"),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context); // Navigate back to the previous screen
            },
          ),
          backgroundColor: const Color.fromRGBO(155, 214, 17, 1),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: _formKey,
                  child: Container(
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
                          const Text(
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
                            child: TextFormField(
                              controller: _model.nameController,
                              validator: _model.nameValidator,
                              decoration: ThemeHelper().editProfileInput(),
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          const Text(
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
                            child: TextFormField(
                              controller: _model.emailController,
                              validator: _model.emailValidator,
                              decoration: ThemeHelper().editProfileInput(),
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          const Text(
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
                                TextFormField(
                                  controller: _model.dobController,
                                  validator: _model.dobValidator,
                                  decoration: ThemeHelper().editProfileInput(),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.calendar_month),
                                  color: Colors.grey,
                                  onPressed: () async {
                                    DateTime initialDate = DateTime.now();
                                    if (_model.dobController.text.isNotEmpty) {
                                      List<String> dateParts =
                                          _model.dobController.text.split('/');
                                      if (dateParts.length == 3) {
                                        int day = int.tryParse(dateParts[0]) ??
                                            initialDate.day;
                                        int month =
                                            int.tryParse(dateParts[1]) ??
                                                initialDate.month;
                                        int year = int.tryParse(dateParts[2]) ??
                                            initialDate.year;
                                        initialDate =
                                            DateTime(year, month, day);
                                      }
                                    }
                                    DateTime? selectedDate =
                                        await showDatePicker(
                                      context: context,
                                      initialDate: initialDate,
                                      firstDate: DateTime(1950),
                                      lastDate: DateTime.now(),
                                    );
                                    if (selectedDate != null) {
                                      String formattedDate =
                                          '${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year}';
                                      _model.dobController.text = formattedDate;
                                      print(formattedDate);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          const Text(
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
                            child: TextFormField(
                              controller: _model.contactController,
                              validator: _model.contactValidator,
                              decoration: ThemeHelper().editProfileInput(),
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          const Text(
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
                            child: TextFormField(
                              controller: _model.icNoController,
                              validator: _model.icNoValidator,
                              decoration: ThemeHelper().editProfileInput(),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Center(
                            child: ElevatedButton(
                              onPressed: () => _formKey.currentState!.validate()
                                  ? _model
                                      .updateUserProfile()
                                      .then((value) async {
                                      await ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(value),
                                          duration: const Duration(seconds: 2),
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          backgroundColor: value.contains('Profile information changed successfully')
                                              ? Colors.green[900]
                                              : Colors.red[900],
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 12),
                                        ),
                                      );
                                      Navigator.pop(
                                        context,
                                        true
                                      );
                                    })
                                  : null,
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green[900],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  minimumSize: const Size(150, 40)),
                              child: const Text('Edit Profile'),
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
      );
    });
  }
}

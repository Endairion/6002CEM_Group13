import 'package:mobile_app_development_cw2/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/viewmodels/base_viewmodel.dart';
import 'package:mobile_app_development_cw2/locator.dart';


class NavigationViewModel extends BaseViewModel {
  final FirebaseService _service = locator<FirebaseService>();
  int selectedIndex = 0;

  void updateSelectedIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  Future<bool> showLogoutConfirmationDialog(BuildContext context) async {
    // Show the logout confirmation dialog
    bool? shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Logout'),
        content: Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // Cancel logout
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true); // Confirm logout
            },
            child: Text('Logout'),
          ),
        ],
      ),
    );

    return shouldLogout ?? false; // Return false if the dialog is dismissed
  }

  Future<void> performLogout() async {
    await _service.signOut();
  }
}

import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/views/change_password_view.dart';
import 'package:mobile_app_development_cw2/HelpSupport.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool switchvalue = false, switchvalue1 = false;
  Color trackColor = Color.fromRGBO(155, 214, 17, 1), trackColor1 = Color.fromRGBO(155, 214, 17, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
        backgroundColor: Color.fromRGBO(155, 214, 17, 1),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 31.0,),
            Stack(
              children: [
                IgnorePointer(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      minimumSize: const Size(320, 45), // set minimumSize
                    ),
                    icon: const Icon(Icons.notifications),
                    label: const Text(
                      'Notifications',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 5,
                  bottom: 5,
                  child: Switch(
                    value: switchvalue,
                    onChanged: (bool value) {
                      setState(() {
                        switchvalue = value;
                        if(switchvalue){
                          trackColor = Color.fromRGBO(155, 214, 17, 1);
                        }else{
                          trackColor = Colors.grey;
                        }
                      });
                    },
                    trackColor: MaterialStateColor.resolveWith((states) => trackColor),
                    thumbColor: MaterialStateColor.resolveWith((states) => Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Stack(
              children: [
                IgnorePointer(
                  child: ElevatedButton.icon(
                    onPressed: (){},
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      minimumSize: const Size(320, 45), // set minimumSize

                    ),
                    icon: const Icon(Icons.mail),
                    label: const Text(
                      'Email Alerts',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 5,
                  bottom: 5,
                  child: Switch(
                    value: switchvalue1,
                    onChanged: (bool value) {
                      setState(() {
                        switchvalue1 = value;
                        if(switchvalue1){
                          trackColor1 = Color.fromRGBO(155, 214, 17, 1);
                        }else{
                          trackColor1 = Colors.grey;
                        }
                      });
                    },
                    trackColor: MaterialStateColor.resolveWith((states) => trackColor1),
                    thumbColor: MaterialStateColor.resolveWith((states) => Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChangePassword()),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                minimumSize: const Size(320, 45), // set minimumSize
              ),
              icon: const Icon(Icons.key),
              label: const Text('Change Password',
                style: TextStyle(
                  fontSize: 16,
                ),),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HelpSupport()),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                minimumSize: const Size(320, 45), // set minimumSize
              ),
              icon: const Icon(Icons.help),
              label: const Text('Help and Support',
                style: TextStyle(
                  fontSize: 16,
                ),),
            ),
          ],
        )
      ),
    );
  }
}

import 'package:elgam3a/screens/login_screen.dart';
import 'package:elgam3a/screens/profile_screen.dart';
import 'package:elgam3a/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import 'side_menu_items.dart';

class SideMenu extends StatelessWidget {
  SideMenu({@required this.userName});

  final String userName;
//  final ImageProvider userPicture;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Theme(
        child: Drawer(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 150.0),
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
//                    backgroundImage: userPicture,
                      backgroundColor: Colors.blue,
                      radius: 50.0,
                    ),
                    kSizedBox,
                    Text(userName),
                    kSizedBoxInSideMenu,
                    SideMenuItems(
                      pageName: 'Profile',
                      pageIcon: Icons.person,
                      onPressed: () {
                        Navigator.pushNamed(context, ProfileScreen.id);
                      },
                    ),
                    kSizedBoxInSideMenu,
                    SideMenuItems(
                      pageName: 'Settings',
                      pageIcon: Icons.settings,
                      onPressed: () {
                        Navigator.pushNamed(context, SettingsScreen.id);
                      },
                    ),
                    kSizedBox,
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      padding: kLogoutButtonSize,
                      color: kSecondaryColor,
                      child: Text('Logout'),
                      textColor: kButtonTextColor,
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                            (route) => false);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        data: ThemeData.dark(),
      ),
    );
  }
}

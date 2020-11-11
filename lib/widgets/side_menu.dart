import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import '../utilities/side_menu_items.dart';

class SideMenu extends StatelessWidget {
  SideMenu({@required this.userName});

  final String userName;
//  final ImageProvider userPicture;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Theme(
//        child: Padding(
//          padding: const EdgeInsets.only(top: 55.0),
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
                      onPressed: () {},
                    ),
                    kSizedBoxInSideMenu,
                    SideMenuItems(
                      pageName: 'Settings',
                      pageIcon: Icons.settings,
                      onPressed: () {},
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
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
//        ),
        data: ThemeData.dark(),
      ),
    );
  }
}

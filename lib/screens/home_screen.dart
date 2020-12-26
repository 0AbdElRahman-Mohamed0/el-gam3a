import 'package:elgam3a/screens/courses_screen.dart';
import 'package:elgam3a/screens/profile_screen.dart';
import 'package:elgam3a/screens/schedule_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<PersistentBottomNavBarItem> _items;

  List<Widget> _buildScreens() {
    return [
      ScheduleScreen(),
      CoursesScreen(),
      ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        backgroundColor: kPrimaryColor,
//        // centerTitle: true,
//        title: _selectedIndex == 0
//            ? Text('My Schedule')
//            : _selectedIndex == 1
//                ? Text('Courses')
//                : Text('Profile'),
//      ),
//      body: _widgetOptions.elementAt(_selectedIndex),
//      bottomNavigationBar: Container(
//        height: 90.0,
//        decoration: BoxDecoration(
//          boxShadow: [
//            BoxShadow(
//              color: Colors.black.withOpacity(0.16),
//              offset: Offset(0, -3),
//              blurRadius: 6,
//            ),
//          ],
//        ),
//        child: BottomNavigationBar(
//          backgroundColor: kPrimaryColor, //Colors.white,
//          selectedLabelStyle: TextStyle(
//            fontSize: 10,
//            fontWeight: FontWeight.w700,
//          ),
//          selectedIconTheme: IconThemeData(size: 24.0),
//          selectedItemColor: Colors.white, //kSecondaryColor, //kPrimaryColor
//          unselectedLabelStyle: TextStyle(
//            fontSize: 10,
//            fontFamily: 'Lato',
//            fontWeight: FontWeight.w700,
//          ),
//          unselectedIconTheme: IconThemeData(size: 24.0),
//          unselectedItemColor: Color(0x80FFFFFF), //Colors.black45,
//          type: BottomNavigationBarType.fixed,
//          items: <BottomNavigationBarItem>[
//            BottomNavigationBarItem(
//              icon: Icon(Icons.schedule),
//              label: 'Schedule',
//            ),
//            BottomNavigationBarItem(
//              icon: Icon(Icons.school),
//              label: 'Courses',
//            ),
//            BottomNavigationBarItem(
//              icon: Icon(Icons.person),
//              label: 'Profile',
//            ),
//          ],
//          currentIndex: _selectedIndex,
//          onTap: _onItemTapped,
//        ),
//      ),
//    );

    _items = [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.schedule),
//        _controller.index == 0
//            ? Padding(
//          padding: EdgeInsets.only(left: 8.0),
//          child: SvgPicture.asset(
//            'assets/svg/home.svg',
//            color: Theme.of(context).primaryColor,
//            height: 23.0,
//            width: 21.0,
//          ),
//        )
//            : Container(
//          height: 43.0,
//          width: (MediaQuery.of(context).size.width * 38) / 375,
//          padding: EdgeInsets.all(10.0),
//          decoration: BoxDecoration(
//              shape: BoxShape.circle,
//              color: Theme.of(context).dividerColor.withOpacity(0.1),
//              border: Border.all(
//                  color:
//                  Theme.of(context).dividerColor.withOpacity(0.5))),
//          child: SvgPicture.asset(
//            'assets/svg/home.svg',
//            color: Color(0xFFB3B4C8),
//            height: 23.0,
//            width: 21.0,
//          ),
//        ), //Icon(Icons.home),
//        contentPadding: 0.0,
//        iconSize: _controller.index == 0 ? 30 : 40,
        title: 'Schedule',
//        textStyle: Theme.of(context).textTheme.headline2.copyWith(
//          fontSize: 13,
//          fontWeight: FontWeight.w700,
//        ),
        activeColorAlternate: Theme.of(context).cardColor,
        activeColor: Theme.of(context).primaryColor,
        inactiveColor: Theme.of(context).dividerColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.school),
//        _controller.index == 1
//            ? Padding(
//          padding: EdgeInsets.only(left: 8.0),
//          child: SvgPicture.asset(
//            'assets/svg/society.svg',
//            color: Theme.of(context).primaryColor,
//          ),
//        )
//            : Container(
//          height: 43.0,
//          width: (MediaQuery.of(context).size.width * 38) / 375,
//          padding: EdgeInsets.all(10.0),
//          decoration: BoxDecoration(
//              shape: BoxShape.circle,
//              color: Theme.of(context).dividerColor.withOpacity(0.1),
//              border: Border.all(
//                  color:
//                  Theme.of(context).dividerColor.withOpacity(0.5))),
//          child: SvgPicture.asset(
//            'assets/svg/society.svg',
//            color: Color(0xFFB3B4C8),
//          ),
//        ), //Icon(Icons.chat),
//        contentPadding: _controller.index == 1 ? 5.0 : 0.0,
        title: 'Courses',
//        textStyle: Theme.of(context).textTheme.headline2.copyWith(
//          fontSize: 13,
//          fontWeight: FontWeight.w700,
//        ),
        activeColorAlternate: Theme.of(context).cardColor,
        activeColor: Theme.of(context).buttonColor,
        inactiveColor: Theme.of(context).dividerColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
//        _controller.index == 2
//            ? Padding(
//          padding: EdgeInsets.only(left: 8.0),
//          child: SvgPicture.asset(
//            'assets/svg/settings.svg',
//            color: Theme.of(context).primaryColor,
//          ),
//        )
//            : Container(
//          height: 43.0,
//          width: (MediaQuery.of(context).size.width * 38) / 375,
//          padding: EdgeInsets.all(10.0),
//          decoration: BoxDecoration(
//              shape: BoxShape.circle,
//              color: Theme.of(context).dividerColor.withOpacity(0.1),
//              border: Border.all(
//                  color:
//                  Theme.of(context).dividerColor.withOpacity(0.5))),
//          child: SvgPicture.asset(
//            'assets/svg/settings.svg',
//            color: Color(0xFFB3B4C8),
//          ),
//        ), //Icon(Icons.settings),
//        contentPadding: 0.0,
        title: 'Profile',
//        textStyle: Theme.of(context).textTheme.headline2.copyWith(
//          fontSize: 13,
//          fontWeight: FontWeight.w700,
//        ),
        activeColorAlternate: Theme.of(context).cardColor,
        activeColor: Theme.of(context).focusColor,
        inactiveColor: Theme.of(context).dividerColor,
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        // centerTitle: true,
        title: _controller.index == 0
            ? Text('My Schedule')
            : _controller.index == 1
                ? Text('Courses')
                : Text('Profile'),
      ),
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _items,
        navBarHeight: 84.0,
        padding: NavBarPadding.only(top: 13.0, bottom: 27.0),
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen when keyboard appears.
        stateManagement: true,
        onItemSelected: (value) {
          print('aaaaaaaaa $value');
          setState(() {});
        },
        hideNavigationBarWhenKeyboardShows:
            true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument.
        decoration: NavBarDecoration(
//        borderRadius: BorderRadius.circular(22.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle:
            NavBarStyle.style10, // Choose the nav bar style with this property.
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:elgam3a/models/user_model.dart';
import 'package:elgam3a/providers/auth_provider.dart';
import 'package:elgam3a/providers/password_reset_provider.dart';
import 'package:elgam3a/screens/edit_profile_screen.dart';
import 'package:elgam3a/screens/login_screen.dart';
import 'package:elgam3a/utilities/loading.dart';
import 'package:elgam3a/widgets/show_picture_pop_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _uploadedFileURL;

  @override
  void initState() {
    super.initState();
    Future.wait([context.read<AuthProvider>().getUserData()]);
    UserModel user = context.read<AuthProvider>().user;
    user?.imageUrl != null ?? false
        ? _uploadedFileURL = user.imageUrl
        : _uploadedFileURL = '';
  }

  _logout() {
    context.read<AuthProvider>().logOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
        (route) => false);
    context.read<PasswordResetProvider>().updateEmailSent(false);
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().user;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      if (user?.imageUrl?.isNotEmpty ?? false) ...{
                        InkWell(
                          onTap: () => showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                ShowPicturePopUp(user.imageUrl),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: const Color(0xffffffff),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0x1a000000),
                                  offset: Offset(0, 3),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                imageUrl: '${user.imageUrl}',
                                height: 112,
                                width: 112,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) => LoadingWidget(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                      }
                      // no image detected
                      else ...{
                        Container(
                          height: 112,
                          width: 112,
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).shadowColor,
                                offset: Offset(0, 3),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: user.type.toLowerCase() == 'student'
                              ? Image.asset(
                                  'assets/images/student.png',
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/images/doctor.png',
                                  fit: BoxFit.cover,
                                ),
                        ),
                      },
                      SizedBox(
                        width: 14,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${user?.name ?? ''}',
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${user.type}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditProfileScreen(),
                                ),
                              ),
                              child: Container(
//                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme.of(context).buttonColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Color(0xFF000000).withOpacity(0.34),
                                      offset: Offset(0, 3),
                                      blurRadius: 6,
                                    )
                                  ],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 14),
                                  child: Text('Edit Data'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UserData(
                        dataTitle: 'ID',
                        dataValue: '${user.univID}',
                      ),
                      UserData(
                        dataTitle: 'Email',
                        dataValue: '${user.email}',
                      ),
                      UserData(
                        dataTitle: 'Phone Number',
                        dataValue: '${user.phoneNumber}',
                      ),
                      if (user.type.toLowerCase() == 'student') ...{
                        user.department != null && user.minor != null
                            ? UserData(
                                dataTitle: 'Department',
                                dataValue: '${user.department} / ${user.minor}',
                              )
                            : SizedBox(),
                      } else ...{
                        UserData(
                          dataTitle: 'Department',
                          dataValue: '${user.department}',
                        )
                      },
                      if (user.type.toLowerCase() == 'student') ...{
                        UserData(
                          dataTitle: 'GPA',
                          dataValue: '${user.gpa} / 4.0',
                        ),
                        UserData(
                          dataTitle: 'Hours',
                          dataValue: '${user.completedHours} / 132',
                        ),
                      },
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                height: 44,
                child: InkWell(
                  onTap: _logout,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).errorColor,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF000000).withOpacity(0.34),
                          offset: Offset(0, 3),
                          blurRadius: 6,
                        )
                      ],
                    ),
                    child: Text(
                      'Logout',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class UserData extends StatelessWidget {
  UserData({this.dataTitle, this.dataValue});
  final String dataTitle;
  final String dataValue;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8),
          child: Row(
            children: [
              Text(
                '$dataTitle : ',
                style: Theme.of(context).textTheme.headline4.copyWith(
                      fontFamily: 'SF Mono',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              Expanded(
                child: Text(
                  '$dataValue',
                  style: Theme.of(context).textTheme.headline1.copyWith(
                        fontFamily: 'SF Pro Display',
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 12,
        ),
      ],
    );
  }
}

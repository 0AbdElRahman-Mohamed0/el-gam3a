import 'package:elgam3a/providers/auth_provider.dart';
import 'package:elgam3a/providers/courses_provider.dart';
import 'package:elgam3a/providers/departments_provider.dart';
import 'package:elgam3a/providers/faculties_provider.dart';
import 'package:elgam3a/providers/password_reset_provider.dart';
import 'package:elgam3a/screens/splash_screen.dart';
import 'package:elgam3a/utilities/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CoursesProvider>(
          create: (context) => CoursesProvider(),
        ),
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider<DepartmentsProvider>(
          create: (context) => DepartmentsProvider(),
        ),
        ChangeNotifierProvider<PasswordResetProvider>(
          create: (context) => PasswordResetProvider(),
        ),
        ChangeNotifierProvider<FacultiesProvider>(
          create: (context) => FacultiesProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'El-Gam3a',
        home: SplashScreen(),
        theme: AppTheme().lightTheme,
      ),
    );
  }
}

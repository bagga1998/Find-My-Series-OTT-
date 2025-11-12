import 'package:find_my_series/Screens/Home%20Screen/homeScreen.dart';
import 'package:find_my_series/Screens/Settings/Settings/settingScreen.dart';
import 'package:find_my_series/auth/First%20Welcome/welcomeScreen.dart';
import 'package:find_my_series/auth/Prefered%20Service/Preferred%20Services/preferedServices.dart';
import 'package:find_my_series/auth/Question%20&%20Answers/questionsScreen1.dart';
import 'package:find_my_series/auth/splashScreen.dart';
import 'package:find_my_series/widgets/bottomBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const SplashScreen(),
      // home: const QuestionListScreen(),
      // home: const Preferedlanguages(),
      // home: const bottomNavBar(),
      // home: const Homescreen(),
      // home: const AddUsersReviewsScreen(),
      // home: const SettingScreen(),
      // home: const Preferedservices1(),
    );
  }
}
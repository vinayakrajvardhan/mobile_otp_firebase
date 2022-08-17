import 'dart:math';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/SignIn.dart';
import 'package:flutter_application_1/ui/signup.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:toggle_switch/toggle_switch.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 591),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            tabBarTheme: TabBarTheme(),
          ),
          home: child,
        );
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            toolbarHeight: 10,
            backgroundColor: Colors.white,
            bottom: TabBar(
              indicator: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(50),
                  color: Color(0xffBFFB62)),
              indicatorColor: Colors.grey,
              labelColor: Colors.black54,
              splashBorderRadius: BorderRadius.all(Radius.circular(20)),
              tabs: [
                SizedBox(
                  height: 40,
                  child: Tab(
                    icon: Container(),
                    text: "SignUp",
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: Tab(
                    icon: Container(),
                    text: "SignIn",
                  ),
                )
              ],
            ),
          ),
          body: TabBarView(
            children: [
              SignUpPage(),
              LoginPage(),
            ],
          ),
        ),
      ),
    );
  }
}

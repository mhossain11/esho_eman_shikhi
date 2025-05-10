import 'package:esho_eman_shikhi/screen/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(ScreenUtilInit(
    designSize: Size(360, 690),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (context,child)=>MyApp(),
  ));
 // runApp(const MyApp());
//  runApp(DevicePreview(builder: (context) => MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
     // home: const HomeScreen(),
      home: const Homepage(),
    );
  }
}



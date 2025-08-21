 import 'package:esho_eman_shikhi/screen/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'controller/data_controller.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
      ScreenUtilInit(
        designSize: Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context,child)=> ChangeNotifierProvider(
          create: (BuildContext context) => DataController(),
          child:  MyApp(),


        ),
      ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      darkTheme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
            primary: Colors.white,
            seedColor: Colors.white),
        appBarTheme: AppBarTheme(color: Colors.white),
        //dialogTheme: DialogTheme(backgroundColor: Colors.white,)
      ),
      // home: const HomeScreen(),
      home: const Homepage(),
    );
  }
}



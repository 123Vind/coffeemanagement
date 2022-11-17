import 'dart:async';

import 'package:coffeemanagement/dbhelper/dbhelper.dart';
import 'package:coffeemanagement/dbhelper/dbnames.dart';
import 'package:coffeemanagement/screens/editmenuscreen.dart';
import 'package:coffeemanagement/screens/editscreen.dart';
import 'package:coffeemanagement/screens/orderScreen.dart';
import 'package:coffeemanagement/screens/receiptscreen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';


import 'screens/homepage.dart';

late Box box;
late Box box2;
Future<void> main() async {
  await Hive.initFlutter();
  box = await Hive.openBox(DbNames.dbname);
  box2 = await Hive.openBox(DbNames.dbname2);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>DbHelper())
      ]
      ,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Coffee Shop',
        theme: ThemeData(

  
          primaryColor: Colors.white,
          primarySwatch: Colors.lightBlue,
        ),
        home: SplashScreen(),
        routes: {
          HomePage.routename:(context) => const HomePage(),
          ReceiptScreen.routename:(context) =>ReceiptScreen(),
          OrderScreen.routename:(context) =>OrderScreen(),
          EditScreen.routename:(context) =>EditScreen(),
          EditMenuScreen.routename:(context) =>EditScreen(),
        },
      ),
    );
  }
}
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  Timer(Duration(seconds: 3),
          ()=>Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder:
                                                          (context) => 
                                                          HomePage()
                                                         )
                                       )
         );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(height: double.infinity,
      width: double.infinity,
      color: Colors.white,
      child: Center(child:Text('splash')),
      ),
    );
 
  }
}
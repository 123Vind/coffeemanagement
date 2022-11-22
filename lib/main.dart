import 'dart:async';

import 'package:coffeemanagement/dbhelper/dbhelper.dart';
import 'package:coffeemanagement/dbhelper/dbnames.dart';
import 'package:coffeemanagement/screens/changescreen.dart';
import 'package:coffeemanagement/screens/editmenuscreen.dart';
import 'package:coffeemanagement/screens/editscreen.dart';
import 'package:coffeemanagement/screens/orderScreen.dart';
import 'package:coffeemanagement/screens/receiptscreen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'screens/homepage.dart';
import 'screens/noitemscreen.dart';

late Box box;
late Box box2;
Future<void> main() async {
  await Hive.initFlutter();
  box = await Hive.openBox(DbNames.dbname);
  box2 = await Hive.openBox(DbNames.dbname2);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool db = false;

  @override
  void initState() {
    Box box = Hive.box(DbNames.dbname);
    if(box.get(DbNames.dbitemsbox)==null){
      print('null datas');
      
    //  DbHelper().initialadd();
     // DbHelper().initialadd();
    }
    else{
      db = true;
    }
    // TODO: implement initState
    super.initState();
  
  }

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

          fontFamily: 'Poppins',
          primaryColor: Colors.white,
          primarySwatch: Colors.brown,
        ),
        home:ChangeScreen(homepage: HomePage(), noitem: NoItemScreen()),
        routes: {
          HomePage.routename:(context) => const HomePage(),
          ReceiptScreen.routename:(context) =>ReceiptScreen(),
          OrderScreen.routename:(context) =>OrderScreen(),
          EditScreen.routename:(context) =>EditScreen(),
          EditMenuScreen.routename:(context) =>EditMenuScreen(),
          NoItemScreen.routename:(context) =>NoItemScreen(),
        },
      ),
    );
  }
}

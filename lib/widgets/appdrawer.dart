import 'package:coffeemanagement/dbhelper/dbnames.dart';
import 'package:coffeemanagement/screens/editscreen.dart';
import 'package:coffeemanagement/screens/orderScreen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              padding: const EdgeInsets.symmetric(horizontal:16),
              width: double.infinity,
              color: Colors.brown,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(80),
                    child: Container(
                      height: 50,
                      width: 50,
                      child:Image.asset('assets/logos.png',fit: BoxFit.cover,),
                      
                    ),
                  ),
                  Text('Coffee Shop',style: TextStyle(fontSize: 20,color: Colors.white),)
                ],
              ), 
            
            ),
     
            ListTile(leading: Icon(Icons.shop),
          title: Text('Order History'),
          onTap: (){
            Navigator.popAndPushNamed(context, OrderScreen.routename);
          },
          ),
            const Divider(),
          ListTile(leading: Icon(Icons.shop),
          title: Text('Edit Menu'),
          onTap: (){
            if(Hive.box(DbNames.dbname).get(DbNames.dbitemsbox)==null){
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(padding:EdgeInsets.all(0),content: SnackbarContainer(message: 'No items to show',),duration: Duration(milliseconds: 2000),));
            }
            else{
            Navigator.popAndPushNamed(context,EditScreen.routename);
            }
      
          },
          ),
          ],
        ),
      );
  }
}

class SnackbarContainer extends StatelessWidget {
  const SnackbarContainer({
    Key? key,
    required this.message
  }) : super(key: key);
  final String message;
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.brown,height: 80,width: double.infinity,
    padding: EdgeInsets.all(16),alignment: Alignment.center,
    child: Text(message,style: TextStyle(fontSize: 16),));
  }
}


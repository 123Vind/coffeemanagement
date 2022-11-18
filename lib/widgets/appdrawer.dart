import 'package:coffeemanagement/screens/editscreen.dart';
import 'package:coffeemanagement/screens/orderScreen.dart';
import 'package:flutter/material.dart';

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
            Navigator.pushNamed(context, OrderScreen.routename);
          },
          ),
            const Divider(),
          ListTile(leading: Icon(Icons.shop),
          title: Text('Edit Menu'),
          onTap: (){
            Navigator.pushNamed(context,EditScreen.routename);
          },
          ),
          ],
        ),
      );
  }
}


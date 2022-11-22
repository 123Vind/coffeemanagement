import 'package:coffeemanagement/screens/editmenuscreen.dart';
import 'package:coffeemanagement/widgets/appdrawer.dart';
import 'package:flutter/material.dart';

class NoItemScreen extends StatelessWidget {
  const NoItemScreen({Key? key}) : super(key: key);
  static const routename = 'noitemscreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coffee Shop'),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 100,
                padding: EdgeInsets.all(16),
                child: Image.asset('assets/logos.png',fit: BoxFit.cover,),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20)
                ),
                clipBehavior: Clip.antiAlias,
              ),
              Text('No items added',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              Text('Add your items here',style: TextStyle(fontSize: 16),),
              SizedBox(height: 10,),
              ElevatedButton(onPressed: (){
                Navigator.pushNamed(context,EditMenuScreen.routename );
              },child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Add items'),
              
              ),),
            ],
    
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
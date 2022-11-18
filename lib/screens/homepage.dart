

import 'package:coffeemanagement/dbhelper/dbhelper.dart';
import 'package:coffeemanagement/dbhelper/dbnames.dart';
import 'package:coffeemanagement/screens/editmenuscreen.dart';
import 'package:coffeemanagement/screens/receiptscreen.dart';
import 'package:coffeemanagement/widgets/appdrawer.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routename = 'homescreen';
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
late Box box;
late Box box2;
DbHelper helper = DbHelper();

 @override
  void initState() {
    if(Hive.box(DbNames.dbname)==null){
        print('no database');
        //print(helper.orderlist.length.toString);
        helper.initialadd();
    }
    else{
     

      // print(helper.orderlist.length.toString);
      print('database already created');
    }
    super.initState();
  }
 void onsave(List items,List orders){

    String s = " ";
    s = '${s}items\n';
    for(int i = 0;i<items.length;i++){
        s = '${s + items[i]}\n';
    }
    s = '${s}orders\n';
        for(int i = 0;i<orders.length;i++){
        s = '${s + items[i]}\n';
    }


    print(s);
 }

  @override
  Widget build(BuildContext context) {
    // List items = box.get(DbNames.dbitemsbox);
    // List orders = box.get(DbNames.dborderbox);
    final dbhelperProvider = Provider.of<DbHelper>(context);
    final itemlists = Provider.of<DbHelper>(context).itemlist;
    final catlist = Provider.of<DbHelper>(context).categoriess;


    return Scaffold(
      appBar:AppBar(title:const Text('Coffee Shop'),
      elevation: 0,
      actions: [
        IconButton(onPressed: (){
          Navigator.of(context).pushNamed(EditMenuScreen.routename);
        }, icon: Icon(Icons.add)),
      ],),

      body: Column(
        children: [
          Container(
            height: 80,
            padding: EdgeInsets.all(16),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
                itemBuilder:(context,i)=> InkWell(
                  onTap: (){
                      dbhelperProvider.changeindex(i);
                  },
                  child: Container(
                  padding: const EdgeInsets.all(16),
                  margin: EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: i == dbhelperProvider.indexes?Colors.amber:Colors.grey,
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Text(catlist[i]),
                              ),
                ),itemCount: catlist.length),
            ),
          Expanded(child: GridView.builder(
            itemCount: dbhelperProvider.itemlist.length,
            itemBuilder: (context, index) => CoffeeCards(index: index,),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 1,
              childAspectRatio: 1.3/2
            ),
          ),),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 30),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(8),topRight: Radius.circular(8),),
              color: Colors.grey[200]
            ),
            child: Column(
              children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        Text('Rs. ${dbhelperProvider.addamount}',style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                      ],
                      

                    ),
                    const SizedBox(height: 10,),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(onPressed: (){
                            double d = dbhelperProvider.addamount;
                            if(d>0){
                                Navigator.of(context).pushNamed(ReceiptScreen.routename);
                            }else{
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('NO ITEM ADDED'),duration: Duration(milliseconds: 1000),));
                            }

                      }, child: const Padding(
                        padding:  EdgeInsets.all(16.0),
                        child: Text('Print Receipt'),
                       
                      ),),
                    ),
              ],


            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
    );
  }
}


class CoffeeCards extends StatelessWidget {
  const CoffeeCards({Key? key,required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    final dbhelpers = Provider.of<DbHelper>(context);
    Map item = dbhelpers.itemlist[index];

    return Container(
      height: 300,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        gradient:LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.grey.withOpacity(0.3),Colors.brown.withOpacity(0.3)]
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            width: 100,
             decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12)
      
      ),
          ),
          const SizedBox(height: 10,),
          Text('${item['name']}',style: const TextStyle(fontSize:20,fontWeight: FontWeight.bold)),
          const SizedBox(height: 10,),
          Text('Rs. ${item['price']}',style: const TextStyle(fontSize:16)),
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              addbutton(icon: Icons.add,butfunc: (){
                int s = item['quantity'];
                //print('button click');
                s++;
                dbhelpers.changequantity(index,s);
              },),
              Text('${item['quantity']}',style: TextStyle(fontSize: 20),),
              addbutton(icon: Icons.remove,butfunc: (){
                int s = item['quantity'];
              if(s>0){
                s--;}
                else{
                  s= 0;
                }

               
                dbhelpers.changequantity(index,s);
              },),
            ],
          ),
          ],
      ),
    );
  }
}

class addbutton extends StatelessWidget {
  const addbutton({Key? key,
  required this.butfunc,
  required this.icon
  }) : super(key: key);
  final VoidCallback butfunc;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: butfunc,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.grey.withOpacity(0.6),width: 1.0,style: BorderStyle.solid)
        ),
        child:Center(child: Icon(icon,)),
      ),
    );
  }
}
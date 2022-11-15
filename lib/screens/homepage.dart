import 'package:coffeemanagement/dbhelper/dbhelper.dart';
import 'package:coffeemanagement/dbhelper/dbmodels.dart';
import 'package:coffeemanagement/dbhelper/dbnames.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

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
        helper.initialadd();
    }
    else{
      helper.initialadd();
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
    print(dbhelperProvider.itemlist.length.toString());
    return Scaffold(
      appBar:AppBar(title:const Text('Home Page'),
      actions: [
        IconButton(onPressed: (){
          dbhelperProvider.additems(ItemDbModel(id: 'coffee22345', itemname: 'americano', category: 'coffee', price: 60.00));
        }, icon: Icon(Icons.add))
      ],
      
      ),

      body: Center(
        child: Column(
          children: [
            Expanded(child: GridView.builder(
              itemCount: dbhelperProvider.itemlist.length,
              itemBuilder: (context, index) => CoffeeCards(index: index,),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 1,
                childAspectRatio: 1.3/1.5
              ),
            ),)
          ],
        ),
      ),
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
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12)
      
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
                print('button click');

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
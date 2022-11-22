import 'package:coffeemanagement/dbhelper/dbhelper.dart';
import 'package:coffeemanagement/dbhelper/dbnames.dart';
import 'package:coffeemanagement/screens/receiptscreen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:provider/provider.dart';




class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);
  static const routename = 'orderscreen';

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  DbHelper dbHelper = DbHelper();
  Box box = Hive.box(DbNames.dbname2);
  bool orderlistcheck = false;
    @override
  void initState() {
    //dbHelper.getListorders();
    if(box.get(DbNames.dborderbox)==null){
      print('no orders data');
    }
    else{
      orderlistcheck = true;
    }
  
    // TODO: implement initState
    super.initState();
  }

 
  @override
  Widget build(BuildContext context) {
    final dbHelper = Provider.of<DbHelper>(context);
    List s = [];
    if(orderlistcheck){
      s = dbHelper.orderlist;
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Order History'),
        ),
        body:orderlistcheck?ListView.builder(itemCount: s.length,itemBuilder:(context,index)=> OrderContainer(i:index,item:s[index])):Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text('No orders yet',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          Text('khara haana yollugo chatlo',style: TextStyle(fontSize: 16),)
          ],),
        ) 

    );
  }
}

class OrderContainer extends StatelessWidget {
  const OrderContainer({
    Key? key,
    required this.i,
    required this.item,
  }) : super(key: key);
  final int i;
  final Map item;

  List<String> getphonetime(){
    List<String> s = [];
    String text = item['id'];
    if(text.isNotEmpty){
      s = text.split('#');
    }
    
    
    return s;
  }

  @override
  Widget build(BuildContext context) {
    List d = item['items'];
    double amount = DbHelper().getAmountsorders(d);
    return Container( 

        margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 24),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8)
          ),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                 const SizedBox(height: 5,),
                 Text(getphonetime()[0],style: TextStyle(fontSize: 16),),
                  const SizedBox(height: 5,),
                 Row(
                   children: [
                     Icon(Icons.phone,size: 20,color: Colors.grey[700],),
                     Text(getphonetime()[1],style: TextStyle(fontSize: 16),),
                   ],
                 ),

                 const SizedBox(height: 15,),
                 Container(
                   
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8)
                  ),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text('Total',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                       Text('Rs. $amount',style: TextStyle(fontSize: 16),),
                     ],
                   ),
                 ),
            ], 
          ),
          
          );
  }
}

class OrderCards extends StatelessWidget {
  const OrderCards({Key? key,required this.index,required this.item}) : super(key: key);
final int index;
final List item;
  @override
  Widget build(BuildContext context) {
      final _orderlist = Provider.of<DbHelper>(context).orderlist;
    return Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 24),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8)
          ),
          child: Column(
            children: [
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(8)
          ),
       
        
              ),
                 const SizedBox(height: 5,),
                 Text('${_orderlist[index]['time']}'),
            
                 Expanded(child: ListView(
                   children: _orderlist[index]['items'].map((e)=>ReceiptCard(item: e)).toList(),
                 )),
            ], 
          ),
    );
  }
}
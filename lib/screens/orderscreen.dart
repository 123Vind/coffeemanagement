import 'package:coffeemanagement/dbhelper/dbhelper.dart';
import 'package:coffeemanagement/screens/receiptscreen.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';




class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);
  static const routename = 'orderscreen';

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  DbHelper dbHelper = DbHelper();
    @override
  void initState() {
    dbHelper.getListorders();
  
    // TODO: implement initState
    super.initState();
  }

 
  @override
  Widget build(BuildContext context) {
    final dbHelper = Provider.of<DbHelper>(context);
    List s = dbHelper.orderlist;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Order History'),
        ),
        body:s.isEmpty?Center(child: Text('No orders yet\n khara haana yollugo'),):ListView.builder(itemBuilder:(context,index)=> OrderContainer(i:index,item:s[index]),
        itemCount: s.length,
        ),

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
                 Text('${item['time']}',style: TextStyle(fontSize: 16),),
                  const SizedBox(height: 5,),
                 Text('${item['id']}',style: TextStyle(fontSize: 16),),

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
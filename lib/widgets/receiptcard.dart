import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../dbhelper/dbhelper.dart';
class ReceiptCard extends StatelessWidget {
  const ReceiptCard({Key? key,required this.item}) : super(key: key);
  final Map item ;
  @override
  Widget build(BuildContext context) {
    final dbprovider = Provider.of<DbHelper>(context);
      return Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
             color: Colors.grey[50],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item['name'],style: TextStyle(fontSize: 20),),
            SizedBox(height:10),
            Text('Quantity: ${item['quantity']}',style: TextStyle(fontSize: 16)),
             SizedBox(height:10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Price: Rs.${item['price']}',style: TextStyle(fontSize: 16),),
                Text('Total: Rs.${item['price'] * item['quantity']}',style: TextStyle(fontSize: 20),),
              ],
            ),
          ],
        ),
      );
  }
}
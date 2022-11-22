import 'package:coffeemanagement/dbhelper/dbhelper.dart';
import 'package:coffeemanagement/dbhelper/dbmodels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReceiptScreen extends StatefulWidget {
  ReceiptScreen({Key? key}) : super(key: key);
  static const routename = 'receiptscreen';

  @override
  State<ReceiptScreen> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  bool checkprogress = false;
  final _form = GlobalKey<FormState>();
  final _phonecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final dbprovider = Provider.of<DbHelper>(context);
    final date = DateTime.now();
      return Scaffold(
        appBar: AppBar(
          title: const Text('Receipt'),
        ),
        body: checkprogress?CircularProgressIndicator(
          color: Colors.white,
          backgroundColor: Colors.grey,
        ): Container(

          width: double.infinity,
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color.fromARGB(255, 241, 239, 239)
          ),
          child: Column(
            children: [
              Text('Coffee Shop',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
              SizedBox(height: 10,),
              Text('Receipt',style: TextStyle(fontSize: 16)),
              SizedBox(height: 10,),
              Text('${date}'),
             Form(
               key: _form,
               child: Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                 child: TextFormField(
                    controller: _phonecontroller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.phone),
                      labelText:'Phone',
             
                    ),
                  keyboardType: TextInputType.phone,
                  validator: (v){
                    if(v!.isEmpty){
              
                      return 'Please provide a number';
                      
                    
                    }
                  },
                  ),
               ),
             ),
              Expanded(child: ListView(
                children:dbprovider.getreceipt.map((e) => ReceiptCard(item: e,)).toList() ,
              )),
              Container(
               
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.brown[200]
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Text('Total',style: TextStyle(fontSize: 20),),
                Text('Rs.${dbprovider.getAmounts()}',style: TextStyle(fontSize: 20),),
                      ],
                    ),
                  
                  ],
      
                ),
              ),
              const SizedBox(height: 10,),
              
              InkWell(
                onTap: (){
                   
                  setState(() {
                   
                  if(checkprogress){
                        checkprogress = false;
                  }else{
                        if(_form.currentState!.validate()){
                        checkprogress = true;
                        dbprovider.addorders(OrderDbModel(orderId: '${DateTime.now()}#${_phonecontroller.text}', time: '${DateTime.now()}', items: dbprovider.getreceipt));
                        dbprovider.clearitems();
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Items added'),duration: Duration(milliseconds: 1000),));
                        }
                        else{
                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid Phone number'),duration: Duration(milliseconds: 1000),));
                        }
             
                  
                  }
                    checkprogress = false;
         
                  });
           
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.brown[900]
                  ),
                  child:Center(child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const[
                      Icon(Icons.receipt,color: Colors.white),
                      Text('Print receipt',style: TextStyle(fontSize: 20,color: Colors.white),),
                    ],
                  )),
                ),
              )
            ],
          ),
        ),
      );
  }
}

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
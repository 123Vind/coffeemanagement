import 'package:coffeemanagement/dbhelper/dbhelper.dart';
import 'package:coffeemanagement/screens/editmenuscreen.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({Key? key}) : super(key: key);
  static const routename = 'editscreen';
  @override
  Widget build(BuildContext context) {
    final dbhelper = Provider.of<DbHelper>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Items'),
          actions: [
            IconButton(onPressed: (){
              Navigator.of(context).pushNamed(EditMenuScreen.routename);
            }, icon: const Icon(Icons.add)),
          ],
        ),
        body: ListView.builder(itemBuilder:(context,i)=>EditCard(index:i),
        itemCount: dbhelper.itemlist.length,
        ),

    );
  }
}
class EditCard extends StatelessWidget {
  const EditCard({Key? key,required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    final itemslist = Provider.of<DbHelper>(context).itemlist;
    final dbhelper = Provider.of<DbHelper>(context);
    return Container(
        
        width: double.infinity,
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[200],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(itemslist[index]['name']),
                  SizedBox(height: 5,),
                  Text('${itemslist[index]['category']}'),
                  SizedBox(height: 5,),
                  Text('Rs.${itemslist[index]['price']}'),
                  SizedBox(height: 5,),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                
                children: [
                  //edit button
                  InkWell(
                    onTap: (){
                        Navigator.of(context).pushNamed(EditMenuScreen.routename,arguments: index);
                    },
                    child: Container(
                      padding:const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.amber
                      ),
                      child: const Icon(Icons.edit,color: Colors.black,),
                    ),
                  ),
                  
                  //delete button
                 
                 
                  InkWell(
                    onTap: (){
                          showModalBottomSheet(context: context, builder:(context)=>Container(
                            height: 200,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(8)
                              ,topRight:Radius.circular(8) )
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text('Delete this Item',style: TextStyle(fontSize: 20)),
                                const SizedBox(height: 10,),
                                Text(itemslist[index]['name'],style: TextStyle(fontSize: 16),),
                                 const SizedBox(height: 10,),
                                Text('${itemslist[index]['category']}',style: TextStyle(fontSize: 16),),
                                const SizedBox(height: 40,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ElevatedButton(onPressed: (){
                                      Navigator.of(context).pop();
                                    }, child:Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: const Text('Cancel'),
                                    )),
                                    const SizedBox(height: 10,width: 10,),
                                    ElevatedButton(onPressed: (){
                                    dbhelper.deleteItems(index);
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Item Deleted'),duration: Duration(milliseconds: 1000),));  
                                    Navigator.of(context).pop();

                                    }, child:Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: const Text('Delete'),
                                    ),),
                                  ],
                                )
                              ],
                            ),
                          ));

                    },
                    child: Container(                      
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.redAccent
                      ),
                      child: const Icon(Icons.delete,color: Colors.black,),
                    ),
                  )
                ],
              ),
            )

          ],
        ),
    );
  }
}

import 'package:coffeemanagement/dbhelper/dbmodels.dart';
import 'package:coffeemanagement/dbhelper/dbnames.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DbHelper with ChangeNotifier{

Box itembox = Hive.box(DbNames.dbname);
Box orderbox = Hive.box(DbNames.dbname2);

List items = [];
List orders = [];

List itemcopy = [
  {
   'id':'o1coffee',
    'category':'beverages',
    'name':'coffee',
    'price':60,
    'quantity':1,
},
  {
'id':'o2coffee',
    'category':'beverages',
    'name':'coffee yo',
    'price':60,
    'quantity':1,
},
  {
'id':'o3coffee',
    'category':'beverages',
    'name':'coffee white',
    'price':60,
    'quantity':1,
},
  {
'id':'o4coffee',
    'category':'beverages',
    'name':'coffeeblack',
    'price':60,
    'quantity':1,
},

];



List get itemlist{
  updateitems();
  return[...items];
}

List get orderlist{
  updateorders();
  return[...orders];
}

void initialadd(){
    itembox.put(DbNames.dbitemsbox, itemcopy);
    updateitems();
    notifyListeners();
}



void changequantity(int index,int quantity){
  // print('change $quantity');
    items[index]['quantity'] = quantity;
  itembox.put(DbNames.dbitemsbox, items);
  updateitems();
  notifyListeners();
}

void additems(ItemDbModel itemmodel){
  Map s = {
    'id':itemmodel.id,
    'category':itemmodel.category,
    'name':itemmodel.itemname,
    'price':itemmodel.price,
    'quantity':itemmodel.quantity,
  };
  items.add(s);
  itembox.put(DbNames.dbitemsbox, items);
  updateitems();
  notifyListeners();
}

void deleteItems(String id){
  items.removeWhere((element) => element[id]);
  itembox.put(DbNames.dbitemsbox, items);
  updateitems();
  notifyListeners();
}


List convertitems(List<ItemDbModel> itemss){
  List b = [];
  for(int i  = 0;i<itemss.length;i++){
       Map s = {
    'id':itemss[i].id,
    'category':itemss[i].category,
    'name':itemss[i].itemname,
    'price':itemss[i].price,
    'quantity':itemss[i].quantity,
  }; 
    b.add(s);
  }
  return b;

}

void addorders(OrderDbModel ordermodel){
  List d = convertitems(ordermodel.items);
  Map s = {
    'id':ordermodel.orderId,
    'time':ordermodel.time,
    'items':d,

  };
  items.add(s);
  itembox.put(DbNames.dbitemsbox, items);
  updateorders();
  notifyListeners();
}


void updateitems(){
items = itembox.get(DbNames.dbitemsbox);

}

void updateorders(){
orders = orderbox.get(DbNames.dborderbox);

}








}
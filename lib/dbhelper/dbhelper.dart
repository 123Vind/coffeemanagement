
import 'package:coffeemanagement/dbhelper/dbmodels.dart';
import 'package:coffeemanagement/dbhelper/dbnames.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DbHelper with ChangeNotifier{

Box itembox = Hive.box(DbNames.dbname);
Box orderbox = Hive.box(DbNames.dbname2);

List items = [];
List orders = [];
double addamount = 0.0;
int index = 0;
int get indexes{
  return index;
}
void changeindex(int i){
  index  = i;
  notifyListeners();
}

 List<String> catlist = ['all'];
List ordercopy = [{
  'time':'20/11/2022',
  'id':'gjdke',
  'items':[
      {
   'id':'o1coffee',
    'category':'beverages',
    'name':'coffee',
    'price':60,
    'quantity':1,
},
  {
   'id':'o1coffe2',
    'category':'beverages',
    'name':'coffee22',
    'price':70,
    'quantity':2,
},
],
},
{
  'time':'21/11/2022',
  'id':'gjdkeere',
  'items':[
      {
   'id':'o1coffee',
    'category':'beverages',
    'name':'coffee',
    'price':60,
    'quantity':2,
},
  {
   'id':'o1coffe2',
    'category':'beverages',
    'name':'coffee22',
    'price':70,
    'quantity':2,
},
],
},


];

List itemcopy = [
  {
   'id':'o1coffee',
    'category':'beverages',
    'name':'coffee',
    'price':60,
    'quantity':0,
},
  {
'id':'o2coffee',
    'category':'beverages',
    'name':'coffee yo',
    'price':60,
    'quantity':0,
},
  {
'id':'o3coffee',
    'category':'beverages',
    'name':'coffee white',
    'price':60,
    'quantity':0,
},
  {
'id':'o4coffee',
    'category':'beverages',
    'name':'coffeeblack',
    'price':60,
    'quantity':0,
},

];



List get itemlist{

  updateitems();

  return[...items];
}


void getListorders(){
  try{
    List s =orderbox.get(DbNames.dborderbox);
    print(s);
  }
  catch(e){
    initialaddorders();
      print('error getting data ${e}');
  }

}


List get orderlist{
  updateorders();
 
  return[...orders];
}

List get getreceipt{
  return itemlist.where((element) => element['quantity']>0).toList();
}
void initialadd(){
    itembox.put(DbNames.dbitemsbox, itemcopy);
    updateitems();
    notifyListeners();
}

void initialaddorders(){
    orderbox.put(DbNames.dborderbox, ordercopy);   
}

void changequantity(int index,int quantity){
  // print('change $quantity');
    items[index]['quantity'] = quantity;
  itembox.put(DbNames.dbitemsbox, items);
  addAmounts();
  updateitems();
  notifyListeners();
}

void addAmounts(){
  addamount = 0.0;
  for(int i = 0;i<itemlist.length;i++){
      addamount = addamount+(itemlist[i]['price']*itemlist[i]['quantity']);
  }
    notifyListeners();
}


double getAmounts(){
  double amount = 0.0;
  for(int i = 0;i<itemlist.length;i++){
      amount = amount+(itemlist[i]['price']*itemlist[i]['quantity']);
  }
  return amount;
}
double getAmountsorders(List item){
  double amount = 0.0;
  for(int i = 0;i<item.length;i++){
      amount = amount+(item[i]['price']*item[i]['quantity']);
  }
  return amount;
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

  List get categoriess{

    return catlist;
  
  }

void changecats(){
      String cats='';
    for(int i = 0;i<itemlist.length;i++){
        cats = items[i]['category'];
        if(i == 0){
          catlist.add(cats);
        }
    
        print(cats);
        
        if(itemlist[i]['category'] ==  cats){
          
          print(catlist);
          cats = itemlist[i]['category'];
          continue;
        }
    catlist.add(cats);
        
    }
    notifyListeners();
}

void updateitemdb(ItemDbModel itemmodel,int index){
  Map s = {
    'id':itemmodel.id,
    'category':itemmodel.category,
    'name':itemmodel.itemname,
    'price':itemmodel.price,
    'quantity':itemmodel.quantity,
  };
  items[index] = s;
  itembox.put(DbNames.dbitemsbox, items);
  updateitems();
  notifyListeners();
}


void deleteItems(int index){
  items.removeAt(index);
  itembox.put(DbNames.dbitemsbox, items);
  updateitems();
  notifyListeners();
}




List convertitems(List itemss){
  List b = [];
  Map s = {};
  for(int i  = 0;i<itemss.length;i++){
       s = {

    'category':itemss[i]['category'],
    'id':itemss[i]['id'],
    'name':itemss[i]['name'],
    'price':itemss[i]['price'],
    'quantity':itemss[i]['quantity'],
  }; 
    b.add(s);
  }
  return b;

}


void clearitems(){
  items = itembox.get(DbNames.dbitemsbox);
  for(int i = 0;i<items.length;i++){
    items[i]['quantity'] = 0;
  } 
itembox.put(DbNames.dbitemsbox, items);
addamount = 0.0;
updateitems();
updateorders();
notifyListeners();
}

double getorderamount(List ite){
  double d = 0;
  for(int i = 0;i<ite.length;i++){
    d = d + (ite[i]['price']*ite[i]['quantity']);
  }
  return d;
}


void addorders(OrderDbModel ordermodel){
  print('orders add area');
  List d = convertitems(ordermodel.items);
  orders.add(
    {
      'id':ordermodel.orderId,
      'time':ordermodel.time,
      'items':d,
    }
  );
  orderbox.put(DbNames.dborderbox, orders);
  print('add orders');
  updateorders();
  notifyListeners();
}




void updateitems(){
items = itembox.get(DbNames.dbitemsbox);

}

void updateorders(){
  try {
    orders = orderbox.get(DbNames.dborderbox);
  
} on Exception catch (e) {
  // TODO
      print('empty database or errors');
}
}


}
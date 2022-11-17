class ItemDbModel{

String itemname;
String id;
String category;
double price;
int quantity;


ItemDbModel({
  required this.id,
  required this.itemname,
  required this.category,
  required this.price,
  this.quantity = 0,
});
}


class OrderDbModel{
String orderId;
List items;
String time;

OrderDbModel({
  required this.orderId,
  required this.time,
  required this.items,
});
}


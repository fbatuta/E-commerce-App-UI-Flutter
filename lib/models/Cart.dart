import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_app/models/Product.dart';

class Cart {
  String cid;
  String pid;
  Product? product;
  int quantity;

  Cart(
      {required this.cid,
      required this.pid,
      required this.quantity,
      required this.product});

  factory Cart.fromDocuments(DocumentSnapshot doc) {
    return Cart(
        cid: doc['cid'],
        pid: doc['pid'],
        quantity: doc['quantity'],
        product: doc['product']);
  }

  Map<String, dynamic> toMap() {
    return {"pid": pid, "quantity": quantity, "product": product?.toMap()};
  }
}

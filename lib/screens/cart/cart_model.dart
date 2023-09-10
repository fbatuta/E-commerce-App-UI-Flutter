import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/user/user_model.dart';

class CartModel extends Model {
  UserModel? user;
  //List<Product> products = [];
  List<Cart> lstCart = [];
  bool isLoading = false;
  String? couponCode;
  int discountPercentage = 0;
  int prazo = 0;
  double preco = 0;
  String _users = "users";
  String _cart = "cart";
  CartModel(this.user) {
    if (user!.isLoggedIn()) _loadCartItems();
  }
  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);
  void addCartItem(Product product) {
    lstCart.add(
        new Cart(cid: "1", pid: product.id, quantity: 1, product: product));
    FirebaseFirestore.instance
        .collection(_users)
        .doc(user?.firebaseUser?.uid)
        .collection(_cart)
        .add(product.toMap())
        .then((doc) {
      product.id = doc.id;
    });
    notifyListeners();
  }

  void removeCartItem(Product product) {
    FirebaseFirestore.instance
        .collection(_users)
        .doc(user?.firebaseUser?.uid)
        .collection(_cart)
        .doc(product.id)
        .delete();
    lstCart.remove(product);
    notifyListeners();
  }

  /*
  void decProduct(Product product) {
    if (product != null) product.quantity--;
    FirebaseFirestore.instance
        .collection(_users)
        .doc(user?.firebaseUser?.uid)
        .collection(_cart)
        .doc(product.cid)
        .update(product.toMap());
    notifyListeners();
  }
  */

  /*
  void incProduct(Product cartProduct) {
    product.quantity++;
    FirebaseFirestore.instance
        .collection(_users)
        .doc(user?.firebaseUser?.uid)
        .collection(_cart)
        .doc(product.id)
        .update(product.toMap());
    notifyListeners();
  }
    */

  void setCoupon(String couponCode, int discountPercentage) {
    this.couponCode = couponCode;
    this.discountPercentage = discountPercentage;
  }

  void updatePrices() {
    notifyListeners();
  }

  void setShip(int prazo, double preco) {
    this.prazo = prazo;
    this.preco = preco;
  }

  double getProductsPrice() {
    double price = 0.0;
    for (Cart c in lstCart) {
      final productData = c.product;
      if (productData != null) {
        price += c.quantity * productData.price;
      }
    }
    return price;
  }

  double getDiscount() {
    return getProductsPrice() * discountPercentage / 100;
  }

  double? getShipPrice() {
    if (preco > 0)
      return preco;
    else
      return 9.99;
  }

  Future<String?> finishOrder() async {
    if (lstCart.length == 0) return null;
    isLoading = true;
    notifyListeners();
    double productsPrice = getProductsPrice();
    double discount = getDiscount();
    DocumentReference refOrder =
        await FirebaseFirestore.instance.collection("orders").add({
      "clientId": user?.firebaseUser?.uid,
      //"products": products.map((lstCartProduct) => lstCartProduct.toMap()).toList(),
      "productsPrice": productsPrice,
      "discount": discount,
      "totalPrice": productsPrice - discount,
      "status": 1
    });
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user?.firebaseUser?.uid)
        .collection("orders")
        .doc(refOrder.id)
        .set({"orderId": refOrder.id});
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection("users")
        .doc(user?.firebaseUser?.uid)
        .collection("cart")
        .get();
    for (DocumentSnapshot doc in query.docs) {
      doc.reference.delete();
    }
    lstCart.clear();
    couponCode = null;
    discountPercentage = 0;
    isLoading = false;
    notifyListeners();
    return refOrder.id;
  }

  void _loadCartItems() async {
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection(_users)
        .doc(user?.firebaseUser?.uid)
        .collection(_cart)
        .get();
    lstCart = query.docs.map((doc) => Cart.fromDocuments(doc)).toList();
    notifyListeners();
  }
}

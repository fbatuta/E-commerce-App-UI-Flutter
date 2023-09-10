import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/models/Product.dart';

import 'package:shop_app/screens/cart/cart_model.dart';

class CartScreen extends StatelessWidget {
  final Cart cart;

  CartScreen(this.cart, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _buildContent() {
      CartModel.of(context).updatePrices();

      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 120.0,
            child: Image.asset(
              "assets/images/ak_1.png",
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                cart.product?.title ?? "",
                style: const TextStyle(
                    fontWeight: FontWeight.w500, fontSize: 17.0),
              ),
              Text("R\$ ${cart.product?.price?.toStringAsFixed(2)}",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                      onPressed: cart.quantity > 1
                          ? () {
                              CartModel.of(context).decProduct(cart.product);
                            }
                          : null,
                      icon: Icon(
                        Icons.remove,
                        color: Theme.of(context).primaryColor,
                      )),
                  Text(cart.quantity.toString()),
                  IconButton(
                      onPressed: () {
                        CartModel.of(context).incProduct(cart.product);
                      },
                      icon: Icon(Icons.add,
                          color: Theme.of(context).primaryColor)),
                  TextButton(
                    onPressed: () {
                      CartModel.of(context).removeCartItem(cart.product);
                    },
                    style: flatButtonStyle,
                    child: Text("Remover"),
                  ),
                ],
              )
            ],
          ))
        ],
      );
    }

    return Card(
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: cart.product == null
            ? FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection("products")
                    .doc(cart.category)
                    .collection('itens')
                    .doc(cart.pid)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    cart.product = Product.fromDocument(snapshot.data);
                    return _buildContent();
                  } else {
                    return Container(
                      height: 70.0,
                      child: CircularProgressIndicator(),
                      alignment: Alignment.center,
                    );
                  }
                })
            : _buildContent());
  }

  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    foregroundColor: Colors.grey.shade500,
    minimumSize: Size(88, 36),
    padding: EdgeInsets.zero,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)),
    ),
  );
}

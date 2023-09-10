import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  late final String id;
  final String type;
  final String subType;
  final String title;
  final String description;
  final double price;
  final Color backgroundColor;
  final List<Object> items;

  Product(
      {required this.id,
      required this.type,
      required this.subType,
      required this.title,
      required this.description,
      required this.price,
      required this.backgroundColor,
      required this.items});

  factory Product.fromDocument(DocumentSnapshot? doc) {
    return Product(
        id: doc!['id'],
        type: doc['type'],
        subType: doc['subType'],
        title: doc['title'],
        description: doc['description'],
        price: doc['price'],
        backgroundColor: doc['backgroundColor'],
        items: doc['items']);
  }

  Map<String, dynamic> toMap() {
    return {"title": title, "discription": description, "price": price};
  }
}

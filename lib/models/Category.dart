import 'package:flutter/material.dart';

class Category {
  final String image, title, description;
  final int id;
  final Color color;

  Category(
      {required this.image,
      required this.title,
      required this.description,
      required this.id,
      required this.color});
}

List<Category> products = [
  Category(
      id: 1,
      title: "Riffle Single",
      description: dummyText,
      image: "assets/images/bag_1.png",
      color: Color(0xFF3D82AE)),
  Category(
      id: 2,
      title: "Riffle Duos",
      description: dummyText,
      image: "assets/images/bag_2.png",
      color: Color(0xFFD3A984)),
  Category(
      id: 3,
      title: "Riffle Trios",
      description: dummyText,
      image: "assets/images/bag_3.png",
      color: Color(0xFF989493)),
];

String dummyText =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";

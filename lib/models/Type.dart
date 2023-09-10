import 'package:flutter/material.dart';

class Type {
  final String name, description;
  final int id;

  Type({
    required this.name,
    required this.description,
    required this.id,
  });
}

List<Type> products = [
  Type(
    id: 1,
    name: "Raffle",
    description: " ",
  ),
  Type(
    id: 2,
    name: "Box",
    description: " ",
  ),
];

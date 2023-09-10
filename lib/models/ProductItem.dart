import 'dart:ffi';

import 'package:flutter/material.dart';

class ProductItem {
  final Object obj;
  final String image, name, type, description, externalId;
  final Long price;
  final int id;
  final List<String> colors;

  ProductItem(
      {required this.obj,
      required this.image,
      required this.name,
      required this.type,
      required this.price,
      required this.description,
      required this.externalId,
      required this.id,
      required this.colors});
}

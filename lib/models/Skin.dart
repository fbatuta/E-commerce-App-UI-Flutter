import 'package:flutter/material.dart';

class Skin {
  final String name;
  final String exterior;
  final String type;
  final double price;
  final String steamId;
  final int id;
  final Color backgroundColor;
  final List<String> images;
  final List<String> colors;

  Skin(
      {required this.name,
      required this.exterior,
      required this.type,
      required this.price,
      required this.steamId,
      required this.id,
      required this.backgroundColor,
      required this.images,
      required this.colors});
}

import 'package:flutter/material.dart';

class ItemModel {
  final String name;
  final String img;
  final String value;
  bool accepting;
  final Color color;
  ItemModel({
    required this.name,
    required this.value,
    required this.img,
    this.accepting = false,
    required this.color,
  });
}

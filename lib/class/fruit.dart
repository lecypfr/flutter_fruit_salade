import 'package:flutter/material.dart';
import 'package:tp_fruit/class/country.dart';

class Fruit {
  String name;
  Color color;
  double price;
  String image;
  String season;
  int stock;
  Country origin;

  Fruit(
      {required this.name,
      required this.color,
      required this.price,
      required this.image,
      required this.season,
      required this.stock,
      required this.origin});

  factory Fruit.fromJson(Map<String, dynamic> json) {
    return Fruit(
      name: json['name'],
      color: Color(
          int.parse(json['color'].substring(1, 7), radix: 16) + 0xFF000000),
      price: json['price'],
      image: json['image'],
      season: json['season'],
      stock: json['stock'],
      origin: Country.fromJson(json['origin']),
    );
  }
}

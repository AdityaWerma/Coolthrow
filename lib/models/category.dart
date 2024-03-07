import 'package:flutter/material.dart';

class Category {
  const Category({
    required this.id,
    required this.title,
    required this.imageAddress,
    this.color = Colors.white10,
  });

  final String id;
  final String title;
  final String imageAddress;
  final Color color;
}

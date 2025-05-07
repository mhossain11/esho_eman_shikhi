import 'package:flutter/material.dart';

class TextModel {
  final String title;
  final String arabic_title;
  final bool show;
  final String translation;
  final String description;
  final String reference;
  final bool referenceShow;

  TextModel({
    required this.title,
    required this.arabic_title,
    this.show = true,
    required this.translation,
    required this.description,
    required this.reference,
     this.referenceShow= true,
  });
}



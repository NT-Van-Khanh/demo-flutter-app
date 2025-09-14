import 'package:flutter/cupertino.dart';

class PageItem{
  final String title;
  final IconData icon;
  final String route;
  PageItem({required this.title, required this.icon, this.route = 'empty',});
}
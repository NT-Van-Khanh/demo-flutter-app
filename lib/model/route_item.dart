import 'package:b1_first_flutter_app/ui/page/empty_page.dart';
import 'package:flutter/material.dart';

class RouteItem {
  final String title;
  final String route;
  final IconData? icon;
  final Widget widget;
  RouteItem({
    required this.title, 
    this.route = "/empty",
    this.icon, 
    this.widget = const EmptyPage(),
  });
}
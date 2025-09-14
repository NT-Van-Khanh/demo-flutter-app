import 'package:b1_first_flutter_app/ui/page/empty_page.dart';
import 'package:flutter/material.dart';
class SettingItem {
  final String title;
  final IconData icon;
  final Widget widget;
  SettingItem({required this.title, required this.icon, this.widget = const EmptyPage(),});
}
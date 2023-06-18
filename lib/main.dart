import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Screen/home_page.dart';

void main() {
  runApp(GetMaterialApp(
    title: 'To-Do List',
    theme: ThemeData(primarySwatch: Colors.blue),
    home: HomePage(),
  ));
}

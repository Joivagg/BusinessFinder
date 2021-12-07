import 'package:businessfinder/view/home_view.dart';
import 'package:flutter/material.dart';
import 'controller/store_dao.dart';

void main() {
  StoresDAO.addStoresFromServer().then((value) {
    runApp(const HomeView());
  });
  //runApp(const HomeView() /*const ScrollInfinito()*/);
}
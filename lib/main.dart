import 'package:businessfinder/view/home_view.dart';
import 'package:flutter/material.dart';
import 'controller/store_dao.dart';
import 'controller/client_dao.dart';

void main() {
  StoresDAO.addStoresFromServer().then((value) {
    ClientDAO.addClientFromServer();
    runApp(const HomeView());
  });
  //runApp(const HomeView() /*const ScrollInfinito()*/);
}
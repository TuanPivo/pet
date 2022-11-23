import 'package:flutter/cupertino.dart';

enum MenuType {
  Home,
  Products,
  Profile,
  Cart,
  Bill,
  Details,
  DetailNews,
  DetailBil,
  Favourite,
  Payment,
  Product,
  Reviews
}

class NavigationProvider with ChangeNotifier {
  late MenuType menuType;
  late String? title;
  late String? imageSource;
  NavigationProvider(this.menuType, {this.title, this.imageSource});
  updateMenu(NavigationProvider menuInfo) {
    this.menuType = menuInfo.menuType;
    this.title = menuInfo.title;
    this.imageSource = menuInfo.imageSource;

    notifyListeners();
  }
}

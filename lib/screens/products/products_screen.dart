// ignore_for_file: prefer_const_constructors

import 'package:apporder/components/menu_dashboard_layout.dart';
import 'package:apporder/data/data.dart';
import 'package:apporder/provider/navigation_provider.dart';
import 'package:apporder/responsive/responsive_screen.dart';
import 'package:apporder/screens/products/components/body.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatefulWidget {
  final Function()? onMenuTap;
  const ProductsScreen({Key? key, this.onMenuTap}) : super(key: key);
  static String routeName = "/products";
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  GlobalKey<ScaffoldState> keys = GlobalKey<ScaffoldState>();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Responsive(
      desktop: Body(keys: keys),
      tablet: widget.onMenuTap == null
          ? MenuDashboardLayout(menuI: NavigationProvider(MenuType.Products,
        title: 'Products', imageSource: 'assets/timer_icon.png'))
          : Body(keys: keys, onMenuTap: widget.onMenuTap),
      mobile: widget.onMenuTap == null
          ? MenuDashboardLayout(menuI: NavigationProvider(MenuType.Products,
        title: 'Products', imageSource: 'assets/timer_icon.png'))
          : Body(keys: keys, onMenuTap: widget.onMenuTap),
      keys: keys,
    );
  }
}

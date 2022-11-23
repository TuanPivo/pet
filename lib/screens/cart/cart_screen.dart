// ignore_for_file: prefer_const_constructors

import 'package:apporder/components/menu_dashboard_layout.dart';
import 'package:apporder/data/data.dart';
import 'package:apporder/provider/navigation_provider.dart';
import 'package:apporder/responsive/responsive_screen.dart';
import 'package:apporder/screens/cart/components/body.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  final Function()? onMenuTap;
  const CartScreen({Key? key, this.onMenuTap}) : super(key: key);
  static String routeName = "/cart";
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  GlobalKey<ScaffoldState> keys = GlobalKey<ScaffoldState>();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Responsive(
      desktop: Body(
        keys: keys,
        onMenuTap: widget.onMenuTap,
      ),
      tablet: widget.onMenuTap == null
          ? MenuDashboardLayout(menuI: NavigationProvider(MenuType.Cart,
        title: 'Cart', imageSource: 'assets/alarm_icon.png'))
          : Body(keys: keys, onMenuTap: widget.onMenuTap),
      mobile: widget.onMenuTap == null
          ? MenuDashboardLayout(menuI: NavigationProvider(MenuType.Cart,
        title: 'Cart', imageSource: 'assets/alarm_icon.png'))
          : Body(keys: keys, onMenuTap: widget.onMenuTap),
      keys: keys,
    );
  }
}

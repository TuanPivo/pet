// ignore_for_file: unused_local_variable, prefer_const_constructors

import 'dart:async';

import 'package:apporder/components/menu_dashboard_layout.dart';
import 'package:apporder/models/product.dart';
import 'package:apporder/models/screenarguments.dart';
import 'package:apporder/provider/navigation_provider.dart';
import 'package:apporder/responsive/responsive_screen.dart';
import 'package:apporder/routes.dart';
import 'package:apporder/screens/homes/homes_screen.dart';
import 'package:apporder/screens/product/components/body.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  final Function()? onMenuTap;
  const ProductScreen({Key? key, this.onMenuTap}) : super(key: key);
  static String routeName = "/product";
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  GlobalKey<ScaffoldState> keys = GlobalKey<ScaffoldState>();
  @override
  void dispose() {
    super.dispose();
  }

  List<Product> snapshot = [];
  String name = '';

  Future<void> getName(context) async {
    try {
      final args =
          ModalRoute.of(context)!.settings.arguments as ScreenArguments;
      snapshot = args.snapshot;
      name = args.name;
    } catch (e) {
      Timer.run(() {
        FluroRouters.router
            .navigateTo(context, HomesScreen.routeName, replace: true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    getName(context);
    return Responsive(
      desktop: Body(snapshot: snapshot, name: name, keys: keys),
      tablet: widget.onMenuTap == null
          ? MenuDashboardLayout(menuI: NavigationProvider(MenuType.Product,
        title: 'Product', imageSource: 'assets/timer_icon.png'))
          : Body(
              snapshot: snapshot,
              name: name,
              keys: keys,
              onMenuTap: widget.onMenuTap),
      mobile: widget.onMenuTap == null
          ? MenuDashboardLayout(menuI: NavigationProvider(MenuType.Product,
        title: 'Product', imageSource: 'assets/timer_icon.png'))
          : Body(
              snapshot: snapshot,
              name: name,
              keys: keys,
              onMenuTap: widget.onMenuTap),
      keys: keys,
    );
  }
}

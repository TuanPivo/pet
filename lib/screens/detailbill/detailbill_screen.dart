// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:apporder/components/menu_dashboard_layout.dart';
import 'package:apporder/data/data.dart';
import 'package:apporder/models/cart.dart';
import 'package:apporder/models/screenarguments.dart';
import 'package:apporder/provider/navigation_provider.dart';
import 'package:apporder/responsive/responsive_screen.dart';
import 'package:apporder/routes.dart';
import 'package:apporder/screens/detailbill/components/body.dart';
import 'package:apporder/screens/login_signup/loginsignup_page.dart';
import 'package:flutter/material.dart';

class DetailbillScreen extends StatefulWidget {
  final Function()? onMenuTap;
  const DetailbillScreen({Key? key, this.onMenuTap}) : super(key: key);
  static String routeName = "/detailbill";
  @override
  _DetailbillScreenState createState() => _DetailbillScreenState();
}

class _DetailbillScreenState extends State<DetailbillScreen> {
  GlobalKey<ScaffoldState> keys = GlobalKey<ScaffoldState>();

  List<CartModel> snapshot = [];
  String codebill = '';
  String name = '';
  String phone = '';
  String address = '';
  Future<void> getName(context) async {
    try {
      final args =
          ModalRoute.of(context)!.settings.arguments as DetailbillArguments;
      snapshot = args.snapshot;
      codebill = args.codebill;
      name = args.name;
      phone = args.phone;
      address = args.address;
    } catch (e) {
      Timer.run(() {
        FluroRouters.router
            .navigateTo(context, LoginSignupScreen.routeName, replace: true);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getName(context);
    return Responsive(
      desktop: Body(
          snapshot: snapshot,
          codebill: codebill,
          name: name,
          phone: phone,
          address: address,
          keys: keys),
      tablet: widget.onMenuTap == null
          ? MenuDashboardLayout(menuI: NavigationProvider(MenuType.DetailBil,
        title: 'DetailBill', imageSource: 'assets/timer_icon.png'))
          : Body(
              snapshot: snapshot,
              codebill: codebill,
              name: name,
              phone: phone,
              address: address,
              keys: keys,
              onMenuTap: widget.onMenuTap),
      mobile: widget.onMenuTap == null
          ? MenuDashboardLayout(menuI: NavigationProvider(MenuType.DetailBil,
        title: 'DetailBill', imageSource: 'assets/timer_icon.png'))
          : Body(
              snapshot: snapshot,
              codebill: codebill,
              name: name,
              phone: phone,
              address: address,
              keys: keys,
              onMenuTap: widget.onMenuTap),
      keys: keys,
    );
  }
}

// ignore_for_file: unused_local_variable, prefer_const_constructors, curly_braces_in_flow_control_structures

import 'dart:async';

import 'package:apporder/components/menu_dashboard_layout.dart';
import 'package:apporder/data/data.dart';
import 'package:apporder/models/product.dart';
import 'package:apporder/models/screenarguments.dart';
import 'package:apporder/provider/navigation_provider.dart';
import 'package:apporder/responsive/responsive_screen.dart';
import 'package:apporder/routes.dart';
import 'package:apporder/screens/homes/homes_screen.dart';
import 'package:apporder/screens/reviews/components/body.dart';
import 'package:flutter/material.dart';

class ReviewsScreen extends StatefulWidget {
  final Function()? onMenuTap;

  const ReviewsScreen({Key? key, this.onMenuTap}) : super(key: key);
  static String routeName = "/reviews";

  @override
  _ReviewsScreenState createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  GlobalKey<ScaffoldState> keys = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    super.dispose();
  }

  bool check = true;
  var snapshot = Product(
    image: [],
    name: '',
    price: 0,
    numlike: 0,
    like: 0,
    content: '',
    id: '',
    catoname: '',
    avg: [],
  );

  Future<void> getName(context) async {
    try {
      final args =
          ModalRoute.of(context)!.settings.arguments as ReviewsArguments;
      snapshot = args.snapshot;
    } catch (e) {
      check = false;
      Timer.run(() {
        FluroRouters.router
            .navigateTo(context, HomesScreen.routeName, replace: true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    getName(context);
    if (check) {
      return Responsive(
        desktop: Body(snapshot: snapshot, keys: keys),
        tablet: widget.onMenuTap == null
            ? MenuDashboardLayout(
                menuI: NavigationProvider(MenuType.Reviews,
                    title: 'Reviews', imageSource: 'assets/timer_icon.png'))
            : Body(snapshot: snapshot, keys: keys, onMenuTap: widget.onMenuTap),
        mobile: widget.onMenuTap == null
            ? MenuDashboardLayout(
                menuI: NavigationProvider(MenuType.Reviews,
                    title: 'Reviews', imageSource: 'assets/timer_icon.png'))
            : Body(snapshot: snapshot, keys: keys, onMenuTap: widget.onMenuTap),
        keys: keys,
      );
    } else
      return Responsive(
        desktop: Container(),
        tablet: widget.onMenuTap == null
            ? MenuDashboardLayout(
                menuI: NavigationProvider(MenuType.Reviews,
                    title: 'Reviews', imageSource: 'assets/timer_icon.png'))
            : Container(),
        mobile: widget.onMenuTap == null
            ? MenuDashboardLayout(
                menuI: NavigationProvider(MenuType.Reviews,
                    title: 'Reviews', imageSource: 'assets/timer_icon.png'))
            : Container(),
        keys: keys,
      );
  }
}

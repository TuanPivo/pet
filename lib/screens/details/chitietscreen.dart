import 'dart:async';

import 'package:apporder/components/menu_dashboard_layout.dart';
import 'package:apporder/models/product.dart';
import 'package:apporder/models/screenarguments.dart';
import 'package:apporder/provider/navigation_provider.dart';
import 'package:apporder/responsive/responsive_screen.dart';
import 'package:apporder/routes.dart';
import 'package:apporder/screens/details/components/body.dart';
import 'package:apporder/screens/homes/homes_screen.dart';
import 'package:flutter/material.dart';

class ChitietScreen extends StatefulWidget {
  final Function()? onMenuTap;

  const ChitietScreen({Key? key, this.onMenuTap}) : super(key: key);
  static String routeName = "/details";

  @override
  _ChitietScreenState createState() => _ChitietScreenState();
}

class _ChitietScreenState extends State<ChitietScreen> {
  GlobalKey<ScaffoldState> keys = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    super.dispose();
  }

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
          ModalRoute.of(context)!.settings.arguments as DetailArguments;
      snapshot = args.snapshot;
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
      desktop: Body(snapshot: snapshot, keys: keys),
      tablet: widget.onMenuTap == null
          ? MenuDashboardLayout(
              menuI: NavigationProvider(MenuType.Details,
                  title: 'Details', imageSource: 'assets/timer_icon.png'))
          : Body(snapshot: snapshot, keys: keys, onMenuTap: widget.onMenuTap),
      mobile: widget.onMenuTap == null
          ? MenuDashboardLayout(
              menuI: NavigationProvider(MenuType.Details,
                  title: 'Details', imageSource: 'assets/timer_icon.png'))
          : Body(snapshot: snapshot, keys: keys, onMenuTap: widget.onMenuTap),
      keys: keys,
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:apporder/components/menu_dashboard_layout.dart';
import 'package:apporder/data/data.dart';
import 'package:apporder/provider/navigation_provider.dart';
import 'package:apporder/responsive/responsive_screen.dart';
import 'package:apporder/screens/bill/components/body.dart';
import 'package:flutter/material.dart';

class BillScreen extends StatefulWidget {
  final Function()? onMenuTap;
  const BillScreen({Key? key, this.onMenuTap}) : super(key: key);
  static String routeName = "/bill";
  @override
  _BillScreenState createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {
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
          ? MenuDashboardLayout(menuI: NavigationProvider(MenuType.Bill,
        title: 'Bill', imageSource: 'assets/timer_icon.png'))
          : Body(keys: keys, onMenuTap: widget.onMenuTap),
      mobile: widget.onMenuTap == null
          ? MenuDashboardLayout(menuI: NavigationProvider(MenuType.Bill,
        title: 'Bill', imageSource: 'assets/timer_icon.png'))
          : Body(keys: keys, onMenuTap: widget.onMenuTap),
      keys: keys,
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:apporder/components/menu_dashboard_layout.dart';
import 'package:apporder/data/data.dart';
import 'package:apporder/provider/navigation_provider.dart';
import 'package:apporder/responsive/responsive_screen.dart';
import 'package:apporder/screens/homes/components/body.dart';
import 'package:flutter/material.dart';

class HomesScreen extends StatefulWidget {
  final Function()? onMenuTap;
  const HomesScreen({Key? key, this.onMenuTap}) : super(key: key);
  static String routeName = "/homes";

  @override
  _HomesScreenState createState() => _HomesScreenState();
}

class _HomesScreenState extends State<HomesScreen> {
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
          ? MenuDashboardLayout(menuI: NavigationProvider(MenuType.Home,
        title: 'Home', imageSource: 'assets/clock_icon.png'))
          : Body(keys: keys, onMenuTap: widget.onMenuTap),
      mobile: widget.onMenuTap == null
          ? MenuDashboardLayout(menuI: NavigationProvider(MenuType.Home,
        title: 'Home', imageSource: 'assets/clock_icon.png'))
          : Body(keys: keys, onMenuTap: widget.onMenuTap),
      keys: keys,
    );
  }
}

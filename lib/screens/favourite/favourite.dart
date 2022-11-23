// ignore_for_file: prefer_const_constructors

import 'package:apporder/components/menu_dashboard_layout.dart';
import 'package:apporder/provider/navigation_provider.dart';
import 'package:apporder/responsive/responsive_screen.dart';
import 'package:apporder/screens/favourite/components/body.dart';
import 'package:flutter/material.dart';

class FavouriteScreen extends StatefulWidget {
  final Function()? onMenuTap;
  const FavouriteScreen({Key? key, this.onMenuTap}) : super(key: key);
  static String routeName = "/favourite";

  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
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
          ? MenuDashboardLayout(menuI: NavigationProvider(MenuType.Favourite,
        title: 'Favourite', imageSource: 'assets/timer_icon.png'))
          : Body(keys: keys, onMenuTap: widget.onMenuTap),
      mobile: widget.onMenuTap == null
          ? MenuDashboardLayout(menuI: NavigationProvider(MenuType.Favourite,
        title: 'Favourite', imageSource: 'assets/timer_icon.png'))
          : Body(keys: keys, onMenuTap: widget.onMenuTap),
      keys: keys,
    );
  }
}

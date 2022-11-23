// ignore_for_file: unused_local_variable, prefer_const_constructors

import 'package:apporder/components/menu_dashboard_layout.dart';
import 'package:apporder/data/data.dart';
import 'package:apporder/provider/navigation_provider.dart';
import 'package:apporder/responsive/responsive_screen.dart';
import 'package:apporder/screens/profile/components/body.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final Function()? onMenuTap;
  const ProfileScreen({Key? key, this.onMenuTap}) : super(key: key);
  static String routeName = "/profile";

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
          ? MenuDashboardLayout(menuI: NavigationProvider(MenuType.Profile,
        title: 'Profile', imageSource: 'assets/timer_icon.png'))
          : Body(keys: keys, onMenuTap: widget.onMenuTap),
      mobile: widget.onMenuTap == null
          ? MenuDashboardLayout(menuI: NavigationProvider(MenuType.Profile,
        title: 'Profile', imageSource: 'assets/timer_icon.png'))
          : Body(keys: keys, onMenuTap: widget.onMenuTap),
      keys: keys,
    );
  }
}

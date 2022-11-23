import 'dart:async';

import 'package:apporder/components/menu_dashboard_layout.dart';
import 'package:apporder/data/data.dart';
import 'package:apporder/models/news.dart';
import 'package:apporder/models/screenarguments.dart';
import 'package:apporder/provider/navigation_provider.dart';
import 'package:apporder/responsive/responsive_screen.dart';
import 'package:apporder/routes.dart';
import 'package:apporder/screens/detailnews/components/body.dart';
import 'package:apporder/screens/homes/homes_screen.dart';
import 'package:flutter/material.dart';

class DetailnewsScreen extends StatefulWidget {
  final Function()? onMenuTap;
  const DetailnewsScreen({Key? key, this.onMenuTap}) : super(key: key);
  static String routeName = "/detailnews";
  @override
  _DetailnewsScreenState createState() => _DetailnewsScreenState();
}

class _DetailnewsScreenState extends State<DetailnewsScreen> {
  GlobalKey<ScaffoldState> keys = GlobalKey<ScaffoldState>();
  @override
  void dispose() {
    super.dispose();
  }

  var snapshot = News(
      contents: '', image: '', star: 0, hlihgts: 0, hot: 0, id: '', title: '');

  Future<void> getName(context) async {
    try {
      final args =
          ModalRoute.of(context)!.settings.arguments as DetailnewsArguments;
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
      tablet: widget.onMenuTap == null ? MenuDashboardLayout(menuI: NavigationProvider(MenuType.DetailNews,
        title: 'DetailNews', imageSource: 'assets/timer_icon.png')) : Body(snapshot: snapshot, keys: keys,onMenuTap: widget.onMenuTap),
      mobile: widget.onMenuTap == null ? MenuDashboardLayout(menuI: NavigationProvider(MenuType.DetailNews,
        title: 'DetailNews', imageSource: 'assets/timer_icon.png')) : Body(snapshot: snapshot, keys: keys,onMenuTap: widget.onMenuTap),
      keys: keys,
    );
  }
}

import 'package:apporder/components/dashboard.dart';
import 'package:apporder/provider/navigation_provider.dart';
import 'package:apporder/routes.dart';
import 'package:apporder/screens/bill/bill_screen.dart';
import 'package:apporder/screens/cart/cart_screen.dart';
import 'package:apporder/screens/detailbill/detailbill_screen.dart';
import 'package:apporder/screens/detailnews/detailnews_screen.dart';
import 'package:apporder/screens/details/chitietscreen.dart';
import 'package:apporder/screens/favourite/favourite.dart';
import 'package:apporder/screens/homes/homes_screen.dart';
import 'package:apporder/screens/login_signup/loginsignup_page.dart';
import 'package:apporder/screens/payment/payment.dart';
import 'package:apporder/screens/product/product_screend.dart';
import 'package:apporder/screens/products/products_screen.dart';
import 'package:apporder/screens/profile/profile_screen.dart';
import 'package:apporder/screens/reviews/reviews_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Color backgroundColor = Color(0xFF4A4A58);

class MenuDashboardLayout extends StatefulWidget {
  static String routeName = "/test";
  final NavigationProvider menuI;
  const MenuDashboardLayout({Key? key, required this.menuI}) : super(key: key);
  @override
  _MenuDashboardLayoutState createState() => _MenuDashboardLayoutState();
}

class _MenuDashboardLayoutState extends State<MenuDashboardLayout>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  late double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _menuScaleAnimation;
  late Animation<Offset> _slideAnimation;
  List<NavigationProvider> menuItemsp = [
    NavigationProvider(MenuType.Home,
        title: 'Home', imageSource: 'assets/clock_icon.png'),
    NavigationProvider(MenuType.Products,
        title: 'Products', imageSource: 'assets/timer_icon.png'),
    NavigationProvider(MenuType.Profile,
        title: 'Profile', imageSource: 'assets/timer_icon.png'),
    NavigationProvider(MenuType.Cart,
        title: 'Cart', imageSource: 'assets/alarm_icon.png'),
    NavigationProvider(MenuType.Bill,
        title: 'Bill', imageSource: 'assets/timer_icon.png'),
  ];
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onMenuTap() {
    setState(() {
      if (isCollapsed)
        _controller.forward();
      else
        _controller.reverse();

      isCollapsed = !isCollapsed;
    });
  }

  void onMenuItemClicked() {
    setState(() {
      _controller.reverse();
    });

    isCollapsed = !isCollapsed;
  }

  Future deleteShareprefence() async {
    FirebaseAuth.instance.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("avt");
    await prefs.remove("uid");
    await prefs.remove("cart");
    await prefs.remove("count");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: ChangeNotifierProvider<NavigationProvider>.value(
        value: widget.menuI,
        child: Stack(
          children: <Widget>[
            SlideTransition(
              position: _slideAnimation,
              child: ScaleTransition(
                scale: _menuScaleAnimation,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: menuItemsp
                                .map((currentMenuInfo) =>
                                    buildButtonMenu(currentMenuInfo))
                                .toList(),
                          ),
                          FirebaseAuth.instance.currentUser == null
                              ? Container()
                              : ListTile(
                                  onTap: () {
                                    deleteShareprefence();
                                    FluroRouters.router.navigateTo(
                                      context,
                                      LoginSignupScreen.routeName,
                                      replace: true,
                                    );
                                  },
                                  leading: const Icon(Icons.exit_to_app),
                                  title: const Text("Logout"),
                                ),
                        ],
                      )),
                ),
              ),
            ),
            Consumer<NavigationProvider>(builder: (context, value, child) {
              return Dashboard(
                duration: duration,
                scaleAnimation: _scaleAnimation,
                isCollapsed: isCollapsed,
                screenWidth: screenWidth,
                child: value.menuType == MenuType.Home
                    ? HomesScreen(onMenuTap: onMenuTap)
                    : value.menuType == MenuType.Products
                        ? ProductsScreen(onMenuTap: onMenuTap)
                        : value.menuType == MenuType.Profile
                            ? ProfileScreen(onMenuTap: onMenuTap)
                            : value.menuType == MenuType.Cart
                                ? CartScreen(onMenuTap: onMenuTap)
                                : value.menuType == MenuType.Bill
                                    ? BillScreen(onMenuTap: onMenuTap)
                                    : value.menuType == MenuType.Details
                                        ? ChitietScreen(onMenuTap: onMenuTap)
                                        : value.menuType == MenuType.DetailNews
                                            ? DetailnewsScreen(
                                                onMenuTap: onMenuTap)
                                            : value.menuType ==
                                                    MenuType.DetailBil
                                                ? DetailbillScreen(
                                                    onMenuTap: onMenuTap)
                                                : value.menuType ==
                                                        MenuType.Favourite
                                                    ? FavouriteScreen(
                                                        onMenuTap: onMenuTap)
                                                    : value.menuType ==
                                                            MenuType.Payment
                                                        ? PaymentScreen(
                                                            onMenuTap:
                                                                onMenuTap)
                                                        : value.menuType ==
                                                                MenuType.Product
                                                            ? ProductScreen(
                                                                onMenuTap:
                                                                    onMenuTap)
                                                            : value.menuType ==
                                                                    MenuType
                                                                        .Reviews
                                                                ? ReviewsScreen(
                                                                    onMenuTap:
                                                                        onMenuTap)
                                                                : HomesScreen(
                                                                    onMenuTap:
                                                                        onMenuTap),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget buildButtonMenu(NavigationProvider currentMenuInfo) {
    return Consumer<NavigationProvider>(builder: (context, value, child) {
      return Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: GestureDetector(
          onTap: () {
            setState(() {
              value.updateMenu(currentMenuInfo);
              onMenuItemClicked();
            });
          },
          child: Text(
            currentMenuInfo.title.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: value.menuType == currentMenuInfo.menuType
                  ? FontWeight.w900
                  : FontWeight.normal,
            ),
          ),
        ),
      );
    });
  }
}

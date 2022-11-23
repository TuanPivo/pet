// ignore: unused_import
// ignore_for_file: prefer_const_constructors, deprecated_member_use

// ignore: unused_import
import 'package:apporder/components/menu_dashboard_layout.dart';
import 'package:apporder/data/data.dart';
import 'package:apporder/provider/navigation_provider.dart';
import 'package:apporder/provider/product_provider.dart';
import 'package:apporder/provider/cart_provider.dart';
import 'package:apporder/routes.dart';
import 'package:apporder/screens/splash/splash_screen.dart';
import 'package:apporder/test/testmenu.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // Replace with actual values
    options: FirebaseOptions(
      apiKey: "AIzaSyCjW9_WVqtMNAQDq-RtTW1-g-ygsFwx1d4",
      appId: "1:1085513025274:web:25a28f510d47f0f3f9eb43",
      messagingSenderId: "1085513025274",
      projectId: "pet-shop-41a0f",
    ),
  );
  setPathUrlStrategy();
  FluroRouters.setupRouter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  final bool ischeckauth = true;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductProvider>(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider<CartProvider>(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider<NavigationProvider>(
          create: (context) => menuItems.elementAt(0),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Pet Shop',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.orange,
          accentColor: Color(0xFFFEF9EB),
        ),
        initialRoute: SplashScreen.routeName,
        onGenerateRoute: FluroRouters.router.generator,
      ),
    );
  }
}

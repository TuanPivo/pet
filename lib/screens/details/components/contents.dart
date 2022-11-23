// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, curly_braces_in_flow_control_structures, unused_field, avoid_function_literals_in_foreach_calls, prefer_is_empty, avoid_unnecessary_containers

import 'dart:convert';
import 'dart:ui';

import 'package:apporder/models/cart.dart';
import 'package:apporder/models/news.dart';
import 'package:apporder/models/product.dart';
import 'package:apporder/models/screenarguments.dart';
import 'package:apporder/provider/product_provider.dart';
import 'package:apporder/provider/cart_provider.dart';
import 'package:apporder/responsive/responsive_screen.dart';
import 'package:apporder/routes.dart';
import 'package:apporder/screens/cart/cart_screen.dart';
import 'package:apporder/screens/details/chitietscreen.dart';
import 'package:apporder/screens/login_signup/loginsignup_page.dart';
import 'package:apporder/screens/product/product_screend.dart';
import 'package:apporder/screens/products/products_screen.dart';
import 'package:apporder/screens/reviews/reviews_screen.dart';
import 'package:apporder/utils/url.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Contents extends StatefulWidget {
  final Product? snapshot;

  const Contents({Key? key, this.snapshot}) : super(key: key);

  @override
  _ContentsState createState() => _ContentsState();
}

late ProductProvider productProvider;
late CartProvider testdata;

class _ContentsState extends State<Contents> {
  Map<String, dynamic> data1 = {};
  List<int> check = [-1];
  List _isSelected = [];
  int count = 1;
  final CarouselController _controller = CarouselController();
  DocumentReference<Map<String, dynamic>>? newsRef;
  int _current = 0;
  String _uid = '';
  late List<String> images = [];
  late SharedPreferences prefs;
  String _recommender = '';

  Future settingSharepre() async {
    return await SharedPreferences.getInstance();
  }

  Future<String> getList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('cart') ?? '';
  }

  List<CartModel> ty = [];
  bool checkcart = true;

  Future<void> setcardShare(Product product) async {
    getList().then((value) => {
          if (value.isNotEmpty)
            {
              ty = (json.decode(value) as List<dynamic>)
                  .map<CartModel>((item) => CartModel.fromJson(item))
                  .toList(),
              if (ty.isNotEmpty)
                {
                  ty.forEach((element) {
                    if (element.id == product.id) {
                      element.quantity += count;
                      element.size = size;
                      checkcart = false;
                    }
                  }),
                  if (checkcart)
                    {
                      ty.add(CartModel(
                        image: product.image.elementAt(0),
                        id: product.id,
                        size: size,
                        name: product.name,
                        price: product.price,
                        quantity: count,
                      ))
                    }
                }
              else
                {
                  ty.add(CartModel(
                    image: product.image.elementAt(0),
                    id: product.id,
                    size: size,
                    name: product.name,
                    price: product.price,
                    quantity: count,
                  ))
                },
              if (ty.isNotEmpty)
                {
                  settingSharepre().then(
                    (value) => {
                      prefs = value,
                      prefs.setString('cart', CartModel.encode(ty)),
                    },
                  )
                }
            }
          else
            {
              ty.add(CartModel(
                image: product.image.elementAt(0),
                id: product.id,
                size: size,
                name: product.name,
                price: product.price,
                quantity: count,
              )),
              if (ty.isNotEmpty)
                {
                  settingSharepre().then(
                    (value) => {
                      prefs = value,
                      prefs.setString('cart', CartModel.encode(ty)),
                    },
                  )
                }
            }
        });
  }

  Future<String> fetchAlbum(String id) async {
    try {
      final responses = await http
          .post(Uri.parse(url), body: {'idproduct': widget.snapshot!.id});
      return responses.body;
    } on Exception catch (_) {
      return '';
    }
  }

  void recommend(recommnender) {
    setState(() {
      _recommender = recommnender;
    });
  }

  @override
  void initState() {
    fetchAlbum(widget.snapshot!.id).then(recommend);
    ProductProvider initproductProvider =
        Provider.of<ProductProvider>(context, listen: false);
    getCallAllFunction(initproductProvider);
    getCurrentUserUid().then(updateUid);
    if (widget.snapshot!.image.isNotEmpty &&
        widget.snapshot!.image.length >= 1) {
      _isSelected = List.filled(widget.snapshot!.image.length, false);
      images = widget.snapshot!.image;
    }
    getCurrentUserUid().then((value) => {
          if (value.isNotEmpty || FirebaseAuth.instance.currentUser != null)
            {
              newsRef = FirebaseFirestore.instance
                  .collection("User")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection("new")
                  .doc("listnews")
            }
        });

    super.initState();
    getCurrentUserUid().then((value) => {
          if (value.isNotEmpty || FirebaseAuth.instance.currentUser != null)
            {
              newsRef!.get().then((value) => {
                    if (value.data()!.isNotEmpty)
                      data1 = value.data() as Map<String, dynamic>
                  })
            }
        });
  }

  void updateUid(String uid) {
    setState(() {
      _uid = uid;
    });
  }

  Future<String> getCurrentUserUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('uid') ?? '';
  }

  void getCallAllFunction(ProductProvider initproductProvider) {
    initproductProvider.getDogData();
    initproductProvider.getCatData();
    initproductProvider.getAccessoriesData();
    // initproductProvider.getSnackData();
    // initproductProvider.getVegesData();
    initproductProvider.getLikeData();
  }

  int seletedIndex = 0;

  List<Map<String, String>> menuData = [
    {"text": "Dog", "icon": "images/icon_dog2.png", "name": "Dog"},
    {"text": "Cat", "icon": "images/icon_cat.png", "name": "Cat"},
    {"text": "Accessory", "icon": "images/icon_dog1.png", "name": "Accessory"},
    // {"text": "Dessert", "icon": "images/mouse.png", "name": "Mouse"},
    // {"text": "Snack", "icon": "images/phone.png", "name": "Phone"},
  ];

  List<bool> sized = [true, false, false, false];
  int sizeIndex = 0;
  String size = 'R';

  void getSize() {
    if (sizeIndex == 0) {
      setState(() {
        size = "R";
      });
    } else if (sizeIndex == 1) {
      setState(() {
        size = "B";
      });
    } else if (sizeIndex == 2) {
      setState(() {
        size = "G";
      });
    } else if (sizeIndex == 3) {
      setState(() {
        size = "O";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    testdata = Provider.of<CartProvider>(context, listen: false);
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Responsive.isDesktop(context) ? 140.0 : 0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Responsive.isDesktop(context)
              ? Container()
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Explore Catagories",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22.0,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                FluroRouters.router.navigateTo(
                                    context, ProductsScreen.routeName,
                                    replace: true);
                              },
                              child: Text(
                                "See All",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: menuData.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => {
                                setState(
                                  () => {
                                    seletedIndex = index,
                                    if (menuData[index]['text'] == "Dog")
                                      FluroRouters.router.navigateTo(
                                          context, ProductScreen.routeName,
                                          routeSettings: RouteSettings(
                                              arguments: ScreenArguments(
                                                  name: "Cog",
                                                  snapshot: productProvider
                                                      .getdogList)),
                                          replace: true),
                                    if (menuData[index]['text'] ==
                                        "Accessory")
                                      FluroRouters.router.navigateTo(
                                          context, ProductScreen.routeName,
                                          routeSettings: RouteSettings(
                                              arguments: ScreenArguments(
                                                  name: "Accessory",
                                                  snapshot: productProvider
                                                      .getaccessoriesList)),
                                          replace: true),
                                    // if (menuData[index]['text'] == "Veges")
                                    //   FluroRouters.router.navigateTo(
                                    //       context, ProductScreen.routeName,
                                    //       routeSettings: RouteSettings(
                                    //           arguments: ScreenArguments(
                                    //               name: "Veges",
                                    //               snapshot: productProvider
                                    //                   .getvegesList)),
                                    //       replace: true),
                                    // if (menuData[index]['text'] == "Snack")
                                    //   FluroRouters.router.navigateTo(
                                    //       context, ProductScreen.routeName,
                                    //       routeSettings: RouteSettings(
                                    //           arguments: ScreenArguments(
                                    //               name: "Snack",
                                    //               snapshot: productProvider
                                    //                   .getsnackList)),
                                    //       replace: true),
                                    if (menuData[index]['text'] == "Cat")
                                      FluroRouters.router.navigateTo(
                                          context, ProductScreen.routeName,
                                          routeSettings: RouteSettings(
                                              arguments: ScreenArguments(
                                                  name: "Cat",
                                                  snapshot: productProvider
                                                      .getcatList)),
                                          replace: true),
                                  },
                                ),
                              },
                              child: Padding(
                                padding: EdgeInsets.only(right: 15.0),
                                child: SizedBox(
                                  width: 80,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: listMenu(
                                        Responsive.getSize(context),
                                        menuData[index]['icon'],
                                        seletedIndex == index,
                                        menuData[index]['name']),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
          Container(
            height: Responsive.isDesktop(context)
                ? 1850
                : Responsive.isTablet(context)
                    ? 1200
                    : 1400,
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              children: [
                Responsive.isDesktop(context)
                    ? Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              width: Responsive.getSize(context).width,
                              height: 50,
                              color: Colors.black38,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Menu"),
                                  InkWell(
                                      onTap: () {
                                        FluroRouters.router.navigateTo(
                                          context,
                                          ProductsScreen.routeName,
                                          replace: true,
                                        );
                                      },
                                      child: Icon(MdiIcons.menu))
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 406,
                              child: ListView.builder(
                                itemCount: menuData.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () => {
                                      setState(
                                        () => {
                                          seletedIndex = index,
                                          if (menuData[index]['text'] == "Dog")
                                            FluroRouters.router.navigateTo(
                                                context,
                                                ProductScreen.routeName,
                                                routeSettings: RouteSettings(
                                                    arguments: ScreenArguments(
                                                        name: "dog",
                                                        snapshot:
                                                            productProvider
                                                                .getdogList)),
                                                replace: true),
                                          if (menuData[index]['text'] ==
                                              "Accessory")
                                            FluroRouters.router.navigateTo(
                                                context,
                                                ProductScreen.routeName,
                                                routeSettings: RouteSettings(
                                                    arguments: ScreenArguments(
                                                        name: "Accessory",
                                                        snapshot: productProvider
                                                            .getaccessoriesList)),
                                                replace: true),
                                          // if (menuData[index]['text'] ==
                                          //     "Veges")
                                          //   FluroRouters.router.navigateTo(
                                          //       context,
                                          //       ProductScreen.routeName,
                                          //       routeSettings: RouteSettings(
                                          //           arguments: ScreenArguments(
                                          //               name: "Veges",
                                          //               snapshot:
                                          //                   productProvider
                                          //                       .getvegesList)),
                                          //       replace: true),
                                          // if (menuData[index]['text'] ==
                                          //     "Snack")
                                          //   FluroRouters.router.navigateTo(
                                          //       context,
                                          //       ProductScreen.routeName,
                                          //       routeSettings: RouteSettings(
                                          //           arguments: ScreenArguments(
                                          //               name: "Snack",
                                          //               snapshot:
                                          //                   productProvider
                                          //                       .getsnackList)),
                                          //       replace: true),
                                          if (menuData[index]['text'] == "Cat")
                                            FluroRouters.router.navigateTo(
                                                context,
                                                ProductScreen.routeName,
                                                routeSettings: RouteSettings(
                                                    arguments: ScreenArguments(
                                                        name: "cat",
                                                        snapshot:
                                                            productProvider
                                                                .getcatList)),
                                                replace: true),
                                        },
                                      ),
                                    },
                                    onHover: (ischeck) {
                                      setState(() {
                                        if (ischeck) {
                                          check.clear();
                                          check.add(index);
                                        } else {
                                          check.remove(index);
                                          check.add(-1);
                                        }
                                      });
                                    },
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5),
                                      child: Container(
                                        height: 70,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: check.elementAt(0) ==
                                                          index
                                                      ? Colors.white
                                                      : Color(0xdac2c2c2f),
                                                  offset: Offset(4.0, 4.0),
                                                  blurRadius: 5.0,
                                                  spreadRadius: 1.0),
                                              BoxShadow(
                                                  color: Colors.white,
                                                  offset: Offset(-4.0, -4.0),
                                                  blurRadius: 5.0,
                                                  spreadRadius: 1.0),
                                            ]),
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child:
                                                    Responsive.isMobile(context)
                                                        ? Image.asset(
                                                            "assets/" +
                                                                menuData[index]
                                                                        ['icon']
                                                                    .toString(),
                                                            fit: BoxFit.cover,
                                                            width: 30,
                                                            height: 30,
                                                          )
                                                        : Image.asset(
                                                            menuData[index]
                                                                    ['icon']
                                                                .toString(),
                                                            fit: BoxFit.cover,
                                                            width: 30,
                                                            height: 30,
                                                          ),
                                              ),
                                              Spacer(),
                                              Text(menuData[index]['name']
                                                  .toString()),
                                              Spacer(
                                                flex: 8,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
                Expanded(
                  flex: 7,
                  child: Padding(
                    padding: Responsive.isDesktop(context)
                        ? EdgeInsets.only(left: 10.0)
                        : EdgeInsets.only(left: 5.0, right: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (images.length >= 1)
                                    CarouselSlider.builder(
                                      itemCount: images.length,
                                      itemBuilder: (context, index, realIndex) {
                                        return Container(
                                            padding: EdgeInsets.only(
                                                top: 5, left: 5, right: 5),
                                            child: CachedNetworkImage(
                                              imageUrl: images[index],
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      SizedBox(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(8)),
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              placeholder: (context, url) =>
                                                  Center(
                                                      child: SizedBox(
                                                child:
                                                    CircularProgressIndicator(),
                                                width: 50,
                                                height: 50,
                                              )),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ));
                                      },
                                      options: CarouselOptions(
                                        viewportFraction: 1,
                                        aspectRatio: 300 / 250,
                                        autoPlayAnimationDuration: Duration(
                                          seconds: 1,
                                        ),
                                        onPageChanged: (index, reason) {
                                          setState(() {
                                            _current = index;
                                            if (images.isNotEmpty)
                                              for (int i = 0;
                                                  i < images.length;
                                                  i++) {
                                                if (i == index) {
                                                  _isSelected[i] = true;
                                                } else {
                                                  _isSelected[i] = false;
                                                }
                                              }
                                          });
                                        },
                                      ),
                                      carouselController: _controller,
                                    ),
                                  ScrollConfiguration(
                                    behavior: ScrollConfiguration.of(context)
                                        .copyWith(
                                      dragDevices: {
                                        PointerDeviceKind.mouse,
                                        PointerDeviceKind.touch,
                                      },
                                    ),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          if (images.length >= 1)
                                            for (int i = 0;
                                                i < images.length;
                                                i++)
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  top: 5,
                                                  right: 5,
                                                  bottom: 5,
                                                ),
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      _controller.animateToPage(
                                                          i,
                                                          duration: Duration(
                                                              seconds: 1));
                                                    });
                                                  },
                                                  child: Container(
                                                    decoration: _isSelected[i]
                                                        ? BoxDecoration(
                                                            border:
                                                                Border.all(),
                                                          )
                                                        : BoxDecoration(),
                                                    child: CachedNetworkImage(
                                                      imageUrl: images[i],
                                                      imageBuilder: (context,
                                                              imageProvider) =>
                                                          Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            image:
                                                                imageProvider,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        height: 80,
                                                        width: 80,
                                                      ),
                                                      placeholder: (context,
                                                              url) =>
                                                          CircularProgressIndicator(),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(Icons.error),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Responsive.isMobile(context)
                                ? Container()
                                : Expanded(
                                    child: SizedBox(
                                      height: 380,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            widget.snapshot!.name.toUpperCase(),
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "Giá: ${NumberFormat.currency(locale: 'vi').format(widget.snapshot!.price)}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Container(
                                            width: Responsive.getSize(context)
                                                .width,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: Color(0xffffffff),
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 10,
                                                    color: Color(0xffd6d6d6),
                                                    offset: Offset(
                                                      10,
                                                      10,
                                                    ),
                                                  ),
                                                  BoxShadow(
                                                    blurRadius: 10,
                                                    color: Color(0xffffffff),
                                                    offset: Offset(
                                                      -10,
                                                      -10,
                                                    ),
                                                  ),
                                                ],
                                                gradient: LinearGradient(
                                                  stops: [0, 1],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [
                                                    Color(0xffe6e6e6),
                                                    Color(0xffffffff)
                                                  ],
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                  20,
                                                ))),
                                            child: Center(
                                                child: Text(
                                                    NumberFormat.currency(
                                                            locale: 'vi')
                                                        .format(widget.snapshot!
                                                                .price *
                                                            count))),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Color",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Spacer(),
                                              SizedBox(
                                                width: 200,
                                                child: ToggleButtons(
                                                  children: [
                                                    Container(
                                                      width: 40,
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xE3E0E0E0),
                                                        border: Border.all(
                                                          color:
                                                              Color(0xE5F7D7EB),
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child: Center(
                                                        child: Text("R"),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 40,
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xE3E0E0E0),
                                                        border: Border.all(
                                                          color:
                                                              Color(0xE5F7D7EB),
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child: Center(
                                                        child: Text("B"),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 40,
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xE3E0E0E0),
                                                        border: Border.all(
                                                          color:
                                                              Color(0xE5F7D7EB),
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child: Center(
                                                        child: Text("G"),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 40,
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xE3E0E0E0),
                                                        border: Border.all(
                                                          color:
                                                              Color(0xE5F7D7EB),
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child: Center(
                                                        child: Text("O"),
                                                      ),
                                                    ),
                                                  ],
                                                  onPressed: (int index) {
                                                    setState(() {
                                                      for (int indexBtn = 0;
                                                          indexBtn <
                                                              sized.length;
                                                          indexBtn++) {
                                                        if (indexBtn == index) {
                                                          sized[indexBtn] =
                                                              true;
                                                        } else {
                                                          sized[indexBtn] =
                                                              false;
                                                        }
                                                      }
                                                    });
                                                    setState(() {
                                                      sizeIndex = index;
                                                    });
                                                  },
                                                  isSelected: sized,
                                                ),
                                              ),
                                              Spacer(),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Số lượng",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Spacer(),
                                              SizedBox(
                                                width: 100,
                                                height: 30,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Container(
                                                      width: 30,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: Color(
                                                                  0xE7EEEEEE)),
                                                          color:
                                                              Color(0xffffffff),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              blurRadius: 3,
                                                              color: Color(
                                                                  0xffd6d6d6),
                                                              offset: Offset(
                                                                2,
                                                                2,
                                                              ),
                                                            ),
                                                            BoxShadow(
                                                              blurRadius: 3,
                                                              color: Color(
                                                                  0xffffffff),
                                                              offset: Offset(
                                                                -2,
                                                                -2,
                                                              ),
                                                            ),
                                                          ],
                                                          gradient:
                                                              LinearGradient(
                                                            stops: [0, 1],
                                                            begin: Alignment
                                                                .topLeft,
                                                            end: Alignment
                                                                .bottomRight,
                                                            colors: [
                                                              Color(0xffffffff),
                                                              Color(0xffe6e6e6)
                                                            ],
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                            150,
                                                          ))),
                                                      child: InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              if (count > 1) {
                                                                count--;
                                                              }
                                                            });
                                                          },
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          child: Icon(
                                                              Icons.remove,
                                                              color: Color(
                                                                  0xC4B1B1B1))),
                                                    ),
                                                    Text(count.toString()),
                                                    Container(
                                                      width: 30,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: Color(
                                                                  0xE7EEEEEE)),
                                                          color:
                                                              Color(0xffffffff),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              blurRadius: 3,
                                                              color: Color(
                                                                  0xffd6d6d6),
                                                              offset: Offset(
                                                                2,
                                                                2,
                                                              ),
                                                            ),
                                                            BoxShadow(
                                                              blurRadius: 3,
                                                              color: Color(
                                                                  0xffffffff),
                                                              offset: Offset(
                                                                -2,
                                                                -2,
                                                              ),
                                                            ),
                                                          ],
                                                          gradient:
                                                              LinearGradient(
                                                            stops: [0, 1],
                                                            begin: Alignment
                                                                .topLeft,
                                                            end: Alignment
                                                                .bottomRight,
                                                            colors: [
                                                              Color(0xffffffff),
                                                              Color(0xffe6e6e6)
                                                            ],
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                            150,
                                                          ))),
                                                      child: InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            count++;
                                                          });
                                                        },
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        child: Icon(
                                                          Icons.add,
                                                          color:
                                                              Color(0xC4B1B1B1),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Spacer(),
                                            ],
                                          ),
                                          Center(
                                            child: GestureDetector(
                                              onTap: () {
                                                getSize();
                                                productProvider.getCheckOutData(
                                                  image: widget.snapshot!.image
                                                      .elementAt(0),
                                                  id: widget.snapshot!.id,
                                                  size: size,
                                                  name: widget.snapshot!.name,
                                                  price: widget.snapshot!.price,
                                                  quantity: count,
                                                );

                                                setState(() {
                                                  testdata.addCounts(count);
                                                  setcardShare(
                                                      widget.snapshot!);
                                                });
                                                FluroRouters.router.navigateTo(
                                                    context,
                                                    CartScreen.routeName,
                                                    replace: true);
                                              },
                                              child: Container(
                                                width: 130,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                    color: Color(0xffe7e7e7),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius: 3,
                                                        color:
                                                            Color(0xffa6a6a6),
                                                        offset: Offset(2, 2),
                                                      ),
                                                      BoxShadow(
                                                        blurRadius: 3,
                                                        color:
                                                            Color(0xffffffff),
                                                        offset: Offset(-2, -2),
                                                      ),
                                                    ],
                                                    gradient: LinearGradient(
                                                      stops: [0, 1],
                                                      begin: Alignment.topLeft,
                                                      end:
                                                          Alignment.bottomRight,
                                                      colors: [
                                                        Color(0xffd0d0d0),
                                                        Color(0xfff7f7f7)
                                                      ],
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                      15,
                                                    ))),
                                                child: Center(
                                                  child: Text(
                                                    'Đặt Mua',
                                                    style: TextStyle(
                                                      color: Color(0xFF808080),
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Mô tả sản phẩm",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22.0,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                FluroRouters.router.navigateTo(
                                    context, ReviewsScreen.routeName,
                                    routeSettings: RouteSettings(
                                        arguments: ReviewsArguments(
                                            snapshot: widget.snapshot!)),
                                    replace: true);
                              },
                              child: Text(
                                "Đánh Giá",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 200,
                          child: SingleChildScrollView(
                            child: Text(
                              widget.snapshot!.content,
                              textScaleFactor: 1.3,
                            ),
                          ),
                        ),
                        Responsive.isMobile(context)
                            ? SizedBox(
                                height: 380,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      widget.snapshot!.name.toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                        "Giá: ${NumberFormat.currency(locale: 'vi').format(widget.snapshot!.price)}"),
                                    Container(
                                      width: Responsive.getSize(context).width,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: Color(0xffffffff),
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 10,
                                              color: Color(0xffd6d6d6),
                                              offset: Offset(
                                                10,
                                                10,
                                              ),
                                            ),
                                            BoxShadow(
                                              blurRadius: 10,
                                              color: Color(0xffffffff),
                                              offset: Offset(
                                                -10,
                                                -10,
                                              ),
                                            ),
                                          ],
                                          gradient: LinearGradient(
                                            stops: [0, 1],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Color(0xffe6e6e6),
                                              Color(0xffffffff)
                                            ],
                                          ),
                                          borderRadius:
                                              BorderRadius.all(Radius.circular(
                                            20,
                                          ))),
                                      child: Center(
                                          child: Text(NumberFormat.currency(
                                                  locale: 'vi')
                                              .format(widget.snapshot!.price *
                                                  count))),
                                    ),
                                    Row(
                                      children: [
                                        Text("Color"),
                                        Spacer(),
                                        SizedBox(
                                          width: 200,
                                          child: ToggleButtons(
                                            children: [
                                              Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  color: Color(0xE3E0E0E0),
                                                  border: Border.all(
                                                    color: Color(0xE5F7D7EB),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Center(
                                                  child: Text("R"),
                                                ),
                                              ),
                                              Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  color: Color(0xE3E0E0E0),
                                                  border: Border.all(
                                                    color: Color(0xE5F7D7EB),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Center(
                                                  child: Text("B"),
                                                ),
                                              ),
                                              Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  color: Color(0xE3E0E0E0),
                                                  border: Border.all(
                                                    color: Color(0xE5F7D7EB),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Center(
                                                  child: Text("G"),
                                                ),
                                              ),
                                              Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  color: Color(0xE3E0E0E0),
                                                  border: Border.all(
                                                    color: Color(0xE5F7D7EB),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Center(
                                                  child: Text("O"),
                                                ),
                                              ),
                                            ],
                                            onPressed: (int index) {
                                              setState(() {
                                                for (int indexBtn = 0;
                                                    indexBtn < sized.length;
                                                    indexBtn++) {
                                                  if (indexBtn == index) {
                                                    sized[indexBtn] = true;
                                                  } else {
                                                    sized[indexBtn] = false;
                                                  }
                                                }
                                              });
                                              setState(() {
                                                sizeIndex = index;
                                              });
                                            },
                                            isSelected: sized,
                                          ),
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Số lượng"),
                                        Spacer(),
                                        SizedBox(
                                          width: 100,
                                          height: 30,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color:
                                                            Color(0xE7EEEEEE)),
                                                    color: Color(0xffffffff),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius: 3,
                                                        color:
                                                            Color(0xffd6d6d6),
                                                        offset: Offset(
                                                          2,
                                                          2,
                                                        ),
                                                      ),
                                                      BoxShadow(
                                                        blurRadius: 3,
                                                        color:
                                                            Color(0xffffffff),
                                                        offset: Offset(
                                                          -2,
                                                          -2,
                                                        ),
                                                      ),
                                                    ],
                                                    gradient: LinearGradient(
                                                      stops: [0, 1],
                                                      begin: Alignment.topLeft,
                                                      end:
                                                          Alignment.bottomRight,
                                                      colors: [
                                                        Color(0xffffffff),
                                                        Color(0xffe6e6e6)
                                                      ],
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                      150,
                                                    ))),
                                                child: InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        if (count > 1) {
                                                          count--;
                                                        }
                                                      });
                                                    },
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    child: Icon(Icons.remove,
                                                        color:
                                                            Color(0xC4B1B1B1))),
                                              ),
                                              Text(count.toString()),
                                              Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color:
                                                            Color(0xE7EEEEEE)),
                                                    color: Color(0xffffffff),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius: 3,
                                                        color:
                                                            Color(0xffd6d6d6),
                                                        offset: Offset(
                                                          2,
                                                          2,
                                                        ),
                                                      ),
                                                      BoxShadow(
                                                        blurRadius: 3,
                                                        color:
                                                            Color(0xffffffff),
                                                        offset: Offset(
                                                          -2,
                                                          -2,
                                                        ),
                                                      ),
                                                    ],
                                                    gradient: LinearGradient(
                                                      stops: [0, 1],
                                                      begin: Alignment.topLeft,
                                                      end:
                                                          Alignment.bottomRight,
                                                      colors: [
                                                        Color(0xffffffff),
                                                        Color(0xffe6e6e6)
                                                      ],
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                      150,
                                                    ))),
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      count++;
                                                    });
                                                  },
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Color(0xC4B1B1B1),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                    Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          getSize();
                                          productProvider.getCheckOutData(
                                            image: widget.snapshot!.image
                                                .elementAt(0),
                                            id: widget.snapshot!.id,
                                            size: size,
                                            name: widget.snapshot!.name,
                                            price: widget.snapshot!.price,
                                            quantity: count,
                                          );
                                          setState(() {
                                            testdata.addCounts(count);
                                            setcardShare(widget.snapshot!);
                                          });
                                          FluroRouters.router.navigateTo(
                                              context, CartScreen.routeName,
                                              replace: true);
                                        },
                                        child: Container(
                                          width: 130,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              color: Color(0xffe7e7e7),
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 3,
                                                  color: Color(0xffa6a6a6),
                                                  offset: Offset(2, 2),
                                                ),
                                                BoxShadow(
                                                  blurRadius: 3,
                                                  color: Color(0xffffffff),
                                                  offset: Offset(-2, -2),
                                                ),
                                              ],
                                              gradient: LinearGradient(
                                                stops: [0, 1],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                colors: [
                                                  Color(0xffd0d0d0),
                                                  Color(0xfff7f7f7)
                                                ],
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                15,
                                              ))),
                                          child: Center(
                                            child: Text(
                                              'Đặt Mua',
                                              style: TextStyle(
                                                color: Color(0xFF808080),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                        SizedBox(height: 20),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Recommender",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  )),
                              Divider(
                                thickness: 2,
                                color: Color(0xFF8A8A8A),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 250,
                          child: ScrollConfiguration(
                            behavior: ScrollConfiguration.of(context).copyWith(
                              dragDevices: {
                                PointerDeviceKind.mouse,
                                PointerDeviceKind.touch,
                              },
                            ),
                            child: StreamBuilder(
                              stream: productProvider
                                  .getProductRecom(listid: _recommender)
                                  .asStream(),
                              builder: (context,
                                  AsyncSnapshot<List<Product>> snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          EdgeInsets.only(top: 10, right: 10),
                                      child: Container(
                                        width: 200,
                                        height: 250,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Color(0x3D7A7A7A),
                                                width: 2)),
                                        child: productsLike(context,
                                            snapshot.data![index], index),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  List<Widget> listMenu(Size _size, String? icon, bool ischeck, String? label) {
    return <Widget>[
      Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: ischeck ? Color(0xFFfc6a57) : Color(0xFFffe8e5),
        ),
        child: Center(
          child: Responsive.isMobile(context)
              ? Image.asset(
                  "assets/${icon!}",
                  height: 50,
                  width: 50,
                  color: ischeck ? Colors.white : Colors.black87,
                )
              : Image.asset(
                  "./${icon!}",
                  height: 50,
                  width: 50,
                  color: ischeck ? Colors.white : Colors.black87,
                ),
        ),
      ),
      Text(
        label!,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
          color: ischeck ? Color(0xFFfc6a57) : Colors.black87,
        ),
      ),
    ];
  }

  Widget productsLike(BuildContext context, Product product, int id) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 5, left: 5, right: 5),
          child: Center(
            child: CachedNetworkImage(
              imageUrl: product.image.elementAt(0),
              imageBuilder: (context, imageProvider) => Column(
                children: [
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                      height: 140,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    height: 80,
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 100,
                                child: Text(
                                  product.name,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black45,
                                      shadows: [
                                        Shadow(
                                            color: Colors.grey.shade300,
                                            offset: Offset(3.0, 3.0),
                                            blurRadius: 3.0),
                                        Shadow(
                                            color: Colors.white,
                                            offset: Offset(-3.0, 3.0),
                                            blurRadius: 3.0),
                                      ]),
                                ),
                              ),
                              // Spacer(),
                              buildRatePr(
                                  star: (double.parse(product
                                              .avg[product.avg.length - 1]
                                              .toString()) *
                                          5)
                                      .toInt(),
                                  sp: product),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(NumberFormat.currency(locale: 'vi')
                                  .format(product.price)
                                  .toString()),
                              // Spacer(),
                              Text(
                                  "(${(double.parse(product.avg[product.avg.length - 1].toString()) * 100).toInt()}%)"),
                            ]),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            setState(() {
                              FluroRouters.router
                                  .navigateTo(context, ChitietScreen.routeName,
                                      routeSettings: RouteSettings(
                                        arguments:
                                            DetailArguments(snapshot: product),
                                      ),
                                      replace: true);
                            });
                          },
                          child: Container(
                            height: 25,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Color(0xffe7e7e7),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 3,
                                    color: Color(0xffa6a6a6),
                                    offset: Offset(2, 2),
                                  ),
                                  BoxShadow(
                                    blurRadius: 3,
                                    color: Color(0xffffffff),
                                    offset: Offset(-2, -2),
                                  ),
                                ],
                                gradient: LinearGradient(
                                  stops: [0, 1],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xffd0d0d0),
                                    Color(0xfff7f7f7)
                                  ],
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(
                                  15,
                                ))),
                            child: Center(
                              child: Text(
                                'Đặt Mua',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildRatePr({required int star, required Product sp}) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...List.generate(
            5,
            (index) => GestureDetector(
              onTap: () {
                if (FirebaseAuth.instance.currentUser != null) {
                  FluroRouters.router.navigateTo(
                      context, ReviewsScreen.routeName,
                      routeSettings: RouteSettings(
                          arguments: ReviewsArguments(snapshot: sp)),
                      replace: true);
                } else {
                  FluroRouters.router.navigateTo(
                      context, LoginSignupScreen.routeName,
                      replace: true);
                }
              },
              child: ((index + 1) <= star)
                  ? Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 13,
                    )
                  : Icon(
                      Icons.star,
                      color: Colors.grey,
                      size: 13,
                    ),
            ),
          ),
        ],
      );
}

// https://tamnguyen.com.vn/thiet-ke-website-do-an-vie-food.html

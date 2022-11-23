// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_this, prefer_is_empty, await_only_futures, avoid_function_literals_in_foreach_calls, sized_box_for_whitespace, deprecated_member_use

import 'dart:convert';

import 'package:apporder/models/cart.dart';
import 'package:apporder/provider/cart_provider.dart';
import 'package:apporder/responsive/responsive_screen.dart';
import 'package:apporder/routes.dart';
import 'package:apporder/screens/login_signup/loginsignup_page.dart';
import 'package:apporder/screens/payment/payment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Contents extends StatefulWidget {
  const Contents({Key? key}) : super(key: key);

  @override
  _ContentsState createState() => _ContentsState();
}

get RaisedButton => null;
late CartProvider testdata;

class _ContentsState extends State<Contents> {
  late SharedPreferences prefs;
  List<CartModel> myList = [];
  Future<List<CartModel>>? data;
  bool cartdata = false;
  @override
  void initState() {
    super.initState();
    getList().then(updateCart);
    data = categoryList();
  }

  void updateCart(String listpd) {
    setState(() {
      List<CartModel> myLists = [];
      if (listpd.isNotEmpty) {
        myLists = (json.decode(listpd) as List<dynamic>)
            .map<CartModel>((item) => CartModel.fromJson(item))
            .toList();
      }
      this.myList = myLists;
    });
  }

  Future<List<CartModel>> categoryList() async {
    return await myList;
  }

  Future<String> getList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('cart') ?? '';
  }

  Future settingSharepre() async {
    return await SharedPreferences.getInstance();
  }

  Future<void> addcardShare(CartModel product) async {
    if (myList.length > 0) {
      myList.forEach((element) {
        if (element.id == product.id) {
          element.quantity += 1;
          if (FirebaseAuth.instance.currentUser != null) {
            CollectionReference likeRef = FirebaseFirestore.instance
                .collection("User")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection("cart");
            likeRef.doc(product.id).update(CartModel.toMap(product));
          }
        }
      });
      settingSharepre().then(
        (value) => {
          prefs = value,
          prefs.setString('cart', CartModel.encode(myList)),
        },
      );
    }
  }

  Future<void> removecardShare(CartModel product) async {
    if (myList.length > 0) {
      myList.forEach((element) {
        if (element.id == product.id) {
          if (element.quantity > 1) {
            element.quantity -= 1;
            if (FirebaseAuth.instance.currentUser != null) {
              CollectionReference likeRef = FirebaseFirestore.instance
                  .collection("User")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection("cart");
              likeRef.doc(product.id).update(CartModel.toMap(product));
            }
          }
        }
      });
      settingSharepre().then(
        (value) => {
          prefs = value,
          prefs.setString('cart', CartModel.encode(myList)),
        },
      );
    }
  }

  Future<void> deletecardShare(CartModel product) async {
    int index = 0;
    myList.asMap().forEach((key, value) {
      if (value.id == product.id) index = key;
    });
    if (FirebaseAuth.instance.currentUser != null) {
      CollectionReference likeRef = FirebaseFirestore.instance
          .collection("User")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("cart");
      likeRef.doc(product.id).delete();
    }
    myList.removeAt(index);
    settingSharepre().then(
      (value) => {
        prefs = value,
        prefs.setString('cart', CartModel.encode(myList)),
      },
    );
  }

  String getItemcart() {
    dynamic item = 0;
    if (myList.length > 0) {
      myList.forEach((element) {
        item += element.quantity;
      });
    }
    return item.toString();
  }

  num getPricecart() {
    dynamic item = 0;
    if (myList.length > 0) {
      myList.forEach((element) {
        item += (element.price * element.quantity);
      });
    }
    return item;
  }

  @override
  Widget build(BuildContext context) {
    testdata = Provider.of<CartProvider>(context, listen: false);
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Responsive.isDesktop(context) ? 140.0 : 0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            height: myList.length > 0 ? 500 : 150,
            child: StreamBuilder(
                stream: data!.asStream(),
                builder: (context, AsyncSnapshot<List<CartModel>> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (myList.isEmpty) {
                    return Center(
                        child: Text("Chưa có sản phẩm nào trong giỏ"));
                  }
                  return ListView.builder(
                    itemCount: myList.length,
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                        child: Container(
                          width: Responsive.getSize(context).width,
                          height: 120,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(0, 2),
                                  blurRadius: 20.0,
                                )
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        myList.elementAt(index).image,
                                        fit: BoxFit.cover,
                                        height: 100,
                                        width: 100,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        width: Responsive.isDesktop(context) ||
                                                Responsive.isTablet(context)
                                            ? 180
                                            : 100,
                                        child: Text(
                                          myList.elementAt(index).name,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        NumberFormat.currency(locale: 'vi')
                                            .format(
                                                myList.elementAt(index).price)
                                            .toString(),
                                        style: TextStyle(
                                            color: Color.fromARGB(101, 0, 0, 0),
                                            fontSize: 13.0),
                                      ),
                                      Text(
                                        "Color: ${myList.elementAt(index).size}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          // color: Color(0xE7FFA9A9),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0xCBE2E2E2),
                                              offset: Offset(1, 3),
                                              blurRadius: 10,
                                            ),
                                          ]),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                              width: 30,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFFF8F8F8),
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Color(0xCBE2E2E2),
                                                      offset: Offset(1, 3),
                                                      blurRadius: 10,
                                                    ),
                                                  ]),
                                              child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      if (myList
                                                              .elementAt(index)
                                                              .quantity >
                                                          1) {
                                                        testdata.removeCount();
                                                        removecardShare(myList
                                                            .elementAt(index));
                                                      }
                                                    });
                                                  },
                                                  child: Icon(
                                                    Icons.remove,
                                                    color: Color.fromARGB(
                                                        73, 97, 97, 97),
                                                  ))),
                                          Text(
                                            myList
                                                .elementAt(index)
                                                .quantity
                                                .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    101, 0, 0, 0),
                                                fontSize: 13.0),
                                          ),
                                          Container(
                                              width: 30,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFFF8F8F8),
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Color(0xCBE2E2E2),
                                                      offset: Offset(1, 3),
                                                      blurRadius: 10,
                                                    ),
                                                  ]),
                                              child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      testdata.addCount();
                                                      addcardShare(myList
                                                          .elementAt(index));
                                                    });
                                                  },
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Color.fromARGB(
                                                        73, 97, 97, 97),
                                                  ))),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      NumberFormat.currency(locale: 'vi')
                                          .format(myList
                                                  .elementAt(index)
                                                  .price *
                                              myList.elementAt(index).quantity)
                                          .toString(),
                                      style: TextStyle(
                                          color: Color.fromARGB(101, 0, 0, 0),
                                          fontSize: 13.0),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          testdata.removeCounts(
                                              myList.elementAt(index).quantity);
                                          deletecardShare(
                                              myList.elementAt(index));
                                        });
                                      },
                                      child: Icon(
                                        MdiIcons.delete,
                                        size: 20,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
          ),
          if (myList.length > 0)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                padding: EdgeInsets.only(top: 10, right: 10, left: 10),
                height: 100,
                color: Colors.blue,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("Item Price"), Text(getItemcart())],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Subtotal"),
                        Text(NumberFormat.currency(locale: 'vi')
                            .format(getPricecart()))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          if (myList.length > 0)
            Container(
              height: 50.0,
              margin: EdgeInsets.all(10),
              child: RaisedButton(
                onPressed: () {
                  if (FirebaseAuth.instance.currentUser == null) {
                    FluroRouters.router.navigateTo(
                        context, LoginSignupScreen.routeName,
                        replace: true);
                  } else {
                    FluroRouters.router.navigateTo(
                        context, PaymentScreen.routeName,
                        replace: true);
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                padding: EdgeInsets.all(0.0),
                child: Ink(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xff374ABE), Color(0xff64B6FF)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Container(
                    constraints: BoxConstraints(
                        maxWidth: Responsive.getSize(context).width * 0.65,
                        minHeight: 50.0),
                    alignment: Alignment.center,
                    child: Text(
                      "Thanh Toán",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// https://tamnguyen.com.vn/thiet-ke-website-do-an-vie-food.html

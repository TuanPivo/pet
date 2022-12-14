// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, avoid_function_literals_in_foreach_calls, unnecessary_this, avoid_print, curly_braces_in_flow_control_structures

import 'package:apporder/components/search_tf.dart';
import 'package:apporder/models/cart.dart';
import 'package:apporder/provider/cart_provider.dart';
import 'package:apporder/routes.dart';
import 'package:apporder/screens/cart/cart_screen.dart';
import 'package:apporder/screens/favourite/favourite.dart';
import 'package:apporder/screens/homes/homes_screen.dart';
import 'package:apporder/screens/login_signup/loginsignup_page.dart';
import 'package:apporder/screens/profile/profile_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:badges/badges.dart';

class TopBar extends StatefulWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  _TopBarState createState() => _TopBarState();
}

late CartProvider productProvider;

class _TopBarState extends State<TopBar> {
  String _uid = '';
  bool isLogin = false;
  String _name = '';
  String _image = '';
  @override
  void initState() {
    getName().then(getNames);
    getImg().then(getImgs);
    super.initState();
    getCurrentUserUid().then(updateUid);
  }

  Future<String> getName() async {
    String name = "";
    QuerySnapshot featureSnapShot =
        await FirebaseFirestore.instance.collection("User").get();
    featureSnapShot.docs.forEach((element) {
      if (element.id == _uid) {
        name = element.get("UserName");
      }
    });

    return name;
  }

  Future<String> getImg() async {
    String img = "";
    QuerySnapshot featureSnapShot =
        await FirebaseFirestore.instance.collection("User").get();
    featureSnapShot.docs.forEach((element) {
      if (element.id == _uid) {
        sharecart(_uid);
        img = element.get("avtar") ?? "";
      }
    });
    return img;
  }

  Future<void> sharecart(String uid) async {
    List<CartModel> checkOutModelList = [];
    CartModel checkOutModel;
    num quantitys = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    QuerySnapshot featureSnapShot = await FirebaseFirestore.instance
        .collection("User")
        .doc(uid)
        .collection("cart")
        .get();
    if (prefs.getString('cart') == null) {
      if (featureSnapShot.docs.isNotEmpty) {
        featureSnapShot.docs.forEach((element) {
          checkOutModel = CartModel(
            size: element.get("size"),
            price: element.get("price"),
            name: element.get("name"),
            image: element.get("image"),
            quantity: element.get("quantity"),
            id: element.get("id"),
          );
          quantitys += checkOutModel.quantity;
          checkOutModelList.add(checkOutModel);
        });
      }
      if (checkOutModelList.isNotEmpty) {
        await prefs.setString('cart', CartModel.encode(checkOutModelList));
        await prefs.setInt('count', quantitys.toInt());
      }
    }
  }

  void updateUid(String uid) {
    setState(() {
      this._uid = uid;
    });
  }

  void getNames(String name) {
    setState(() {
      this._name = name;
    });
  }

  void getImgs(String img) {
    setState(() {
      this._image = img;
    });
  }

  Future<String> getCurrentUserUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('uid').toString();
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
    productProvider = Provider.of<CartProvider>(context);
    if (productProvider.checkLogin().isNotEmpty) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.radar_sharp,
                    size: 45.0,
                    color: Colors.indigo[50],
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 5.0, top: 3.0),
                    child: Text(
                      "PET SHOP",
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.indigo[50],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: TextButton(
                      onPressed: () {
                        FluroRouters.router.navigateTo(
                            context, HomesScreen.routeName,
                            replace: true);
                      },
                      style: ElevatedButton.styleFrom(
                        onPrimary: Colors.indigo[50],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        padding: EdgeInsets.all(18.0),
                      ),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                            child: Text(
                              'Home',
                              style: TextStyle(color: Colors.indigo[50]),
                            ),
                          ),
                        ],
                      )),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: TextButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        onPrimary: Colors.indigo[50],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        padding: EdgeInsets.all(18.0),
                      ),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                            child: Text(
                              'About',
                              style: TextStyle(color: Colors.indigo[50]),
                            ),
                          ),
                        ],
                      )),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          FluroRouters.router.navigateTo(
                              context, FavouriteScreen.routeName,
                              replace: true);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        onPrimary: Colors.indigo[50],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        padding: EdgeInsets.all(18.0),
                      ),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                            child: Text(
                              'Favourite',
                              style: TextStyle(color: Colors.indigo[50]),
                            ),
                          ),
                        ],
                      )),
                ),
                Container(
                  child: TextButton(
                      onPressed: () {
                        FluroRouters.router.navigateTo(
                            context, CartScreen.routeName,
                            replace: true);
                      },
                      style: ElevatedButton.styleFrom(
                        onPrimary: Colors.indigo[50],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        padding: EdgeInsets.all(18.0),
                      ),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                            child: Badge(
                              padding: EdgeInsets.all(3.5),
                              badgeContent: Consumer<CartProvider>(
                                builder: (context, value, child) {
                                  return value.getCount() > 9
                                      ? Text.rich(
                                          TextSpan(children: [
                                            TextSpan(
                                                text: "9",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 11)),
                                            TextSpan(
                                                text: "+",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 8)),
                                          ]),
                                        )
                                      : Text(value.getCount().toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12));
                                },
                              ),
                              child: Text(
                                'Cart',
                                style: TextStyle(color: Colors.indigo[50]),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
                Container(
                  child: TextButton(
                    onPressed: () async {
                      await showSearch<String>(
                        context: context,
                        delegate: CustomDelegate(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      onPrimary: Colors.indigo[50],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      padding: EdgeInsets.all(18.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                      child: Icon(Icons.search, size: 20),
                    ),
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(left: 20.0),
                    child:
                        // InkWell(
                        //     onTap: () {
                        //       setState(() {
                        //         deleteShareprefence();
                        //         Navigator.pushNamed(context, HomesScreen.routeName);
                        //       });
                        //     },
                        PopupMenuButton<int>(
                      onSelected: (value) {
                        switch (value) {
                          case 0:
                            setState(() {
                              FluroRouters.router.navigateTo(
                                  context, ProfileScreen.routeName,
                                  replace: true);
                            });
                            break;
                          case 1:
                            setState(() {
                              deleteShareprefence();
                              FluroRouters.router.navigateTo(
                                  context, HomesScreen.routeName,
                                  replace: true);
                            });
                            break;
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 0,
                          child: Text(
                            "Profile",
                            style: TextStyle(
                                // color: TEXT_BLACK,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        PopupMenuDivider(),
                        PopupMenuItem(
                            value: 1,
                            child: Row(
                              children: [
                                Icon(Icons.logout),
                                Text(
                                  "Logout",
                                  style: TextStyle(
                                      // color: TEXT_BLACK,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            )),
                      ],
                      child: productProvider.getLink().isNotEmpty
                          ? CircleAvatar(
                              radius: 18,
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: productProvider.getLink(),
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),

                              backgroundColor: Colors.white,
                              // NetworkImage(productProvider.getLink()),
                            )
                          : CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 18,
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: _image,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                              // backgroundImage: NetworkImage(_image),
                            ),
                      // child: _image == ''
                      //     ? CircleAvatar(
                      //         foregroundColor: Colors.red,
                      //         child: Text(
                      //           _name.substring(0, 1).toUpperCase(),
                      //           style: TextStyle(fontSize: 20),
                      //         ),
                      //       )
                      //     : CircleAvatar(
                      //         backgroundColor: Colors.white,
                      //         backgroundImage: NetworkImage(_image),
                      //       ),
                      offset: Offset(0, 45),
                    )),
              ],
            ),
          ],
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.radar_sharp,
                    size: 45.0,
                    color: Colors.indigo[50],
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 5.0, top: 3.0),
                    child: Text(
                      "PET SHOP",
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.indigo[50],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: TextButton(
                      onPressed: () {
                        FluroRouters.router.navigateTo(
                            context, HomesScreen.routeName,
                            replace: true);
                      },
                      style: ElevatedButton.styleFrom(
                        onPrimary: Colors.indigo[50],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        padding: EdgeInsets.all(18.0),
                      ),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                            child: Text(
                              'Home',
                              style: TextStyle(color: Colors.indigo[50]),
                            ),
                          ),
                        ],
                      )),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: TextButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        onPrimary: Colors.indigo[50],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        padding: EdgeInsets.all(18.0),
                      ),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                            child: Text(
                              'About',
                              style: TextStyle(color: Colors.indigo[50]),
                            ),
                          ),
                        ],
                      )),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          FluroRouters.router.navigateTo(
                              context, FavouriteScreen.routeName,
                              replace: true);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        onPrimary: Colors.indigo[50],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        padding: EdgeInsets.all(18.0),
                      ),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                            child: Text(
                              'Favourite',
                              style: TextStyle(color: Colors.indigo[50]),
                            ),
                          ),
                        ],
                      )),
                ),
                Container(
                  child: TextButton(
                      onPressed: () {
                        FluroRouters.router.navigateTo(
                            context, CartScreen.routeName,
                            replace: true);
                      },
                      style: ElevatedButton.styleFrom(
                        onPrimary: Colors.indigo[50],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        padding: EdgeInsets.all(18.0),
                      ),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                            child: Badge(
                              padding: EdgeInsets.all(3.5),
                              badgeContent: Consumer<CartProvider>(
                                builder: (context, value, child) {
                                  return value.getCount() > 9
                                      ? Text.rich(
                                          TextSpan(children: [
                                            TextSpan(
                                                text: "9",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 11)),
                                            TextSpan(
                                                text: "+",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 8)),
                                          ]),
                                        )
                                      : Text(value.getCount().toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12));
                                },
                              ),
                              child: Text(
                                'Cart',
                                style: TextStyle(color: Colors.indigo[50]),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
                Container(
                  child: TextButton(
                    onPressed: () async {
                      await showSearch<String>(
                        context: context,
                        delegate: CustomDelegate(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      onPrimary: Colors.indigo[50],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      padding: EdgeInsets.all(18.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                      child: Icon(Icons.search, size: 20),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.indigo[600],
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      padding: EdgeInsets.all(10.0),
                    ),
                    onPressed: () {
                      FluroRouters.router.navigateTo(
                          context, LoginSignupScreen.routeName,
                          replace: true);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 15.0, top: 0.0, right: 15.0, bottom: 0.0),
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
  }
}

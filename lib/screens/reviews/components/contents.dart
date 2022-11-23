// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, curly_braces_in_flow_control_structures, unused_field, avoid_function_literals_in_foreach_calls, prefer_is_empty, avoid_unnecessary_containers

import 'dart:async';

import 'package:apporder/components/menu.dart';
import 'package:apporder/data/review.dart';
import 'package:apporder/models/product.dart';
import 'package:apporder/provider/product_provider.dart';
import 'package:apporder/provider/cart_provider.dart';
import 'package:apporder/responsive/responsive_screen.dart';
import 'package:apporder/routes.dart';
import 'package:apporder/screens/login_signup/loginsignup_page.dart';
import 'package:apporder/utils/custom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Contents extends StatefulWidget {
  final Product? snapshot;

  const Contents({Key? key, this.snapshot}) : super(key: key);

  @override
  _ContentsState createState() => _ContentsState();
}

late ProductProvider productProvider;
late CartProvider testdata;

class _ContentsState extends State<Contents> {
  late String _uid = '';
  Map<String, dynamic> data1 = {};
  late DocumentReference<Map<String, dynamic>> ratingsRef;
  TextEditingController textarea = TextEditingController();

  @override
  void initState() {
    if (FirebaseAuth.instance.currentUser == null) {
      Timer.run(() {
        FluroRouters.router
            .navigateTo(context, LoginSignupScreen.routeName, replace: true);
      });
    } else {
      ProductProvider initproductProvider =
          Provider.of<ProductProvider>(context, listen: false);
      getCallAllFunction(initproductProvider);
      getCurrentUserUid().then(updateUid);
      ratingsRef = FirebaseFirestore.instance
          .collection("categoryicon")
          .doc("6sxmZb8HIV3x6ZbgmlWx")
          .collection(widget.snapshot!.catoname)
          .doc(widget.snapshot!.id)
          .collection('rating')
          .doc(FirebaseAuth.instance.currentUser!.uid);
    }
    super.initState();
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

  bool isMore = false;
  List<double> ratings = [0.1, 0.3, 0.5, 0.7, 0.9];

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Responsive.isDesktop(context) ? 140.0 : 0),
      child: StreamBuilder(
          stream: productProvider
              .checkRating(
                  FirebaseAuth.instance.currentUser!.uid, widget.snapshot!)
              .asStream(),
          builder: (context, AsyncSnapshot<List<String>> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              children: [
                Container(
                  color: Palette.animationColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 16.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      "${(double.parse(widget.snapshot!.avg[widget.snapshot!.avg.length - 1].toString()) * 5).toInt()}",
                                  style: TextStyle(fontSize: 48.0),
                                ),
                                TextSpan(
                                  text: "/5",
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    color: Palette.animationColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SmoothStarRating(
                            starCount: 5,
                            rating: (double.parse(widget.snapshot!
                                    .avg[widget.snapshot!.avg.length - 1]
                                    .toString()) *
                                5),
                            size: 28.0,
                            color: Colors.orange,
                            borderColor: Colors.orange,
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            "${reviewList.length} Reviews",
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Palette.animationColor,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 200,
                        height: 200,
                        child: ListView.builder(
                          shrinkWrap: true,
                          reverse: true,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${index + 1}",
                                  style: TextStyle(fontSize: 18.0),
                                ),
                                SizedBox(width: 4.0),
                                Icon(Icons.star, color: Colors.orange),
                                SizedBox(width: 8.0),
                                LinearPercentIndicator(
                                  lineHeight: 6.0,
                                  // linearStrokeCap: LinearStrokeCap.roundAll,
                                  width: 100,
                                  animation: true,
                                  animationDuration: 2500,
                                  percent: ratings[index],
                                  progressColor: Colors.orange,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 500,
                  width: 500,
                  child: ListView.separated(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.only(bottom: 8.0, top: 8.0),
                    itemCount: reviewList.length,
                    itemBuilder: (context, index) {
                      return ReviewUI(
                        image: reviewList[index].image,
                        name: reviewList[index].name,
                        date: reviewList[index].date,
                        comment: reviewList[index].comment,
                        rating: reviewList[index].rating,
                        onPressed: () => print("More Action $index"),
                        onTap: () => setState(() {
                          isMore = !isMore;
                        }),
                        isLess: isMore,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        thickness: 2.0,
                        color: Palette.animationColor,
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Thêm đánh giá về sản phẩm",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                SmoothStarRating(
                  rating: double.parse(snapshot.data![0]),
                  allowHalfRating: false,
                  starCount: 5,
                  size: 40.0,
                  color: Colors.orange,
                  borderColor: Colors.orange,
                  spacing: 0.0,
                  filledIconData: Icons.star,
                  halfFilledIconData: Icons.star_half,
                  defaultIconData: Icons.star_border,
                  onRatingChanged: (value) {
                    setState(() {
                      ratingsRef.update({'rating': value.toInt()});
                      snapshot.data![0] = value.toString();
                    });
                  },
                ),
                Text(
                  "Bạn đã chọn: ${snapshot.data![0]} sao",
                  style: TextStyle(fontSize: 15),
                ),
                TextField(
                  controller: textarea,
                  keyboardType: TextInputType.multiline,
                  maxLines: 4,
                  decoration: InputDecoration(
                      hintText: "Nội dung đánh giá",
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Colors.redAccent))),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (FirebaseAuth.instance.currentUser != null) {
                        setState(() {
                          ratingsRef.update({'rating': (snapshot.data![0])});
                          ratingsRef.update({'cmt': (textarea.text)});
                          data1['rating'] = (snapshot.data![0]);
                          textarea.clear();
                        });
                      } else {
                        FluroRouters.router.navigateTo(
                            context, LoginSignupScreen.routeName,
                            replace: true);
                      }
                    },
                    child: Text("Đánh giá sản phẩm")),
                SizedBox(
                  height: 20,
                ),
              ],
            );
          }),
    );
  }
}

// https://tamnguyen.com.vn/thiet-ke-website-do-an-vie-food.html

// ignore_for_file: avoid_function_literals_in_foreach_calls, curly_braces_in_flow_control_structures, unnecessary_string_interpolations, empty_catches, avoid_print

import 'dart:async';
import 'dart:developer';

import 'package:apporder/models/bill.dart';
import 'package:apporder/models/cart.dart';
import 'package:apporder/models/news.dart';
import 'package:apporder/models/product.dart';
import 'package:apporder/models/sliders.dart';
import 'package:apporder/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductProvider with ChangeNotifier {
  late Product dogData;

  List<Product> dog = [];

  late Product catData;
  List<Product> cat = [];

  late Product accessoriesData;
  List<Product> accessory = [];

  // late Product snackData;
  // List<Product> snack = [];

  // late Product vegesData;
  // List<Product> veges = [];

  late Product allData;
  List<Product> alldata = [];

  late News allnewsData;
  List<News> allnewsdata = [];

  late Product likeData;
  List<Product> like = [];

  late Product loveData;
  List<Product> love = [];

  late String idloveData;
  List<String> idlove = [];

  late Sliders slidersData;
  List<Sliders> sliders = [];

  late CartModel checkOutModel;
  late CartModel cartnew;
  List<CartModel> checkOutModelList = [];

  late Product recommenderData;
  List<Product> recommender = [];

  late UserModel user;
  List<UserModel> users = [];
  String _uid = "";

  late BillModel billnew;

  String _gender = "";

  String get gender => _gender;
  List<String> data1 = [];

  Future<List<Product>> getDogList() async {
    List<Product> newList = [];
    late Product listData;
    CollectionReference data = FirebaseFirestore.instance
        .collection("categoryicon")
        .doc("6sxmZb8HIV3x6ZbgmlWx")
        .collection("Dog");
    QuerySnapshot shirtSnapShot = await data.get();
    shirtSnapShot.docs.forEach(
      (element) {
        List<String> img = [];
        img.add(element.get("image"));
        Future<QuerySnapshot> images = getListImage(data: data, id: element.id);

        images.then((value) => value.docs.forEach((element) {
              if (element.get("image").toString().isNotEmpty)
                img.add(element.get("image"));
            }));
        dynamic avg = 0.0;
        List<String> avgs = [];
        avgs.add("0");
        Future<QuerySnapshot> ratings =
            getListRating(data: data, id: element.id);
        ratings.then((value) => value.docs.forEach((element) {
              if (element.get("rating").toString().isNotEmpty) {
                avg = avg +
                    double.parse(element.get("rating").toString()) /
                        (5 * value.docs.length);
                avgs.add(avg.toString());
              }
            }));
        listData = Product(
          image: img,
          name: element.get("name"),
          price: element.get("price"),
          numlike: element.get("number_like"),
          like: element.get("like"),
          content: element.get("content"),
          id: element.id,
          catoname: "dog",
          avg: avgs,
        );
        newList.add(listData);
      },
    );
    return newList;
  }

  Future<void> getDogData() async {
    List<Product> newList = [];

    CollectionReference data = FirebaseFirestore.instance
        .collection("categoryicon")
        .doc("6sxmZb8HIV3x6ZbgmlWx")
        .collection("Dog");
    QuerySnapshot shirtSnapShot = await data.get();
    shirtSnapShot.docs.forEach(
      (element) {
        List<String> img = [];
        img.add(element.get("image"));
        Future<QuerySnapshot> images = getListImage(data: data, id: element.id);

        images.then((value) => value.docs.forEach((element) {
              if (element.get("image").toString().isNotEmpty)
                img.add(element.get("image"));
            }));
        dynamic avg = 0.0;
        List<String> avgs = [];
        avgs.add("0");
        Future<QuerySnapshot> ratings =
            getListRating(data: data, id: element.id);
        ratings.then((value) => value.docs.forEach((element) {
              if (element.get("rating").toString().isNotEmpty) {
                avg = avg +
                    double.parse(element.get("rating").toString()) /
                        (5 * value.docs.length);
                avgs.add(avg.toString());
              }
            }));
        dogData = Product(
          image: img,
          name: element.get("name"),
          price: element.get("price"),
          numlike: element.get("number_like"),
          like: element.get("like"),
          content: element.get("content"),
          id: element.id,
          catoname: "dog",
          avg: avgs,
        );
        newList.add(dogData);
      },
    );
    dog = newList;
    notifyListeners();
  }

  List<Product> get getdogList {
    return dog;
  }

  Future<List<Product>> getCatList() async {
    List<Product> newList = [];
    late Product listData;
    CollectionReference data = FirebaseFirestore.instance
        .collection("categoryicon")
        .doc("6sxmZb8HIV3x6ZbgmlWx")
        .collection("cat");
    QuerySnapshot shirtSnapShot = await data.get();
    shirtSnapShot.docs.forEach(
      (element) {
        List<String> img = [];
        img.add(element.get("image"));
        Future<QuerySnapshot> images = getListImage(data: data, id: element.id);

        images.then((value) => value.docs.forEach((element) {
              if (element.get("image").toString().isNotEmpty)
                img.add(element.get("image"));
            }));
        dynamic avg = 0.0;
        List<String> avgs = [];
        avgs.add("0");
        Future<QuerySnapshot> ratings =
            getListRating(data: data, id: element.id);
        ratings.then((value) => value.docs.forEach((element) {
              if (element.get("rating").toString().isNotEmpty) {
                avg = avg +
                    double.parse(element.get("rating").toString()) /
                        (5 * value.docs.length);
                avgs.add(avg.toString());
              }
            }));
        listData = Product(
          image: img,
          name: element.get("name"),
          price: element.get("price"),
          numlike: element.get("number_like"),
          like: element.get("like"),
          content: element.get("content"),
          id: element.id,
          catoname: "cat",
          avg: avgs,
        );
        newList.add(listData);
      },
    );
    return newList;
  }

  Future<void> getCatData() async {
    List<Product> newList = [];
    CollectionReference data = FirebaseFirestore.instance
        .collection("categoryicon")
        .doc("6sxmZb8HIV3x6ZbgmlWx")
        .collection("cat");
    QuerySnapshot shirtSnapShot = await data.get();
    shirtSnapShot.docs.forEach(
      (element) {
        List<String> img = [];
        img.add(element.get("image"));
        Future<QuerySnapshot> images = getListImage(data: data, id: element.id);

        images.then((value) => value.docs.forEach((element) {
              if (element.get("image").toString().isNotEmpty)
                img.add(element.get("image"));
            }));
        dynamic avg = 0.0;
        List<String> avgs = [];
        avgs.add("0");
        Future<QuerySnapshot> ratings =
            getListRating(data: data, id: element.id);
        ratings.then((value) => value.docs.forEach((element) {
              if (element.get("rating").toString().isNotEmpty) {
                avg = avg +
                    double.parse(element.get("rating").toString()) /
                        (5 * value.docs.length);
                avgs.add(avg.toString());
              }
            }));
        catData = Product(
          image: img,
          name: element.get("name"),
          price: element.get("price"),
          numlike: element.get("number_like"),
          like: element.get("like"),
          content: element.get("content"),
          id: element.id,
          catoname: "cat",
          avg: avgs,
        );
        newList.add(catData);
      },
    );
    cat = newList;
    notifyListeners();
  }

  List<Product> get getcatList {
    return cat;
  }

  Future<List<Product>> getAccessoriesList() async {
    List<Product> newList = [];
    late Product listData;
    CollectionReference data = FirebaseFirestore.instance
        .collection("categoryicon")
        .doc("6sxmZb8HIV3x6ZbgmlWx")
        .collection("accessory");
    QuerySnapshot shirtSnapShot = await data.get();
    shirtSnapShot.docs.forEach(
      (element) {
        List<String> img = [];
        img.add(element.get("image"));
        Future<QuerySnapshot> images = getListImage(data: data, id: element.id);

        images.then((value) => value.docs.forEach((element) {
              if (element.get("image").toString().isNotEmpty)
                img.add(element.get("image"));
            }));
        dynamic avg = 0.0;
        List<String> avgs = [];
        avgs.add("0");
        Future<QuerySnapshot> ratings =
            getListRating(data: data, id: element.id);
        ratings.then((value) => value.docs.forEach((element) {
              if (element.get("rating").toString().isNotEmpty) {
                avg = avg +
                    double.parse(element.get("rating").toString()) /
                        (5 * value.docs.length);
                avgs.add(avg.toString());
              }
            }));
        listData = Product(
          image: img,
          name: element.get("name"),
          price: element.get("price"),
          numlike: element.get("number_like"),
          like: element.get("like"),
          content: element.get("content"),
          id: element.id,
          catoname: "accessory",
          avg: avgs,
        );
        newList.add(listData);
      },
    );
    return newList;
  }

  Future<void> getAccessoriesData() async {
    List<Product> newList = [];

    CollectionReference data = FirebaseFirestore.instance
        .collection("categoryicon")
        .doc("6sxmZb8HIV3x6ZbgmlWx")
        .collection("accessory");
    QuerySnapshot shirtSnapShot = await data.get();
    print(data);
    shirtSnapShot.docs.forEach(
      (element) {
        List<String> img = [];
        img.add(element.get("image"));
        Future<QuerySnapshot> images = getListImage(data: data, id: element.id);

        images.then((value) => value.docs.forEach((element) {
              if (element.get("image").toString().isNotEmpty)
                img.add(element.get("image"));
            }));
        dynamic avg = 0.0;
        List<String> avgs = [];
        avgs.add("0");
        Future<QuerySnapshot> ratings =
            getListRating(data: data, id: element.id);
        ratings.then((value) => value.docs.forEach((element) {
              if (element.get("rating").toString().isNotEmpty) {
                avg = avg +
                    double.parse(element.get("rating").toString()) /
                        (5 * value.docs.length);
                avgs.add(avg.toString());
              }
            }));
        accessoriesData = Product(
          image: img,
          name: element.get("name"),
          price: element.get("price"),
          numlike: element.get("number_like"),
          like: element.get("like"),
          content: element.get("content"),
          id: element.id,
          catoname: "accessory",
          avg: avgs,
        );
        newList.add(accessoriesData);
      },
    );
    accessory = newList;
    notifyListeners();
  }

  List<Product> get getaccessoriesList {
    return accessory;
  }

  // Future<List<Product>> getSnackList() async {
  //   List<Product> newList = [];
  //   late Product listData;
  //   CollectionReference data = FirebaseFirestore.instance
  //       .collection("categoryicon")
  //       .doc("A8JoMU51G5b0O2bdLqTf")
  //       .collection("snack");
  //   QuerySnapshot shirtSnapShot = await data.get();

  //   shirtSnapShot.docs.forEach(
  //     (element) {
  //       List<String> img = [];
  //       img.add(element.get("image"));

  //       Future<QuerySnapshot> images = getListImage(data: data, id: element.id);

  //       images.then((value) => value.docs.forEach((element) {
  //             if (element.get("image").toString().isNotEmpty)
  //               img.add(element.get("image"));
  //           }));
  //       dynamic avg = 0.0;
  //       List<String> avgs = [];
  //       avgs.add("0");
  //       Future<QuerySnapshot> ratings =
  //           getListRating(data: data, id: element.id);
  //       ratings.then((value) => value.docs.forEach((element) {
  //             if (element.get("rating").toString().isNotEmpty) {
  //               avg = avg +
  //                   double.parse(element.get("rating").toString()) /
  //                       (5 * value.docs.length);
  //               avgs.add(avg.toString());
  //             }
  //           }));
  //       listData = Product(
  //         image: img,
  //         name: element.get("name"),
  //         price: element.get("price"),
  //         numlike: element.get("number_like"),
  //         like: element.get("like"),
  //         content: element.get("content"),
  //         id: element.id,
  //         catoname: "snack",
  //         avg: avgs,
  //       );
  //       newList.add(listData);
  //     },
  //   );
  //   return newList;
  // }

  // Future<void> getSnackData() async {
  //   List<Product> newList = [];
  //   CollectionReference data = FirebaseFirestore.instance
  //       .collection("categoryicon")
  //       .doc("A8JoMU51G5b0O2bdLqTf")
  //       .collection("snack");
  //   QuerySnapshot shirtSnapShot = await data.get();

  //   shirtSnapShot.docs.forEach(
  //     (element) {
  //       List<String> img = [];
  //       img.add(element.get("image"));

  //       Future<QuerySnapshot> images = getListImage(data: data, id: element.id);

  //       images.then((value) => value.docs.forEach((element) {
  //             if (element.get("image").toString().isNotEmpty)
  //               img.add(element.get("image"));
  //           }));
  //       dynamic avg = 0.0;
  //       List<String> avgs = [];
  //       avgs.add("0");
  //       Future<QuerySnapshot> ratings =
  //           getListRating(data: data, id: element.id);
  //       ratings.then((value) => value.docs.forEach((element) {
  //             if (element.get("rating").toString().isNotEmpty) {
  //               avg = avg +
  //                   double.parse(element.get("rating").toString()) /
  //                       (5 * value.docs.length);
  //               avgs.add(avg.toString());
  //             }
  //           }));
  //       snackData = Product(
  //         image: img,
  //         name: element.get("name"),
  //         price: element.get("price"),
  //         numlike: element.get("number_like"),
  //         like: element.get("like"),
  //         content: element.get("content"),
  //         id: element.id,
  //         catoname: "snack",
  //         avg: avgs,
  //       );
  //       newList.add(snackData);
  //     },
  //   );
  //   snack = newList;
  //   notifyListeners();
  // }

  // List<Product> get getsnackList {
  //   return snack;
  // }

  // Future<List<Product>> getVegesList() async {
  //   List<Product> newList = [];
  //   late Product listData;
  //   CollectionReference data = FirebaseFirestore.instance
  //       .collection("categoryicon")
  //       .doc("A8JoMU51G5b0O2bdLqTf")
  //       .collection("veges");
  //   QuerySnapshot shirtSnapShot = await data.get();
  //   shirtSnapShot.docs.forEach(
  //     (element) {
  //       List<String> img = [];
  //       img.add(element.get("image"));

  //       Future<QuerySnapshot> images = getListImage(data: data, id: element.id);

  //       images.then((value) => value.docs.forEach((element) {
  //             if (element.get("image").toString().isNotEmpty)
  //               img.add(element.get("image"));
  //           }));
  //       dynamic avg = 0.0;
  //       List<String> avgs = [];
  //       avgs.add("0");
  //       Future<QuerySnapshot> ratings =
  //           getListRating(data: data, id: element.id);
  //       ratings.then((value) => value.docs.forEach((element) {
  //             if (element.get("rating").toString().isNotEmpty) {
  //               avg = avg +
  //                   double.parse(element.get("rating").toString()) /
  //                       (5 * value.docs.length);
  //               avgs.add(avg.toString());
  //             }
  //           }));
  //       listData = Product(
  //         image: img,
  //         name: element.get("name"),
  //         price: element.get("price"),
  //         numlike: element.get("number_like"),
  //         like: element.get("like"),
  //         content: element.get("content"),
  //         id: element.id,
  //         catoname: "veges",
  //         avg: avgs,
  //       );
  //       newList.add(listData);
  //     },
  //   );
  //   return newList;
  // }

  // Future<void> getVegesData() async {
  //   List<Product> newList = [];
  //   CollectionReference data = FirebaseFirestore.instance
  //       .collection("categoryicon")
  //       .doc("A8JoMU51G5b0O2bdLqTf")
  //       .collection("veges");
  //   QuerySnapshot shirtSnapShot = await data.get();
  //   shirtSnapShot.docs.forEach(
  //     (element) {
  //       List<String> img = [];
  //       img.add(element.get("image"));

  //       Future<QuerySnapshot> images = getListImage(data: data, id: element.id);

  //       images.then((value) => value.docs.forEach((element) {
  //             if (element.get("image").toString().isNotEmpty)
  //               img.add(element.get("image"));
  //           }));
  //       dynamic avg = 0.0;
  //       List<String> avgs = [];
  //       avgs.add("0");
  //       Future<QuerySnapshot> ratings =
  //           getListRating(data: data, id: element.id);
  //       ratings.then((value) => value.docs.forEach((element) {
  //             if (element.get("rating").toString().isNotEmpty) {
  //               avg = avg +
  //                   double.parse(element.get("rating").toString()) /
  //                       (5 * value.docs.length);
  //               avgs.add(avg.toString());
  //             }
  //           }));
  //       vegesData = Product(
  //         image: img,
  //         name: element.get("name"),
  //         price: element.get("price"),
  //         numlike: element.get("number_like"),
  //         like: element.get("like"),
  //         content: element.get("content"),
  //         id: element.id,
  //         catoname: "veges",
  //         avg: avgs,
  //       );
  //       newList.add(vegesData);
  //     },
  //   );
  //   veges = newList;
  //   notifyListeners();
  // }

  // List<Product> get getvegesList {
  //   return veges;
  // }

  Future<List<Product>> getAllData() async {
    List<Product> newList = [];
    List<String> nameList = ["dog", "cat", "accessory"];
    for (var name in nameList) {
      CollectionReference data = FirebaseFirestore.instance
          .collection("categoryicon")
          .doc("6sxmZb8HIV3x6ZbgmlWx")
          .collection("$name");
      QuerySnapshot shirtSnapShot = await data.get();
      shirtSnapShot.docs.forEach(
        (element) {
          if (element.get('like').toString() == "1") {
            List<String> img = [];
            img.add(element.get("image"));

            Future<QuerySnapshot> images =
                getListImage(data: data, id: element.id);

            images.then((value) => value.docs.forEach((element) {
                  if (element.get("image").toString().isNotEmpty)
                    img.add(element.get("image"));
                }));
            dynamic avg = 0.0;
            List<String> avgs = [];
            avgs.add("0");
            Future<QuerySnapshot> ratings =
                getListRating(data: data, id: element.id);
            ratings.then((value) => value.docs.forEach((element) {
                  if (element.get("rating").toString().isNotEmpty) {
                    avg = avg +
                        double.parse(element.get("rating").toString()) /
                            (5 * value.docs.length);
                    avgs.add(avg.toString());
                  }
                }));
            allData = Product(
              image: img,
              name: element.get("name"),
              price: element.get("price"),
              numlike: element.get("number_like"),
              like: element.get("like"),
              content: element.get("content"),
              id: element.id,
              catoname: name,
              avg: avgs,
            );
            newList.add(allData);
          }
        },
      );
    }
    alldata = newList;
    return newList;
  }

  Future<List<Product>> getLikeData() async {
    List<Product> newList = [];
    List<String> nameList = ["dog", "cat", "accessory"];
    for (var name in nameList) {
      CollectionReference data = FirebaseFirestore.instance
          .collection("categoryicon")
          .doc("6sxmZb8HIV3x6ZbgmlWx")
          .collection("$name");
      QuerySnapshot shirtSnapShot = await data.get();
      shirtSnapShot.docs.forEach(
        (element) {
          if (element.get('like').toString() == "1") {
            List<String> img = [];
            img.add(element.get("image"));

            Future<QuerySnapshot> images =
                getListImage(data: data, id: element.id);

            images.then((value) => value.docs.forEach((element) {
                  if (element.get("image").toString().isNotEmpty) {
                    img.add(element.get("image"));
                  }
                }));
            dynamic avg = 0.0;
            List<String> avgs = [];
            avgs.add("0");
            Future<QuerySnapshot> ratings =
                getListRating(data: data, id: element.id);
            ratings.then((value) => value.docs.forEach((element) {
                  if (element.get("rating").toString().isNotEmpty) {
                    avg = avg +
                        double.parse(element.get("rating").toString()) /
                            (5 * value.docs.length);
                    avgs.add(avg.toString());
                  }
                }));
            likeData = Product(
              image: img,
              name: element.get("name"),
              price: element.get("price"),
              numlike: element.get("number_like"),
              like: element.get("like"),
              content: element.get("content"),
              id: element.id,
              catoname: name,
              avg: avgs,
            );
            newList.add(likeData);
          }
        },
      );
    }
    like = newList;
    return newList;
  }

  List<Product> get getlikeList {
    return like;
  }

  Future<QuerySnapshot> getListImage(
      {required CollectionReference data, required String id}) {
    return data.doc(id).collection("listImage").get();
  }

  Future<QuerySnapshot> getListRating(
      {required CollectionReference data, required String id}) {
    return data.doc(id).collection("rating").get();
  }

  void checkUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _uid = prefs.getString('uid').toString();
    notifyListeners();
  }

  void getCheckOutData({
    required int quantity,
    required num price,
    required String name,
    required String size,
    required String image,
    required String id,
  }) {
    bool check = true;
    if (checkOutModelList.isNotEmpty) {
      checkOutModelList.forEach((element) {
        if (element.id == id) {
          element.quantity += quantity;
          if (FirebaseAuth.instance.currentUser != null) {
            CollectionReference likeRef = FirebaseFirestore.instance
                .collection("User")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection("cart");
            likeRef.doc(element.id).set(CartModel.toMap(element));
          }
          check = false;
        }
      });
      if (check) {
        checkOutModel = CartModel(
          size: size,
          price: price,
          name: name,
          image: image,
          quantity: quantity,
          id: id,
        );
        if (FirebaseAuth.instance.currentUser != null) {
          CollectionReference likeRef = FirebaseFirestore.instance
              .collection("User")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection("cart");
          likeRef.doc(checkOutModel.id).set(CartModel.toMap(checkOutModel));
        }
        checkOutModelList.add(checkOutModel);
      }
    } else {
      checkOutModel = CartModel(
        size: size,
        price: price,
        name: name,
        image: image,
        quantity: quantity,
        id: id,
      );
      if (FirebaseAuth.instance.currentUser != null) {
        CollectionReference likeRef = FirebaseFirestore.instance
            .collection("User")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("cart");
        likeRef.doc(checkOutModel.id).set(CartModel.toMap(checkOutModel));
      }
      checkOutModelList.add(checkOutModel);
    }
  }

  List<CartModel> get getCheckOutModelList {
    return List.from(checkOutModelList);
  }

  Future<void> getidloveData({required String id}) async {
    List<String> newList = [];
    try {
      CollectionReference data = FirebaseFirestore.instance
          .collection("User")
          .doc("$id")
          .collection("like");
      QuerySnapshot shirtSnapShot = await data.get();
      shirtSnapShot.docs.forEach((element) {
        idloveData = element.get("idproduct");
        newList.add(idloveData);
      });
    } catch (e) {}
    idlove = newList;
    notifyListeners();
  }

  List<String> get getidloveList {
    return idlove;
  }

  Future<void> getListLove({required List<String> listId}) async {
    List<Product> newList = [];
    List<String> nameList = ["dog", "cat", "accessory"];
    for (var name in nameList) {
      CollectionReference data = FirebaseFirestore.instance
          .collection("categoryicon")
          .doc("6sxmZb8HIV3x6ZbgmlWx")
          .collection("$name");
      QuerySnapshot shirtSnapShot = await data.get();
      shirtSnapShot.docs.forEach(
        (element) {
          listId.forEach((elements) {
            if (element.id == elements) {
              List<String> img = [];
              img.add(element.get("image"));

              Future<QuerySnapshot> images =
                  getListImage(data: data, id: element.id);

              images.then((value) => value.docs.forEach((element) {
                    if (element.get("image").toString().isNotEmpty)
                      img.add(element.get("image"));
                  }));
              dynamic avg = 0.0;
              List<String> avgs = [];
              avgs.add("0");
              Future<QuerySnapshot> ratings =
                  getListRating(data: data, id: element.id);
              ratings.then((value) => value.docs.forEach((element) {
                    if (element.get("rating").toString().isNotEmpty) {
                      avg = avg +
                          double.parse(element.get("rating").toString()) /
                              (5 * value.docs.length);
                      avgs.add(avg.toString());
                    }
                  }));
              loveData = Product(
                image: img,
                name: element.get("name"),
                price: element.get("price"),
                numlike: element.get("number_like"),
                like: element.get("like"),
                content: element.get("content"),
                id: element.id,
                catoname: name,
                avg: avgs,
              );
              newList.add(loveData);
            }
          });
        },
      );
    }
    love = newList;
    notifyListeners();
  }

  List<Product> get getloveList {
    return love;
  }

  Future<String> getName({required String id}) async {
    String addname = '';
    List<String> nameList = ["dog", "cat", "accessory"];
    for (var name in nameList) {
      CollectionReference data = FirebaseFirestore.instance
          .collection("categoryicon")
          .doc("6sxmZb8HIV3x6ZbgmlWx")
          .collection("$name");
      QuerySnapshot shirtSnapShot = await data.get();
      shirtSnapShot.docs.forEach((element) {
        if (element.id == id) {
          addname = name;
        }
      });
    }
    return addname;
  }

  Future<void> addLove({required String id, required String idproduct}) async {
    await FirebaseFirestore.instance
        .collection("User")
        .doc("$id")
        .collection("like")
        .doc("$idproduct")
        .set({
          'idproduct': idproduct,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> deleteLove(
      {required String id, required String idproduct}) async {
    await FirebaseFirestore.instance
        .collection("User")
        .doc("$id")
        .collection("like")
        .doc("$idproduct")
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  Future<List<Product>> getListLoves({required List<String> listId}) async {
    List<Product> newList = [];
    List<String> nameList = ["dog", "cat", "accessory"];

    for (var name in nameList) {
      CollectionReference data = FirebaseFirestore.instance
          .collection("categoryicon")
          .doc("6sxmZb8HIV3x6ZbgmlWx")
          .collection("$name");
      QuerySnapshot shirtSnapShot = await data.get();
      shirtSnapShot.docs.forEach(
        (element) {
          listId.forEach((elements) {
            if (element.id == elements) {
              List<String> img = [];
              img.add(element.get("image"));
              Future<QuerySnapshot> images =
                  getListImage(data: data, id: element.id);

              images.then((value) => value.docs.forEach((element) {
                    if (element.get("image").toString().isNotEmpty)
                      img.add(element.get("image"));
                  }));
              dynamic avg = 0.0;
              List<String> avgs = [];
              avgs.add("0");
              Future<QuerySnapshot> ratings =
                  getListRating(data: data, id: element.id);
              ratings.then((value) => value.docs.forEach((element) {
                    if (element.get("rating").toString().isNotEmpty) {
                      avg = avg +
                          double.parse(element.get("rating").toString()) /
                              (5 * value.docs.length);
                      avgs.add(avg.toString());
                    }
                  }));
              loveData = Product(
                image: img,
                name: element.get("name"),
                price: element.get("price"),
                numlike: element.get("number_like"),
                like: element.get("like"),
                content: element.get("content"),
                id: element.id,
                catoname: name,
                avg: avgs,
              );
              newList.add(loveData);
            }
          });
        },
      );
    }

    return newList;
  }

  Future<List<News>> getAllNewsData() async {
    List<News> newList = [];
    CollectionReference data = FirebaseFirestore.instance.collection("new");
    QuerySnapshot shirtSnapShot = await data.get();
    shirtSnapShot.docs.forEach(
      (element) {
        print("User Deleted");
        log(element.data().toString());
        allnewsData = News(
          contents: element.get("content"),
          image: element.get("image"),
          star: element.get("star"),
          hlihgts: element.get("highlights"),
          hot: element.get("hot"),
          id: element.id,
          title: element.get("title"),
        );
        newList.add(allnewsData);
      },
    );
    allnewsdata = newList;
    return allnewsdata;
  }

  Future<List<Sliders>> getSliderData() async {
    List<Sliders> newList = [];
    CollectionReference data = FirebaseFirestore.instance.collection("slider");
    QuerySnapshot shirtSnapShot = await data.get();
    shirtSnapShot.docs.forEach(
      (element) {
        slidersData = Sliders(
          image: element.get("image"),
          name: element.get("name"),
          id: element.id,
        );
        newList.add(slidersData);
      },
    );
    sliders = newList;
    return sliders;
  }

  Future<List<UserModel>> getUserData({required String id}) async {
    List<UserModel> newList = [];
    UserModel user;
    CollectionReference data = FirebaseFirestore.instance.collection("User");
    QuerySnapshot shirtSnapShot = await data.get();
    shirtSnapShot.docs.forEach(
      (element) {
        if (element.id == id) {
          user = UserModel(
              email: element.get("UserEmail"),
              gender: element.get("UserGender"),
              name: element.get("UserName"),
              id: id,
              avt: element.get("avtar"),
              address: element.get("address"),
              phone: element.get("phone"));
          newList.add(user);
        }
      },
    );
    return newList;
  }

  Future<List<UserModel>> getUserList() async {
    List<UserModel> newList = [];
    UserModel user;
    CollectionReference data = FirebaseFirestore.instance.collection("User");
    QuerySnapshot shirtSnapShot = await data.get();
    shirtSnapShot.docs.forEach(
      (element) {
        user = UserModel(
            email: element.get("UserEmail"),
            gender: element.get("UserGender"),
            name: element.get("UserName"),
            id: element.id,
            avt: element.get("avtar"),
            address: element.get("address"),
            phone: element.get("phone"));
        newList.add(user);
      },
    );
    return newList;
  }

  Future<void> getAvtData({required String id}) async {
    List<UserModel> newList = [];
    CollectionReference data = FirebaseFirestore.instance.collection("User");
    QuerySnapshot shirtSnapShot = await data.get();
    shirtSnapShot.docs.forEach(
      (element) {
        if (element.id == id) {
          user = UserModel(
              email: element.get("UserEmail"),
              gender: element.get("UserGender"),
              name: element.get("UserName"),
              id: id,
              avt: element.get("avtar"),
              address: element.get("address"),
              phone: element.get("phone"));
          newList.add(user);
        }
      },
    );
    users = newList;
    notifyListeners();
  }

  String get getavt {
    return users.elementAt(0).avt;
  }

  Future<void> getSlidersData() async {
    List<Sliders> newList = [];
    CollectionReference data = FirebaseFirestore.instance.collection("slider");
    QuerySnapshot shirtSnapShot = await data.get();
    shirtSnapShot.docs.forEach(
      (element) {
        slidersData = Sliders(
          image: element.get("image"),
          name: element.get("name"),
          id: element.id,
        );
        newList.add(slidersData);
      },
    );
    sliders = newList;
  }

  List<Sliders> get getslidersList {
    return sliders;
  }

  Future<List<BillModel>> getBillData() async {
    List<BillModel> newList = [];

    CollectionReference data = FirebaseFirestore.instance
        .collection("User")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("bill");
    QuerySnapshot shirtSnapShot = await data.get();
    shirtSnapShot.docs.forEach(
      (element) {
        List<CartModel> cartlt = [];
        Future<QuerySnapshot> snapShot =
            data.doc(element.id).collection("cart").get();
        snapShot.then((value) => value.docs.forEach((e) {
              cartnew = CartModel(
                size: e.get("size"),
                price: e.get("price"),
                name: e.get("name"),
                image: e.get("image"),
                quantity: e.get("quantity"),
                id: e.get("id"),
              );
              cartlt.add(cartnew);
            }));
        billnew = BillModel(
            address: element.get("address"),
            codebill: element.get("codebill"),
            date: element.get("date"),
            phone: element.get("phone"),
            name: element.get("name"),
            postcode: element.get("postcode"),
            status: element.get("status"),
            price: element.get("price"),
            item: element.get("item"),
            phoneship: element.get("phoneship"),
            cart: cartlt);
        newList.add(billnew);
      },
    );
    return newList;
  }

  Future<List<BillModel>> getBillId(String id) async {
    List<BillModel> newList = [];
    CollectionReference data = FirebaseFirestore.instance
        .collection("User")
        .doc(id)
        .collection("bill");
    QuerySnapshot shirtSnapShot = await data.get();
    shirtSnapShot.docs.forEach(
      (element) {
        List<CartModel> cartlt = [];
        Future<QuerySnapshot> snapShot =
            data.doc(element.id).collection("cart").get();
        snapShot.then((value) => value.docs.forEach((e) {
              cartnew = CartModel(
                size: e.get("size"),
                price: e.get("price"),
                name: e.get("name"),
                image: e.get("image"),
                quantity: e.get("quantity"),
                id: e.get("id"),
              );
              cartlt.add(cartnew);
            }));
        billnew = BillModel(
            address: element.get("address"),
            codebill: element.get("codebill"),
            date: element.get("date"),
            phone: element.get("phone"),
            name: element.get("name"),
            postcode: element.get("postcode"),
            status: element.get("status"),
            price: element.get("price"),
            item: element.get("item"),
            phoneship: element.get("phoneship"),
            cart: cartlt);
        newList.add(billnew);
      },
    );
    return newList;
  }

  Future<List<String>> checkRating(String idUser, Product idProduct) async {
    List<String> datas = [];
    bool check = true;
    dynamic rating = '1';
    dynamic cmt = "";
    dynamic time = DateTime.now().toString();
    CollectionReference data = FirebaseFirestore.instance
        .collection("categoryicon")
        .doc("6sxmZb8HIV3x6ZbgmlWx")
        .collection(idProduct.catoname)
        .doc(idProduct.id)
        .collection('rating');
    QuerySnapshot shirtSnapShot = await data.get();
    if (shirtSnapShot.docs.isNotEmpty) {
      shirtSnapShot.docs.forEach(
        (element) {
          if (element.id.contains(idUser)) {
            check = false;
            rating = element.get('rating').toString();
            cmt = element.get('cmt').toString;
            time = element.get('time').toString();
          }
        },
      );
    }
    if (check) {
      FirebaseFirestore.instance
          .collection("categoryicon")
          .doc("6sxmZb8HIV3x6ZbgmlWx")
          .collection(idProduct.catoname)
          .doc(idProduct.id)
          .collection('rating')
          .doc(idUser)
          .set({'rating': 1, 'cmt': '', 'time': DateTime.now().toString()});
    }
    datas.add(rating.toString());
    datas.add(cmt.toString());
    datas.add(time.toString());
    return datas;
  }

  Future<List<Product>> getProductRecom({required String listid}) async {
    String listids = listid.substring(1, (listid.trim().length - 1));
    String result = listids.replaceAll('"', '');
    final List<String> listidnew = result.split(',');

    List<Product> newList = [];
    List<String> nameList = ["dog", "cat", "accessory"];
    for (var name in nameList) {
      CollectionReference data = FirebaseFirestore.instance
          .collection("categoryicon")
          .doc("6sxmZb8HIV3x6ZbgmlWx")
          .collection("$name");
      QuerySnapshot shirtSnapShot = await data.get();
      shirtSnapShot.docs.forEach((element) {
        listidnew.forEach((d) {
          if (element.id.contains(d.trim())) {
            List<String> img = [];
            img.add(element.get("image"));
            Future<QuerySnapshot> images =
                getListImage(data: data, id: element.id);
            images.then((value) => value.docs.forEach((element) {
                  if (element.get("image").toString().isNotEmpty)
                    img.add(element.get("image"));
                }));
            dynamic avg = 0.0;
            List<String> avgs = [];
            avgs.add("0");
            Future<QuerySnapshot> ratings =
                getListRating(data: data, id: element.id);
            ratings.then((value) => value.docs.forEach((element) {
                  if (element.get("rating").toString().isNotEmpty) {
                    avg = avg +
                        double.parse(element.get("rating").toString()) /
                            (5 * value.docs.length);
                    avgs.add(avg.toString());
                  }
                }));
            recommenderData = Product(
              image: img,
              name: element.get("name"),
              price: element.get("price"),
              numlike: element.get("number_like"),
              like: element.get("like"),
              content: element.get("content"),
              id: element.id,
              catoname: name,
              avg: avgs,
            );
            newList.add(recommenderData);
          }
        });
      });
    }
    return newList;
  }

  String getGender() {
    getGenders();
    return _gender;
  }

  void getGenders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _gender = prefs.getString('gender') ?? "";
    notifyListeners();
  }

  void addGenders(String gender) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _gender = gender;
    prefs.setString("gender", _gender);
    notifyListeners();
  }

// getAvatarUrlForProfile() async {
//   Reference ref = FirebaseStorage.instance
//       .ref()
//       .child("images")
//       .child('/listmenu')
//       .child("snack1.jpg");

//   //get image url from firebase storage
//   var url = await ref.getDownloadURL();

//   // put the URL in the state, so that the UI gets rerendered
//   print(url);
// }
}

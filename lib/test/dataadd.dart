import 'dart:convert';

import 'package:apporder/models/provinces.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> tinh = [];
  List<String> huyen = [];
  List<String> xa = [];
  List<Provinces> myList = [];
  final TextEditingController tinhT = TextEditingController();
  final TextEditingController huyenT = TextEditingController();
  final TextEditingController xaT = TextEditingController();
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/country.json');
    setState(() {
      List<Provinces> myLists = [];
      if (response.isNotEmpty) {
        myLists = (json.decode(response) as List<dynamic>)
            .map<Provinces>((item) => Provinces.fromJson(item))
            .toList();
        myList = myLists;
      }
    });
  }

  Map<String, dynamic> formData = {};

  @override
  void initState() {
    super.initState();
    readJson();
  }

  Future<List<Provinces>> categoryList() async {
    return myList;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Order Food',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        // ignore: deprecated_member_use, prefer_const_constructors
        accentColor: Color(0xFFFEF9EB),
      ),
      // ignore: prefer_const_constructors
      home: Scaffold(
        body: StreamBuilder<List<Provinces>>(
            stream: categoryList().asStream(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              tinh = [];
              if (snapshot.data!.isNotEmpty) {
                snapshot.data!.asMap().forEach((index, element) {
                  tinh.add(element.name);
                });
              }
              return Column(
                children: [
                  Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: TextField(
                                controller: tinhT,
                                decoration: const InputDecoration(
                                  labelText: 'ngu',
                                  errorText: 'ngoc',
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    print(value);
                                    huyen = [];
                                    if (snapshot.data!.isNotEmpty) {
                                      snapshot.data!
                                          .asMap()
                                          .forEach((index, element) {
                                        if (element.name == value) {
                                          for (var elements in element.districts) {
                                            huyen.add(elements.name);
                                          }
                                        }
                                      });
                                    }
                                  });
                                },
                              )),
                              PopupMenuButton<String>(
                                icon: const Icon(Icons.arrow_drop_down),
                                onSelected: (String value) {
                                  setState(() {
                                    huyenT.text = '';
                                    xaT.text = '';
                                    huyen = [];
                                    xa = [];
                                    if (snapshot.data!.isNotEmpty) {
                                      snapshot.data!
                                          .asMap()
                                          .forEach((index, element) {
                                        if (element.name == value) {
                                          for (var elements in element.districts) {
                                            huyen.add(elements.name);
                                          }
                                        }
                                      });
                                    }
                                  });
                                  tinhT.text = value;
                                },
                                itemBuilder: (BuildContext context) {
                                  return tinh.map<PopupMenuItem<String>>(
                                      (String value) {
                                    return PopupMenuItem(
                                        child: Text(value), value: value);
                                  }).toList();
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: TextField(
                                controller: huyenT,
                                decoration: const InputDecoration(
                                    labelText: 'ngu', errorText: 'ngoc'),
                                onChanged: (value) {
                                  setState(() {
                                    xa = [];
                                    if (snapshot.data!.isNotEmpty) {
                                      snapshot.data!
                                          .asMap()
                                          .forEach((index, element) {
                                        if (element.name == tinhT.text) {
                                          for (var elements in element.districts) {
                                            if (elements.name == value) {
                                              for (var elementss in elements.wards) {
                                                xa.add(elementss.name);
                                              }
                                            }
                                          }
                                        }
                                      });
                                    }
                                  });
                                },
                              )),
                              PopupMenuButton<String>(
                                icon: const Icon(Icons.arrow_drop_down),
                                onSelected: (String value) {
                                  setState(() {
                                    xaT.text = '';
                                    xa = [];
                                    if (snapshot.data!.isNotEmpty) {
                                      snapshot.data!
                                          .asMap()
                                          .forEach((index, element) {
                                        if (element.name == tinhT.text) {
                                          for (var elements in element.districts) {
                                            if (elements.name == value) {
                                              for (var elementss in elements.wards) {
                                                xa.add(elementss.name);
                                              }
                                            }
                                          }
                                        }
                                      });
                                    }
                                  });
                                  huyenT.text = value;
                                },
                                itemBuilder: (BuildContext context) {
                                  return huyen.map<PopupMenuItem<String>>(
                                      (String value) {
                                    return PopupMenuItem(
                                        child: Text(value), value: value);
                                  }).toList();
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: TextField(
                                controller: xaT,
                                decoration: const InputDecoration(
                                    labelText: 'ngu', errorText: 'ngoc'),
                                onChanged: (value) {},
                              )),
                              PopupMenuButton<String>(
                                icon: const Icon(Icons.arrow_drop_down),
                                onSelected: (String value) {
                                  xaT.text = value;
                                },
                                itemBuilder: (BuildContext context) {
                                  return xa.map<PopupMenuItem<String>>(
                                      (String value) {
                                    return PopupMenuItem(
                                        child: Text(value), value: value);
                                  }).toList();
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}

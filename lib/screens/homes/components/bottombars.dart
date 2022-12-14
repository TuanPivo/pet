// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;
    var extraLargeScreenGrid = currentWidth > 1536;
    var largeScreenGrid = currentWidth > 1366;
    var smallScreenGrid = currentWidth > 1201;
    var tabScreenGrid = currentWidth > 769;

    return Container(
      padding: EdgeInsets.only(
          left: largeScreenGrid
              ? 50.0
              : smallScreenGrid
                  ? 40.0
                  : tabScreenGrid
                      ? 10.0
                      : 10.0,
          top: 20.0,
          right: largeScreenGrid
              ? 100.0
              : smallScreenGrid
                  ? 40.0
                  : tabScreenGrid
                      ? 10.0
                      : 10.0,
          bottom: 30.0),
      color: Colors.black12.withOpacity(0.05),
      child: GridView.count(
        crossAxisCount: smallScreenGrid ? 4 : 1,
        childAspectRatio: extraLargeScreenGrid
            ? 1.0
            : largeScreenGrid
                ? 1.0
                : smallScreenGrid
                    ? 1.0
                    : tabScreenGrid
                        ? 2.6
                        : 1.6,
        mainAxisSpacing: smallScreenGrid ? 25.0 : 10.0,
        crossAxisSpacing: smallScreenGrid ? 25.0 : 10.0,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.radar_sharp,
                    size: currentWidth <= 370
                        ? 15.0
                        : currentWidth <= 400
                            ? 30
                            : 45.0,
                    color: Colors.indigo[600],
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 05.0, top: 05.0),
                    child: Text(
                      'PET SHOP',
                      style: TextStyle(
                          fontSize: currentWidth <= 370
                              ? 9.0
                              : currentWidth <= 400
                                  ? 20
                                  : 30.0,
                          color: Colors.indigo[600],
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 08.0, top: 10.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.mail_outline, color: Colors.grey, size: 20.0),
                    Padding(
                      padding: EdgeInsets.only(left: 05.0),
                      child: Text(
                        'support@shopsnine.com',
                        style: TextStyle(
                          fontSize: currentWidth <= 370
                              ? 7.0
                              : currentWidth <= 400
                                  ? 12
                                  : 15.0,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    left: 08.0,
                    top: currentWidth <= 370
                        ? 0.0
                        : currentWidth <= 400
                            ? 10
                            : 20.0),
                child: Row(
                  children: [
                    Icon(Icons.phone, color: Colors.grey, size: 20.0),
                    Padding(
                      padding: EdgeInsets.only(left: 05.0),
                      child: Text(
                        '+032 309 830987',
                        style: TextStyle(
                          fontSize: currentWidth <= 370
                              ? 8.0
                              : currentWidth <= 400
                                  ? 12.0
                                  : 15.0,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    left: 08.0,
                    top: currentWidth <= 370
                        ? 0.0
                        : currentWidth <= 400
                            ? 7
                            : 20.0),
                child: Row(
                  children: [
                    Icon(Icons.mail_outline, color: Colors.grey, size: 20.0),
                    Padding(
                      padding: EdgeInsets.only(left: 05.0),
                      child: Text(
                        '032 309 830987',
                        style: TextStyle(
                          fontSize: currentWidth <= 370
                              ? 9.0
                              : currentWidth <= 400
                                  ? 12
                                  : 15.0,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              currentWidth <= 500
                  ? Container()
                  : Container(
                      padding: EdgeInsets.only(
                          left: 08.0,
                          top: currentWidth <= 370
                              ? 0.0
                              : currentWidth <= 400
                                  ? 10.0
                                  : 20.0),
                      child: Row(
                        children: [
                          Icon(Icons.rotate_left_outlined,
                              color: Colors.grey, size: 20.0),
                          Padding(
                            padding: EdgeInsets.only(left: 05.0),
                            child: Text(
                              '30 Days return',
                              style: TextStyle(
                                fontSize: currentWidth <= 370
                                    ? 9.0
                                    : currentWidth <= 400
                                        ? 12
                                        : 15.0,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
              currentWidth <= 500
                  ? Container()
                  : Container(
                      padding: EdgeInsets.only(
                          left: 10.0,
                          top: currentWidth <= 370
                              ? 0.0
                              : currentWidth <= 400
                                  ? 10.0
                                  : 20.0),
                      child: Row(
                        children: [
                          Icon(Icons.tab, color: Colors.grey, size: 20.0),
                          Padding(
                            padding: EdgeInsets.only(left: 05.0),
                            child: Text(
                              'Free Shipping',
                              style: TextStyle(
                                fontSize: currentWidth <= 370
                                    ? 9.0
                                    : currentWidth <= 400
                                        ? 12
                                        : 15.0,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 08.0, top: 15.0),
                alignment: Alignment.topLeft,
                child: Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    left: 08.0,
                    top: currentWidth <= 370
                        ? 0.0
                        : currentWidth <= 400
                            ? 10.0
                            : 20.0),
                alignment: Alignment.topLeft,
                child: Text(
                  "Dog",
                  style: TextStyle(
                    fontSize: currentWidth <= 370
                        ? 9.0
                        : currentWidth <= 400
                            ? 12
                            : 15.0,
                    color: Colors.grey,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    left: 08.0,
                    top: currentWidth <= 370
                        ? 0.0
                        : currentWidth <= 400
                            ? 10.0
                            : 20.0),
                alignment: Alignment.topLeft,
                child: Text(
                  'Cat',
                  style: TextStyle(
                    fontSize: currentWidth <= 370
                        ? 9.0
                        : currentWidth <= 400
                            ? 12
                            : 15.0,
                    color: Colors.grey,
                  ),
                ),
              ),
              currentWidth <= 500
                  ? Container()
                  : Container(
                      padding: EdgeInsets.only(
                          left: 08.0,
                          top: currentWidth <= 370
                              ? 0.0
                              : currentWidth <= 400
                                  ? 10.0
                                  : 20.0),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Accsessory',
                        style: TextStyle(
                          fontSize: currentWidth <= 370
                              ? 9.0
                              : currentWidth <= 400
                                  ? 12
                                  : 15.0,
                          color: Colors.grey,
                        ),
                      ),
                    ),
            ],
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 08.0, top: 15.0),
                alignment: Alignment.topLeft,
                child: Text(
                  'About Us',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    left: 08.0,
                    top: currentWidth <= 370
                        ? 0.0
                        : currentWidth <= 400
                            ? 10.0
                            : 20.0),
                alignment: Alignment.topLeft,
                child: Text(
                  'About Us',
                  style: TextStyle(
                    fontSize: currentWidth <= 370
                        ? 9.0
                        : currentWidth <= 400
                            ? 12
                            : 15.0,
                    color: Colors.grey,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    left: 08.0,
                    top: currentWidth <= 370
                        ? 0.0
                        : currentWidth <= 400
                            ? 10.0
                            : 20.0),
                alignment: Alignment.topLeft,
                child: Text(
                  'Terms & Conditions',
                  style: TextStyle(
                    fontSize: currentWidth <= 370
                        ? 9.0
                        : currentWidth <= 400
                            ? 12
                            : 15.0,
                    color: Colors.grey,
                  ),
                ),
              ),
              currentWidth <= 500
                  ? Container()
                  : Container(
                      padding: EdgeInsets.only(
                          left: 08.0,
                          top: currentWidth <= 370
                              ? 0.0
                              : currentWidth <= 400
                                  ? 10.0
                                  : 20.0),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Return & Exchanges',
                        style: TextStyle(
                          fontSize: currentWidth <= 370
                              ? 9.0
                              : currentWidth <= 400
                                  ? 12
                                  : 15.0,
                          color: Colors.grey,
                        ),
                      ),
                    ),
              currentWidth <= 500
                  ? Container()
                  : Container(
                      padding: EdgeInsets.only(
                          left: 08.0,
                          top: currentWidth <= 370
                              ? 0.0
                              : currentWidth <= 400
                                  ? 10.0
                                  : 20.0),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Support',
                        style: TextStyle(
                          fontSize: currentWidth <= 370
                              ? 9.0
                              : currentWidth <= 400
                                  ? 12
                                  : 15.0,
                          color: Colors.grey,
                        ),
                      ),
                    ),
              currentWidth <= 500
                  ? Container()
                  : Container(
                      padding: EdgeInsets.only(
                          left: 08.0,
                          top: currentWidth <= 370
                              ? 0.0
                              : currentWidth <= 400
                                  ? 10.0
                                  : 20.0),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Privacy & Policy',
                        style: TextStyle(
                          fontSize: currentWidth <= 370
                              ? 9.0
                              : currentWidth <= 400
                                  ? 12
                                  : 15.0,
                          color: Colors.grey,
                        ),
                      ),
                    ),
            ],
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 08.0, top: 15.0),
                alignment: Alignment.topLeft,
                child: Text(
                  'Join us',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    left: 08.0,
                    top: currentWidth <= 370
                        ? 0.0
                        : currentWidth <= 400
                            ? 10.0
                            : 20.0),
                child: Row(
                  children: [
                    Icon(Icons.facebook,
                        color: Colors.indigo,
                        size: currentWidth <= 370
                            ? 9.0
                            : currentWidth <= 400
                                ? 15.0
                                : 20.0),
                    Padding(
                      padding: EdgeInsets.only(left: 05.0),
                      child: Text(
                        'Facebook',
                        style: TextStyle(
                          fontSize: currentWidth <= 370
                              ? 9.0
                              : currentWidth <= 400
                                  ? 12
                                  : 15.0,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    left: 08.0,
                    top: currentWidth <= 370
                        ? 0.0
                        : currentWidth <= 400
                            ? 10.0
                            : 20.0),
                child: Row(
                  children: [
                    Icon(FontAwesomeIcons.twitter,
                        color: Colors.blue,
                        size: currentWidth <= 370
                            ? 9.0
                            : currentWidth <= 400
                                ? 15.0
                                : 20.0),
                    Padding(
                      padding: EdgeInsets.only(left: 05.0),
                      child: Text(
                        'Twitter',
                        style: TextStyle(
                          fontSize: currentWidth <= 370
                              ? 9.0
                              : currentWidth <= 400
                                  ? 12
                                  : 15.0,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              currentWidth <= 500
                  ? Container()
                  : Container(
                      padding: EdgeInsets.only(
                          left: 08.0,
                          top: currentWidth <= 370
                              ? 0.0
                              : currentWidth <= 400
                                  ? 10.0
                                  : 20.0),
                      child: Row(
                        children: [
                          Icon(Icons.linked_camera,
                              color: Colors.indigo,
                              size: currentWidth <= 370
                                  ? 9.0
                                  : currentWidth <= 400
                                      ? 15.0
                                      : 20.0),
                          Padding(
                            padding: EdgeInsets.only(left: 05.0),
                            child: Text(
                              'Linkedin',
                              style: TextStyle(
                                fontSize: currentWidth <= 370
                                    ? 9.0
                                    : currentWidth <= 400
                                        ? 12
                                        : 15.0,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
              currentWidth <= 500
                  ? Container()
                  : Container(
                      padding: EdgeInsets.only(
                          left: 08.0,
                          top: currentWidth <= 370
                              ? 0.0
                              : currentWidth <= 400
                                  ? 10.0
                                  : 20.0),
                      child: Row(
                        children: [
                          Icon(Icons.youtube_searched_for,
                              color: Colors.red,
                              size: currentWidth <= 370
                                  ? 9.0
                                  : currentWidth <= 400
                                      ? 15.0
                                      : 20.0),
                          Padding(
                            padding: EdgeInsets.only(left: 05.0),
                            child: Text(
                              'Youtube',
                              style: TextStyle(
                                fontSize: currentWidth <= 370
                                    ? 9.0
                                    : currentWidth <= 400
                                        ? 12
                                        : 15.0,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
              Container(
                padding: EdgeInsets.only(
                    left: 08.0,
                    top: currentWidth <= 370
                        ? 0.0
                        : currentWidth <= 400
                            ? 10.0
                            : 20.0),
                child: Row(
                  children: [
                    Icon(Icons.insert_chart,
                        color: Colors.purple[300],
                        size: currentWidth <= 370
                            ? 9.0
                            : currentWidth <= 400
                                ? 15.0
                                : 20.0),
                    Padding(
                      padding: EdgeInsets.only(left: 05.0),
                      child: Text(
                        'Instagram',
                        style: TextStyle(
                          fontSize: currentWidth <= 370
                              ? 9.0
                              : currentWidth <= 400
                                  ? 12
                                  : 15.0,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

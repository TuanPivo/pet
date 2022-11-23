// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:apporder/responsive/responsive_screen.dart';
import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final double height, width;

  const Background({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              height: height,
              width: (width) * 0.65,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [
                      0.0,
                      0.8
                    ],
                    colors: [
                      Color.fromARGB(255, 5, 3, 5),
                      Color.fromARGB(255, 255, 173, 97)
                    ]),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: ClipPath(
              clipper: RoundedClipper1(height, (width) * 0.55),
              child: Container(
                height: height,
                width: (width) * 0.55,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      stops: [
                        0.0,
                        0.8
                      ],
                      colors: [
                        Color.fromARGB(255, 5, 3, 5),
                        Color.fromARGB(255, 255, 173, 97)
                      ]),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, 0),
            child: SizedBox(
              height: height * 0.8,
              width: width * 0.55,
              child: Stack(
                children: [
                  // Align(
                  //   alignment: Alignment(0.125, -0.8),
                  //   child: Text(
                  //     "F",
                  //     style: TextStyle(
                  //         fontSize: 75,
                  //         fontWeight: FontWeight.bold,
                  //         color: Colors.white),
                  //   ),
                  // ),
                  // Align(
                  //   alignment: Alignment(0.3, -0.4),
                  //   child: Text(
                  //     "O",
                  //     style: TextStyle(
                  //         fontSize: 75,
                  //         fontWeight: FontWeight.bold,
                  //         color: Colors.white),
                  //   ),
                  // ),
                  // Align(
                  //   alignment: Alignment(0.3, 0.2),
                  //   child: Text(
                  //     "O",
                  //     style: TextStyle(
                  //         fontSize: 75,
                  //         fontWeight: FontWeight.bold,
                  //         color: Colors.white),
                  //   ),
                  // ),
                  // Align(
                  //   alignment: Alignment(0.125, 0.85),
                  //   child: Text(
                  //     "D",
                  //     style: TextStyle(
                  //         fontSize: 75,
                  //         fontWeight: FontWeight.bold,
                  //         color: Colors.white),
                  //   ),
                  // ),
                  Align(
                    alignment: Alignment(0, 0),
                    child: SizedBox(
                      height: height * 0.55,
                      child: Responsive.isMobile(context)
                          ? Image.asset('assets/images/pet_logo.png',
                              color: Colors.white)
                          : Image.asset('./images/pet_logo.png',
                              color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RoundedClipper1 extends CustomClipper<Path> {
  final double height, width;

  RoundedClipper1(this.height, this.width);

  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, 0.0);
    path.lineTo(0.0, height);
    path.lineTo(width * 0.8, height);
    path.lineTo(width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

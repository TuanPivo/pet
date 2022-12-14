// ignore_for_file: prefer_const_constructors, unnecessary_new, unused_local_variable

import 'package:apporder/utils/custom.dart';
import 'package:flutter/material.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    this.text,
    this.image,
  }) : super(key: key);
  final String? text, image;
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Spacer(),
        Text(
          "PET MARK",
          style: TextStyle(
            fontSize: 36,
            color: Palette.animationColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          text!,
          textAlign: TextAlign.center,
        ),
        Spacer(flex: 2),
        Image.asset(
          image!,
          height: _size.height * 0.325,
          width: _size.width * 0.626,
        ),
      ],
    );
  }
}

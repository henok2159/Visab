import 'dart:ui';

import 'package:flutter/material.dart';

class BlurIcon extends StatelessWidget {
  final double width;
  final double height;
  final EdgeInsets padding;
  final Icon icon;

  BlurIcon({this.width = 32, this.height = 32,required this.icon,required this.padding});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Padding(
          padding: padding == null ? EdgeInsets.all(0) : padding,
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black38,
            ),
            child: Center(child: icon),
          ),
        ),
      ),
    );
  }
}
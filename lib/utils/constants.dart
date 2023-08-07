import 'package:flutter/material.dart';

class Constants{
  static const String aboutUs = 'About us';
  static const String termsAndConditions = 'Terms and Conditions';
  static const String signOut = 'Sign out';

  //static const String SignOut = 'Sign out';

  static const List<String> choices = <String>[

    signOut,
    aboutUs,
    termsAndConditions
  ];


  static const _shimmerGradient = LinearGradient(
    colors: [
      Color(0xFFEBEBF4),
      Color(0xFFF4F4F4),
      Color(0xFFEBEBF4),
    ],
    stops: [
      0.1,
      0.3,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );

  static get shimmerGradient => _shimmerGradient;
}
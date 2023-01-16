import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData mainTheme = ThemeData(
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(color: Colors.black54),
        backgroundColor: Colors.white,
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.grey[200],
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark)),
    scaffoldBackgroundColor: Colors.white);

import 'dart:io';

import 'package:flutter/material.dart';

void showToast(BuildContext? context, String msg,
        {double? width, bool isError = false}) =>
    ScaffoldMessenger.of(context!).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: isError ? Colors.white : Colors.black,
          ),
        ),
        duration: const Duration(milliseconds: 3000),
        elevation: 0,
        margin: width != null
            ? null
            : EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.2),
        backgroundColor: isError ? Colors.red[700] : Colors.white,
        padding: const EdgeInsets.all(10),
        width: width,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: Platform.isAndroid
              ? BorderRadius.circular(50)
              : BorderRadius.circular(10),
        ),
      ),
    );

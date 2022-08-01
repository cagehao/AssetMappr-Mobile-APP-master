/*
* Author: Haotian(Jeremy) Li
*
* Desc: This is the separation of type selection and asset Detail for Upload Page
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Separator extends StatelessWidget {
  const Separator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
      child: Container(
        width: double.infinity,
        height: 35,
        color: Colors.black12,
        alignment: Alignment.center,
        child: const Text(
          "New Asset Information",
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
/*
* Author: Haotian(Jeremy) Li
*
* Desc: This is some useful global variable for upload page Layout
*/

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Map<int, String> catgoryKey = {};
// final nameEditingController = TextEditingController();
// final noteEditingController = TextEditingController();
final nameController = TextEditingController();
final desController = TextEditingController();
final webController = TextEditingController();
final userRoleController = TextEditingController();
final userNameController = TextEditingController();

// upload info
LatLng uploadLatlng = const LatLng(0.0, 0.0);
Map<int, bool> uploadSelectedState = {};
List<String> uploadCategory = [];
bool buttonValue = true;
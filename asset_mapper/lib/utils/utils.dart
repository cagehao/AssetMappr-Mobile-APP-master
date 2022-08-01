
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


//global values
const UNIONTOWN = 4278528;
const MONONGAHELA = 4250408;
const uniontown_latitude =  39.8993024;
const uniontown_longitude = -79.7245287;
const monongahela_latitude = 40.1955304;
const monongahela_longitude = -79.9222298;

var communityId = UNIONTOWN;
final eventBus = EventBus();
late GoogleMapController uploadMapController;
var showId = 0;//the assetIndex that we show below
var dbFlag = false;

const assetTitleStyle = TextStyle(
    fontSize: 20,
    color: Colors.black,
);

const assetDescriptionStyle = TextStyle(
    fontSize: 10,
    color: Colors.black,
);
const urlLinkStyle =  TextStyle(
    decoration: TextDecoration.underline,
    color: Colors.blue,
);
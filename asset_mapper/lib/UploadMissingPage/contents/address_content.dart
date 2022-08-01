/*
* Author: Haotian(Jeremy) Li, Anna Wang
*
* Desc: This is the Address search and Show function block for Upload Page
*/

import 'package:asset_mapper/UploadPage/upload_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:asset_mapper/Model/model.dart';
import 'package:asset_mapper/utils/utils.dart';
import 'package:asset_mapper/utils/search_bar/search_bar.dart';

class AddressContent extends StatefulWidget {
  const AddressContent({Key? key}) : super(key: key);


  @override
  State<AddressContent> createState() => _AddressContentState();
}

class _AddressContentState extends State<AddressContent> {
  // late GoogleMapController uploadMapController;
  String? address;

  @override
  void initState(){
    super.initState();

    eventBus.on<AddressInfo>().listen((event) {
      setState(() {
        address = event.address;
      });
    });

    eventBus.on<LatLng>().listen((event) async {
      List<Placemark> placemarks = await placemarkFromCoordinates(event.latitude,event.longitude);
      setState(() {
        address = "${placemarks[0].street!.isEmpty?placemarks[0].name : placemarks[0].street}, ${placemarks[0].locality}, ${placemarks[0].administrativeArea}"
            "${placemarks[0].postalCode}, ${placemarks[0].isoCountryCode}";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        showAddress(address),

        const SearchBar(1),

        const MapView(),

      ],
    );
  }
}

Widget showAddress(String? add) {
  if (add == null) {
    return const Padding(
      padding:  EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
      child: Text(
        "Use the search box or click on the map "
            "to indicate the location of the asset",
        style: TextStyle(fontSize: 16),
        textAlign: TextAlign.center,
      ),
    );
  } else {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        // crossAxisAlignment:  CrossAxisAlignment.start,
        children: [
          const Text(
            "The Asset address you selected is:",
            style: TextStyle(fontSize: 16,color: Colors.blueGrey,),
          ),
          FittedBox(
            child: Text(
              add,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}


class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);


  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final CameraPosition _initialLocation = const CameraPosition(target: LatLng(39.9, -79.7));
  late Position _currentPosition;
  final Set<Marker> uploadMarker = {};

  // Method for retrieving the current location
  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        _currentPosition = position;
        uploadMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 18.0,
            ),
          ),
        );
      });
    }).catchError((e) {
      print(e);
    });
  }

  // Initialize some useful states
  @override
  void initState() {
    super.initState();
    _getCurrentLocation();

    eventBus.on<AddressInfo>().listen((event) {
      setState(() {
        uploadMarker.clear();
        uploadMarker.add(
            Marker(
              markerId: const MarkerId("upload"),
              // position: LatLng(event.longitude, event.latitude),
              position: LatLng(event.lat,event.long),
              icon: BitmapDescriptor.defaultMarker,
            )
        );
      });
    });
  }

  // Google map and 3 safe areas: zoom button, current location and checkboxes
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Stack(
        children: <Widget>[
          // Map View
          SizedBox(
            height: 300,
            child: GoogleMap(
              initialCameraPosition: _initialLocation,
              markers: uploadMarker,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              mapType: MapType.normal,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: false,
              gestureRecognizers: {
                Factory<OneSequenceGestureRecognizer> (
                      () => EagerGestureRecognizer(),
                ),
              },
              onTap: (latLong) {
                setState(() {
                  uploadMarker.clear();
                  uploadMarker.add(
                      Marker(
                        markerId: const MarkerId("upload"),
                        // position: LatLng(event.longitude, event.latitude),
                        position: LatLng(latLong.latitude,latLong.longitude),
                        icon: BitmapDescriptor.defaultMarker,
                      )
                  );
                });
                eventBus.fire(latLong);
              },
              onMapCreated: (GoogleMapController controller) {
                uploadMapController = controller;
              },
            ),
          ),

          SafeArea(
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
                child: ClipOval(
                  child: Material(
                    color: Colors.orange.shade100, // button color
                    child: InkWell(
                      splashColor: Colors.orange, // inkwell color
                      child: const SizedBox(
                        width: 56,
                        height: 56,
                        child: Icon(Icons.my_location),
                      ),
                      onTap: () {
                        uploadMapController.animateCamera(
                          CameraUpdate.newCameraPosition(
                            CameraPosition(
                              target: LatLng(
                                _currentPosition.latitude,
                                _currentPosition.longitude,
                              ),
                              zoom: 18.0,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Show zoom buttons
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ClipOval(
                    child: Material(
                      color: Colors.blue.shade100, // button color
                      child: InkWell(
                        splashColor: Colors.blue, // inkwell color
                        child: const SizedBox(
                          width: 50,
                          height: 50,
                          child: Icon(Icons.add),
                        ),
                        onTap: () {
                          uploadMapController.animateCamera(
                            CameraUpdate.zoomIn(),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ClipOval(
                    child: Material(
                      color: Colors.blue.shade100, // button color
                      child: InkWell(
                        splashColor: Colors.blue, // inkwell color
                        child: const SizedBox(
                          width: 50,
                          height: 50,
                          child: Icon(Icons.remove),
                        ),
                        onTap: () {
                          uploadMapController.animateCamera(
                            CameraUpdate.zoomOut(),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          // Show current location button
          SafeArea(
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
                child: ClipOval(
                  child: Material(
                    color: Colors.orange.shade100, // button color
                    child: InkWell(
                      splashColor: Colors.orange, // inkwell color
                      child: const SizedBox(
                        width: 56,
                        height: 56,
                        child: Icon(Icons.my_location),
                      ),
                      onTap: () {
                        uploadMapController.animateCamera(
                          CameraUpdate.newCameraPosition(
                            CameraPosition(
                              target: LatLng(
                                _currentPosition.latitude,
                                _currentPosition.longitude,
                              ),
                              zoom: 18.0,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*
* Author: XuWen Qiu, Haotian(Jeremy) Li
*
* Desc: This is the Google Map function block with filtered display function
*/

import 'package:asset_mapper/HomePage/Map/zoom_button.dart';
import 'package:asset_mapper/Model/model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:filter_list/filter_list.dart';
import 'package:asset_mapper/utils/db/assets.dart';
import 'package:asset_mapper/utils/search_bar/search_bar.dart';
import 'Info_Rating/assets_show.dart';
import 'package:asset_mapper/utils/utils.dart'; // self defined utils
import  'home_utils.dart';

import 'Map/current_location_button.dart';
import 'Map/google_map_area.dart';


// Home content using map view Widget
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  // final GlobalKey<_MapViewState> mapKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text(
            "Asset Mapper",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        body: const HomePageContent()
    );
  }
}

// Stateful MapView Widget
class HomePageContent extends StatefulWidget {
  const HomePageContent({Key? key}) : super(key: key);

  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  final CameraPosition _initialLocation =
      const CameraPosition(target: LatLng(39.9, -79.7));

  late Position _currentPosition = Position(longitude: 39.9, latitude: -79.7, timestamp: DateTime(2022), accuracy: 0.0, altitude: 0.0, heading: 0.0, speed: 0.0, speedAccuracy: 0.0);

  final startAddressController = TextEditingController();
  final destinationAddressController = TextEditingController();

  final startAddressFocusNode = FocusNode();
  final destinationAddressFocusNode = FocusNode();

  // Markers for assets on the map
  Set<Marker> markers = {};

  // For category filter
  List<String> categoryList = [];
  List<String> selectedCategoryList = [];

  // Instance of assets class, storing assets database information
  Assets assetsInstance = Assets();

  void showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Community Selector"),
          actions: [
            ElevatedButton(onPressed: () async {
              communityId = UNIONTOWN;
              setState(() {});
              await assetsInstance.initializeAssetList();
              markers.clear();
              // print(assetsInstance.assetList.length);
              for (int i = 0; i < assetsInstance.assetList.length; i++) {
                  markers.add(Marker(
                      markerId: MarkerId("$i"),
                      position: LatLng(assetsInstance.assetList[i].longitude,
                          assetsInstance.assetList[i].latitude),
                      infoWindow: InfoWindow(
                          title: assetsInstance.assetList[i].assetName,
                          snippet: assetsInstance.assetList[i].snippet),
                      icon: BitmapDescriptor.defaultMarker,
                      onTap: () {
                        setState(() {
                          showId = i;
                        });
                      }));
              }
              // print(markers.length);
              mapController.animateCamera(
                  CameraUpdate.newCameraPosition(
                    const CameraPosition(
                      target: LatLng(
                        uniontown_latitude,
                        uniontown_longitude,
                      ),
                      zoom: 8.0,
                    ),
                  )
              );
              Navigator.of(context).pop();
              setState(() {});
            }, child: const Text("Uniontown")),
            ElevatedButton(onPressed: () async {
              communityId = MONONGAHELA;
              setState(() {});
              await assetsInstance.initializeAssetList();
              markers.clear();
              // print(assetsInstance.assetList.length);
              for (int i = 0; i < assetsInstance.assetList.length; i++) {
                  markers.add(Marker(
                      markerId: MarkerId("$i"),
                      position: LatLng(assetsInstance.assetList[i].longitude,
                          assetsInstance.assetList[i].latitude),
                      infoWindow: InfoWindow(
                          title: assetsInstance.assetList[i].assetName,
                          snippet: assetsInstance.assetList[i].snippet),
                      icon: BitmapDescriptor.defaultMarker,
                      onTap: () {
                        setState(() {
                          showId = i;
                        });
                      }));
              }
              // print(markers.length);
              mapController.animateCamera(
                  CameraUpdate.newCameraPosition(
                    const CameraPosition(
                      target: LatLng(
                        monongahela_latitude,
                        monongahela_longitude,
                      ),
                      zoom: 8.0,
                    ),
                  )
              );
              Navigator.of(context).pop();
              setState(() {});
            }, child: const Text("Monongahela")),
          ],
          content: const Text("Please select your community"),
        ));
  }

  void _openCommunityFilterDialog() async {
    Future.delayed(Duration.zero, () => showAlert(context));
  }

  void _openCategoryFilterDialog() async {
    await FilterListDialog.display<String>(
      context,
      hideSelectedTextCount: true,
      themeData: FilterListThemeData(context),
      headlineText: 'Select the Category',
      height: 500,
      listData: categoryList,
      selectedListData: selectedCategoryList,
      choiceChipLabel: (item) => item!,
      validateSelectedItem: (list, val) => list!.contains(val),
      controlButtons: [ContolButtonType.All, ContolButtonType.Reset],
      onItemSearch: (user, query) {
        // When search query change in search bar then this method will be called
        // Check if items contains query
        return user.toLowerCase().contains(query.toLowerCase());
      },
      onApplyButtonClick: (list) {
        setState(() {
          selectedCategoryList = List.from(list!);
        });

        markers.clear();
        for (int i = 0; i < assetsInstance.assetList.length; i++) {
          if (selectedCategoryList
              .contains(assetsInstance.assetList[i].assetCategory)) {
            markers.add(Marker(
                markerId: MarkerId("$i"),
                position: LatLng(assetsInstance.assetList[i].longitude,
                    assetsInstance.assetList[i].latitude),
                infoWindow: InfoWindow(
                    title: assetsInstance.assetList[i].assetName,
                    snippet: assetsInstance.assetList[i].snippet),
                icon: BitmapDescriptor.defaultMarker,
                onTap: () {
                  setState(() {
                    showId = i;
                  });
                }));
          }
        }
        Navigator.pop(context);
      },
    );
  }

  _readDB() async {
    await assetsInstance.initializeAssetList();

    setState(() {
      //set all checkbox as default
      for (int i = 0; i < assetsInstance.assetTypes.length; i++) {
        categoryList.add(assetsInstance.assetTypes[i]);
      }
      eventBus.fire(CategoryInfo(categoryList));
      for (int i = 0; i < assetsInstance.assetList.length; i++) {
        // Add asset locations to markers set
        markers.add(Marker(
          markerId: MarkerId("$i"),
          position: LatLng(assetsInstance.assetList[i].longitude,
              assetsInstance.assetList[i].latitude),
          infoWindow: InfoWindow(
            title: assetsInstance.assetList[i].assetName,
            snippet: assetsInstance.assetList[i].snippet,
          ),
          onTap: () {
            setState(() {
              showId = i;
            });
          },
          icon: BitmapDescriptor.defaultMarker,
        ));
      }
    });
  }

  // _uploadRating() async {
  //   var connection = PostgreSQLConnection(
  //       "dpg-c9rifejru51klv494hag-a.ohio-postgres.render.com", // hostURL
  //       5432, // port
  //       "assetmappr_database", // databaseName
  //       username: "assetmappr_database_user",
  //       password: "5uhs74LFYP5G2rsk6EGzPAptaStOb9T8",
  //       useSSL: true);
  //   await connection.open();
  //   print("Database Connected! Ready for upload");
  //   var res = connection.query("");
  //
  //   print(res);
  //   connection.close();
  // }

  // Method for retrieving the current location
  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        _currentPosition = position;
        print('CURRENT POS: $_currentPosition');
        mapController.animateCamera(
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

    if (assetsInstance.isNull()){
      _readDB();
      _getCurrentLocation();
    }
  }

  // Build function
  // Google map and 3 safe areas: zoom button, current location and checkboxes
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SearchBar(0),

                Stack(
                  children: <Widget>[
                    // Map View
                    GoogleMapArea(markers: markers, initialLocation: _initialLocation),

                    // Show zoom buttons
                    const ZoomButton(),
                    Positioned(
                      bottom: 0,
                      child: TextButton(
                      onPressed: _openCommunityFilterDialog,
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.blue)),
                      child: const Text(
                        "Community Setter",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ),



                    // Show current location button
                    CurrentLocationButton(currentPosition: _currentPosition),


                    TextButton(
                      onPressed: _openCategoryFilterDialog,
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.blue)),
                      child: const Text(
                        "Category Filter",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    //DragWidget(),
                  ],
                ),

                AssetShow(assetsInstance)
              ]
            )
          ),
        ],
      ),
    );
  }
}

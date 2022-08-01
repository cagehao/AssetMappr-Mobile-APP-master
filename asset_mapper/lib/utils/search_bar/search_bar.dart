/*
* Author: Haotian(Jeremy) Li
*
* Desc: This is the searchBar widget
* which you can input an address, this block will autoComplete the block including your input
* and return 5 top-related result
*/

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:asset_mapper/utils/search_bar/search_page.dart' as search_screen;
import 'package:asset_mapper/Model/model.dart';
import 'package:asset_mapper/HomePage/home_utils.dart';
import 'package:asset_mapper/utils/utils.dart';

// search bar widget
class SearchBar extends StatefulWidget {
  final int mapControllerId;
  const SearchBar(this.mapControllerId,{Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  // final searchbarEditingController = TextEditingController();
  List<AutocompletePrediction> predictions = [];
  late GooglePlace googlePlace;

  InputBorder getBorder(int id) {
    if (id == 0) {
      return UnderlineInputBorder();
    } else{
      return OutlineInputBorder();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(//search bar
            padding: const EdgeInsets.only(left:8.0,right:8.0,top:8.0,bottom:4.0),
            child:TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                suffixIcon: Icon(Icons.search),
              ),
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const search_screen.SearchPage()),
                );
                if (result != null) {
                  setState(() {
                    var lat = double.parse(result[0]);
                    var long = double.parse(result[1]);
                    if (widget.mapControllerId == 0) {
                      mapController.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                            target: LatLng(lat,long),
                            zoom: 15.0,
                          ),
                        ),
                      );
                    } else if (widget.mapControllerId == 1) {
                      eventBus.fire(AddressInfo(result[2],double.parse(result[0]),double.parse(result[1])));
                      uploadMapController.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                            target: LatLng(lat,long),
                            zoom: 15.0,
                          ),
                        ),
                      );
                    }
                  });
                }
                // print("done");
              },
              // onChanged: (value) async {
              //   var googlePlace = GooglePlace(secret.Secrets.API_KEY);
              //   var result = await googlePlace.autocomplete.get(value);
              // },
            )
        ),
      ],
    );
  }
}
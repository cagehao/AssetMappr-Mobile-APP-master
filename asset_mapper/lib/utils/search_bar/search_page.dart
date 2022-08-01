/*
* Author: Haotian(Jeremy) Li
*
* Desc: This is Layout of searchPage
*/

import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';
import 'package:asset_mapper/secret.dart' as secret;


class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  GooglePlace googlePlace = GooglePlace(secret.Secrets.API_KEY);
  List<AutocompletePrediction> predictions = [];
  late DetailsResult detailsResult;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
          title: const Text("Search Location", style: TextStyle(fontSize: 20, color: Colors.white),),
        ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(right: 20, left: 20, top: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(
                  labelText: "Search",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black54,
                      width: 2.0,
                    ),
                  ),
                ),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    autoCompleteSearch(value);
                  } else {
                    if (predictions.length > 0 && mounted) {
                      setState(() {
                        predictions = [];
                      });
                    }
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: predictions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const CircleAvatar(
                        child: Icon(
                          Icons.pin_drop,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(predictions[index].description ?? 'None'),
                      onTap: () async {
                        var id = predictions[index].placeId;
                        var result = await this.googlePlace.details.get(id!);
                        detailsResult = result!.result!;
                        var lat = detailsResult.geometry!.location!.lat.toString();
                        var long = detailsResult.geometry!.location!.lng.toString();
                        var address = detailsResult.formattedAddress!;
                        // print("${lat},${long}");
                        List<String> res = [lat, long, address];
                        Navigator.pop(context, res);
                      },
                    );
                  },
                ),
              ),

              TextButton(
                  onPressed: (){
                    Navigator.pop(context,null);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  child: const Text(
                      "Cancel",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      )
                  )
              )
            ],
          ),
        ),
      ),
    );
  }

  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      setState(() {
        predictions = result.predictions!;
      });
    }
  }
}
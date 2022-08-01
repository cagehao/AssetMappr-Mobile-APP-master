/*
* Author: Haotian(Jeremy) Li
*
* Desc: This is the upload button for Upload Page
* TODO: Finish function for uploading data to database
*/

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:postgres/postgres.dart';

import '../../Model/model.dart';
import '../../UploadPage/upload_utils.dart';
import '../../utils/utils.dart';
import 'package:uuid/uuid.dart';

class UploadButton extends StatefulWidget {
  bool hasName;
  UploadButton(this.hasName, {Key? key}) : super(key: key);

  @override
  State<UploadButton> createState() => _UploadButtonState();
}

class _UploadButtonState extends State<UploadButton> {

  @override
  void initState() {
    super.initState();

    eventBus.on<LatLng>().listen((event) {
      uploadLatlng = event;
    });

    eventBus.on<AddressInfo>().listen((event) {
      uploadLatlng = LatLng(event.lat, event.long);
    });

    eventBus.on<UploadCategory>().listen((event) {
      uploadSelectedState = event.checkBoxState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue),
          ),
          onPressed: () async {

            var assetID = Uuid();
            var assetType = "Tangible";
            var communityGeoId = '123'; //TODO: change it based on choosing community id
            var sourceType = "User";
            var userName = userNameController.text;
            var userRole = userRoleController.text;
            var userLoadIP = '123test';
            var TIMESTAMP = DateTime.now().millisecondsSinceEpoch;
            var assetAddress;
            var assetName = nameController.text;
            var assetDes = desController.text;
            var assetWeb = webController.text;
            var long = uploadLatlng.longitude;
            var lat = uploadLatlng.latitude;

            uploadCategory = [];
            for (var key in uploadSelectedState.keys) {
              if (uploadSelectedState[key] == true) {
                uploadCategory.add(catgoryKey[key] ?? "Unknown category");
              }
            }

            print(assetName);
            if (assetName!.isEmpty) {

              _uploadPopUpWindow(
                context,
                'Please enter the name of the asset!',
                'You missed some important information!'
              );

            } else if (uploadLatlng == const LatLng(0.0, 0.0)) {

              _uploadPopUpWindow(
                context,
                'Please mark on the map to provide the address information!',
                'You missed some important information!'
              );

            } else if (uploadCategory.isEmpty) {

              _uploadPopUpWindow(
                context,
                'Please select at least one main category!',
                'You missed some important information!'
              );

            } else {
              // TODO: data upload function
              var connection = PostgreSQLConnection(
                  "dpg-c9rifejru51klv494hag-a.ohio-postgres.render.com", // hostURL
                  5432, // port
                  "assetmappr_database", // databaseName
                  username: "assetmappr_database_user",
                  password: "5uhs74LFYP5G2rsk6EGzPAptaStOb9T8",
                  useSSL: true
              );
              await connection.open();
              print("Database Connected!");

              await connection.execute('''INSERT INTO staged_assets (staged_asset_id, asset_name, asset_type, community_geo_id, source_type, 
                               description, website, latitude, longitude, generated_timestamp, user_name, user_role, user_upload_ip, address)
                      VALUES ('${assetID}','${assetName}','${assetType}',${communityGeoId},'${sourceType}','${assetDes}','${assetWeb}',${lat},${long},TIMESTAMP '${userName}', '${userRole}', '${userLoadIP}', '${assetAddress}')''');


              _uploadPopUpWindow(
                  context,
                  'Thanks for your information!',
                  'Upload Successfully!!'
              );
            }


          },
          child: const Text(
            "Submit",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          )
      ),
    );
  }

  void _uploadPopUpWindow(BuildContext context, String info, String title) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(
            title: Text(title),
            content: Text(
                info
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ],
              ),
            ],
          ),
    );
  }
}
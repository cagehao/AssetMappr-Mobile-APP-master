
import 'package:asset_mapper/utils/db/db_utils.dart';
import 'package:postgres/postgres.dart';

import '../utils.dart';


class Asset {
  late String assetId;
  late String assetName;
  late String assetCategory;
  late String website;
  late String snippet;
  late double latitude;
  late double longitude;
  late int communityId;
  // late double address;
}

class Assets {

  List<Asset> assetList = [];
  List<String> assetTypes = [];

  initializeAssetList () async {
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
    dbFlag = true;
    categoriesMaster = await connection.query("SELECT category FROM categories_master");
    assetCategories = await connection.query("SELECT asset_id, category FROM asset_categories");
    assets = await connection.query("SELECT asset_id, asset_name, latitude, longitude, description, website, community_geo_id FROM assets");
    valuesMaster = await connection.query("SELECT value FROM values_master");
    for (int i = 0; i < categoriesMaster.length; i++) {
      if (i == 0) {
        assetTypes.clear();
      }
      assetTypes.add(categoriesMaster[i][0]);
    }
    for (int i = 0; i < assets.length; i++) {
      if (i == 0) {
        assetList.clear();
      }
      // Add asset locations to markers set
      var assetItem = Asset();
      assetItem.longitude = assets[i][2];
      assetItem.latitude = assets[i][3];
      assetItem.assetName = assets[i][1];
      assetItem.snippet = (assets[i][4] == null) ? "" : assets[i][4];
      assetItem.assetId = assets[i][0];
      assetItem.website = (assets[i][5] == null) ? "" : assets[i][5];
      assetItem.assetCategory = assetCategories[i][1];
      assetItem.communityId = assets[i][6];
      if (assetItem.communityId == communityId) {
        assetList.add(assetItem);
      }
    }
    // methods to write:
    submitAsset() {

    }
    ratingAsset() {

    }
  }

  bool isNull() {
    return assetList.isEmpty;
  }
}
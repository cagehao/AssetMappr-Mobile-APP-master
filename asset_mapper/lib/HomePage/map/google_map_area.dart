
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:asset_mapper/HomePage/home_utils.dart';
import 'package:asset_mapper/utils/size_model.dart';

class GoogleMapArea extends StatelessWidget {
  const GoogleMapArea({
    Key? key,
    required this.markers,
    required CameraPosition initialLocation,
  }) : _initialLocation = initialLocation, super(key: key);

  final Set<Marker> markers;
  final CameraPosition _initialLocation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: SizeFit.setHeightPersentage(0.65),
      // height: 435,
      height: MediaQuery.of(context).size.height * 0.65,
      child: GoogleMap(
        markers: Set<Marker>.from(markers),
        initialCameraPosition: _initialLocation,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        mapType: MapType.normal,
        zoomGesturesEnabled: true,
        zoomControlsEnabled: false,
        gestureRecognizers: {
          Factory<OneSequenceGestureRecognizer>(
                () => EagerGestureRecognizer(),
          ),
        },
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
      ),
    );
  }
}

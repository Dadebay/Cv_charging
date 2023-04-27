import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:cv_charing/app/constants/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../constants/buttons/agree_button_view.dart';
import '../../../constants/constants.dart';
import '../../../constants/text_fields/custom_text_field.dart';

class AddFirebaseData extends StatefulWidget {
  @override
  State<AddFirebaseData> createState() => _AddFirebaseDataState();
}

class _AddFirebaseDataState extends State<AddFirebaseData> {
  final Completer<GoogleMapController> _controller = Completer();

  MapType _currentMapType = MapType.normal;

  List<MarkerData> customMarkers = [];

  LatLng center = const LatLng(38.033175, 58.1943723);

  late GoogleMapController mapController;

  LatLng lastMapPostion = const LatLng(38.033175, 58.1943723);
  bool publicValue = false;
  TextEditingController addController1 = TextEditingController();
  TextEditingController addController2 = TextEditingController();
  TextEditingController addController3 = TextEditingController();
  TextEditingController addController4 = TextEditingController();
  TextEditingController addController5 = TextEditingController();
  TextEditingController addController6 = TextEditingController();
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();
  FocusNode focusNode4 = FocusNode();
  FocusNode focusNode5 = FocusNode();
  FocusNode focusNode6 = FocusNode();
  double lat = 0.0;
  int markerFlag = 0;
  List<Marker> _allMarkers = [];
  double long = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        CustomTextField(labelName: 'address', controller: addController1, focusNode: focusNode1, requestfocusNode: focusNode2, isNumber: false, unFocus: false, cursorColor: Colors.black),
        CustomTextField(labelName: 'stationName', controller: addController2, focusNode: focusNode2, requestfocusNode: focusNode3, isNumber: false, unFocus: false, cursorColor: Colors.black),
        CustomTextField(labelName: 'bFee', controller: addController3, focusNode: focusNode3, requestfocusNode: focusNode4, isNumber: true, unFocus: false, cursorColor: Colors.black),
        CustomTextField(labelName: 'stationCount', controller: addController4, focusNode: focusNode4, requestfocusNode: focusNode5, isNumber: true, unFocus: false, cursorColor: Colors.black),
        CustomTextField(labelName: 'cFee', controller: addController5, focusNode: focusNode5, requestfocusNode: focusNode6, isNumber: true, unFocus: false, cursorColor: Colors.black),
        CustomTextField(labelName: 'oFee', controller: addController6, focusNode: focusNode6, requestfocusNode: focusNode1, isNumber: true, unFocus: false, cursorColor: Colors.black),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: SwitchListTile(
              activeTrackColor: kPrimaryColor,
              title: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 6, right: 15),
                    child: Icon(
                      IconlyLight.user3,
                      size: 28,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'public'.tr,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: nbtsM,
                    ),
                  ),
                ],
              ),
              value: publicValue,
              onChanged: (v) {
                publicValue = v;
                setState(() {});
              }),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Text(
            "Kartada yerlesmeli yerini sayla",
            style: TextStyle(color: Colors.black, fontFamily: gilroySemiBold),
          ),
        ),
        Container(
          height: 500,
          child: GoogleMap(
            initialCameraPosition: CameraPosition(target: center, zoom: 14.0),
            mapType: _currentMapType,
            markers: _allMarkers.toSet(),
            onMapCreated: (controller) {
              mapController = controller;
            },
            onCameraMove: (CameraPosition position) {
              lastMapPostion = position.target;
            },
            onTap: (val) {
              lat = val.latitude;
              long = val.longitude;
              setState(() {});
              _allMarkers.clear();
              _allMarkers.add(Marker(
                markerId: MarkerId('asd'),
                icon: BitmapDescriptor.defaultMarker,
                position: LatLng(val.latitude, val.longitude),
              ));
            },
            gestureRecognizers: Set()..add(Factory<EagerGestureRecognizer>(() => EagerGestureRecognizer())),
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
          ),
        ),
        AgreeButton(
            name: 'agree',
            style: false,
            onTap: () async {
              await FirebaseFirestore.instance.collection('stations').add({
                'block_fee': addController3.text,
                'count': addController4.text,
                'fee': addController5.text,
                'lat': lat.toString(),
                'long': long.toString(),
                'location': addController1.text,
                'name': addController2.text,
                'occupy_fee': addController6.text,
                'public': publicValue,
              }).then((value) {
                print(value);
                Get.back();
                showSnackBar('Goşuldy', 'Stansiýa goşuldy', kPrimaryColor);
              });
            }),
      ],
    ));
  }
}

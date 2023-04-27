import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:cv_charing/app/constants/text_fields/custom_text_field.dart';
import 'package:cv_charing/app/constants/widgets.dart';
import 'package:cv_charing/app/modules/home/controllers/home_controller.dart';
import 'package:cv_charing/app/modules/other_pages/info_custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../constants/buttons/switch_list_tile_button.dart';
import '../../../constants/cards/closest_station_card.dart';
import '../../../constants/constants.dart';
import '../../../constants/errors/empty_widgets.dart';
import '../../../constants/errors/error_widgets.dart';
import '../../other_pages/charge_info_page.dart';
import 'custom_marker.dart';

class ClosestStations extends StatefulWidget {
  const ClosestStations({super.key});

  @override
  State<ClosestStations> createState() => _ClosestStationsState();
}

class _ClosestStationsState extends State<ClosestStations> with SingleTickerProviderStateMixin {
  final HomeController homeController = Get.put(HomeController());
  @override
  void initState() {
    super.initState();

    if (homeController.userLat.value == 0.0) {
      homeController.determinePosition();
    }
  }

  final Completer<GoogleMapController> _controller = Completer();
  MapType _currentMapType = MapType.normal;
  List<MarkerData> customMarkers = [];
  LatLng center = const LatLng(38.033175, 58.1943723);
  late GoogleMapController mapController;
  LatLng lastMapPostion = const LatLng(38.033175, 58.1943723);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: kPrimaryColor3,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                IconlyLight.arrowLeftCircle,
                color: Colors.white,
              ),
            ),
            title: Text(
              'stationsClosest'.tr,
              style: nwtsM,
            ),
          ),
          body: Column(
            children: [
              TabBar(physics: BouncingScrollPhysics(), tabs: [
                Tab(
                  icon: Icon(IconlyLight.document),
                ),
                Tab(
                  icon: Icon(IconlyLight.discovery),
                ),
                Tab(
                  icon: Icon(IconlyLight.filter2),
                ),
                Tab(
                  icon: Icon(IconlyLight.search),
                )
              ]),
              Expanded(
                child: TabBarView(physics: NeverScrollableScrollPhysics(), children: [Page1(), page2(), page3(), Page4()]),
              )
            ],
          ),
        ));
  }

  ListView page3() {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 50,
            bottom: 50,
          ),
          child: Text(
            'filterStations'.tr,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 20),
          ),
        ),
        SwitchListTileButton(
          icon: IconlyBold.star,
          name: 'favorites'.tr,
        ),
        divider(),
        SwitchListTileButton(
          icon: IconlyBold.user3,
          name: 'public',
        ),
        divider(),
        SwitchListTileButton(
          icon: IconlyBold.profile,
          name: 'limited',
        ),
        divider(),
        SwitchListTileButton(
          icon: IconlyBold.location,
          name: 'onlyCV',
        ),
      ],
    );
  }

  StreamBuilder<QuerySnapshot<Map<String, dynamic>>> page2() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('stations').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (streamSnapshot.hasError) {
            return referalPageError();
          } else if (streamSnapshot.data!.docs.isEmpty) {
            return referalPageEmptyData();
          } else if (streamSnapshot.hasData) {
            addMarkersToMap(streamSnapshot);
            return CustomGoogleMapMarkerBuilder(
              customMarkers: customMarkers,
              builder: (BuildContext context, Set<Marker>? markers) {
                if (markers == null) {
                  return spinKit();
                }
                return GoogleMap(
                  initialCameraPosition: CameraPosition(target: center, zoom: 14.0),
                  markers: markers,
                  mapType: _currentMapType,
                  onMapCreated: (controller) {
                    mapController = controller;
                  },
                  onCameraMove: (CameraPosition position) {
                    lastMapPostion = position.target;
                  },
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: true,
                  zoomGesturesEnabled: true,
                );
              },
            );
          }
          return const Text("Error");
        });
  }

  void addMarkersToMap(AsyncSnapshot<QuerySnapshot<Object?>> streamSnapshot) {
    streamSnapshot.data!.docs.forEach(((element) {
      bool value = false;
      for (var element1 in customMarkers) {
        if (element1.marker.markerId.value.toString() == element['name'].toString()) {
          value = true;
        }
      }
      if (value == false) {
        customMarkers.add(MarkerData(
            marker: Marker(
                markerId: MarkerId(element['name'].toString()),
                onTap: () {
                  print('I tapped');
                  Get.bottomSheet(
                      InfoCustomCardpage(
                        Location: element['location'],
                        address: element['name'],
                        type: element['public'],
                        docID: element.id,
                      ),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))));
                },
                position: LatLng(double.parse(element['lat'].toString()), double.parse(element['long'].toString()))),
            child: CustomMarker(
              count: element['count'].toString(),
              name: element['name'] ?? 'Null',
            )));
      }
    }));
  }

  Widget Page1() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('stations').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (streamSnapshot.hasError) {
            return referalPageError();
          } else if (streamSnapshot.data!.docs.isEmpty) {
            return referalPageEmptyData();
          }
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: streamSnapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              return Closest_Station_Card(
                index: index,
                onTapp: () async {
                  Get.to(() => ChargeInfoPage(
                        docID: streamSnapshot.data!.docs[index].id,
                        stationName: streamSnapshot.data!.docs[index]['location'],
                      ));
                },
                streamSnapshot: streamSnapshot,
              );
            },
          );
        });
  }

  TextEditingController controller = TextEditingController();
  FocusNode focus = FocusNode();
  Widget Page4() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomTextField(labelName: 'search'.tr, controller: controller, focusNode: focus, requestfocusNode: focus, isNumber: false, unFocus: false, cursorColor: Colors.black),
        ),
        Expanded(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('stations').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (streamSnapshot.hasError) {
                  return referalPageError();
                } else if (streamSnapshot.data!.docs.isEmpty) {
                  return referalPageEmptyData();
                }
                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Closest_Station_Card(
                      index: index,
                      onTapp: () async {
                        Get.to(() => ChargeInfoPage(
                              docID: streamSnapshot.data!.docs[index].id,
                              stationName: streamSnapshot.data!.docs[index]['location'],
                            ));
                      },
                      streamSnapshot: streamSnapshot,
                    );
                  },
                );
              }),
        ),
      ],
    );
  }
}

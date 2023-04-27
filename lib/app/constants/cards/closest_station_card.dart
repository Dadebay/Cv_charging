import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../modules/home/controllers/home_controller.dart';
import '../constants.dart';

class Closest_Station_Card extends StatefulWidget {
  Closest_Station_Card({
    super.key,
    required this.streamSnapshot,
    required this.index,
    required this.onTapp,
  });

  final int index;
  final VoidCallback onTapp;
  final AsyncSnapshot<QuerySnapshot<Object?>> streamSnapshot;

  @override
  State<Closest_Station_Card> createState() => _Closest_Station_CardState();
}

class _Closest_Station_CardState extends State<Closest_Station_Card> {
  final HomeController homeController = Get.put(HomeController());
  String km = '';

  @override
  void initState() {
    super.initState();
    findKm();
  }

  Future findKm() async {
    double a1 = homeController.userLat.value;
    double a2 = homeController.userLong.value;
    double a3 = double.parse(widget.streamSnapshot.data!.docs[widget.index]['lat'].toString());
    double a4 = double.parse(widget.streamSnapshot.data!.docs[widget.index]['long'].toString());
    await Geolocator.getCurrentPosition().then((value) {
      a1 = value.latitude;
      a2 = value.longitude;
    });
    await Geolocator.distanceBetween(a1, a2, a3, a4);
    double distanceInMeters = await Geolocator.distanceBetween(a1, a2, a3, a4);
    distanceInMeters /= 1000;
    km = distanceInMeters.toStringAsFixed(2);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.only(top: 15, left: 8, right: 8),
      child: ElevatedButton(
        onPressed: widget.onTapp,
        style: ElevatedButton.styleFrom(
            elevation: 1, backgroundColor: Colors.white, padding: EdgeInsets.symmetric(horizontal: 8), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: borderRadius10)),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        IconlyBold.location,
                        color: kPrimaryColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 6, right: 4),
                        child: Text(
                          widget.streamSnapshot.data!.docs[widget.index]['name'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 18),
                        ),
                      )
                    ],
                  ),
                  Text(
                    widget.streamSnapshot.data!.docs[widget.index]['public'] ? 'public'.tr : 'limited'.tr,
                    style: TextStyle(color: Colors.black, fontFamily: gilroyRegular, fontSize: 14),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      IconlyBold.star,
                      color: Colors.grey,
                    ),
                    Text(
                      "EVSE 's",
                      style: TextStyle(color: Colors.black, fontFamily: gilroyRegular, fontSize: 14),
                    ),
                    Text(
                      widget.streamSnapshot.data!.docs[widget.index]['count'].toString() + ' Available',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: kPrimaryColor, fontFamily: gilroyRegular, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: VerticalDivider(
                color: Colors.grey,
              ),
            ),
            Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      IconlyLight.discovery,
                      color: Colors.black,
                    ),
                    Text(
                      km + " KM",
                      textAlign: TextAlign.center,
                      style: nbtsM,
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

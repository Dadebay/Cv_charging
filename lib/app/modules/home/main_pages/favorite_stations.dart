import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';

import '../../../constants/cards/closest_station_card.dart';
import '../../../constants/constants.dart';
import '../../../constants/errors/empty_widgets.dart';
import '../../../constants/errors/error_widgets.dart';
import '../../other_pages/charge_info_page.dart';

class FavoritesStations extends StatefulWidget {
  const FavoritesStations({super.key, required this.docID});
  final String docID;

  @override
  State<FavoritesStations> createState() => _FavoritesStationsState();
}

class _FavoritesStationsState extends State<FavoritesStations> {
  int a = 0;
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance.collection('users').doc(widget.docID).collection('favorites').get().then((value) {
      print(value);
      value.docs.forEach((element) {
        array.add(element['itemID']);
      });
      setState(() {});

      print(array);
      // array.add(value['itemID']);
    });
  }

  List array = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            'favStations'.tr,
            style: nwtsM,
          ),
        ),
        backgroundColor: Colors.white,
        body: card());
  }

  Widget card() {
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
          if (array.isEmpty) {
            return referalPageEmptyData();
          }
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: streamSnapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              print(array.contains(streamSnapshot.data!.docs[index].id));
              if (array.contains(streamSnapshot.data!.docs[index].id) == false) {
                a++;
              }
              print(a);
              print(array.length);
              if (a == array.length) {
                return referalPageEmptyData();
              }

              return array.contains(streamSnapshot.data!.docs[index].id)
                  ? Closest_Station_Card(
                      index: index,
                      onTapp: () async {
                        Get.to(() => ChargeInfoPage(
                              docID: streamSnapshot.data!.docs[index].id,
                              stationName: streamSnapshot.data!.docs[index]['location'],
                            ));
                      },
                      streamSnapshot: streamSnapshot,
                    )
                  : SizedBox.shrink();
            },
          );
        });
  }
}

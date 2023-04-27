import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cv_charing/app/constants/widgets.dart';
import 'package:cv_charing/app/modules/home/main_pages/add_data_firebase.dart';
import 'package:cv_charing/app/modules/home/main_pages/update_data_firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';

import '../../../constants/constants.dart';
import '../../../constants/errors/empty_widgets.dart';
import '../../../constants/errors/error_widgets.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kPrimaryColor3,
        elevation: 0,
        title: Text(
          'Admin Page'.tr,
          style: nwtsM,
        ),
      ),
      floatingActionButton: addButton(),
      backgroundColor: Colors.white,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('stations').snapshots(),
          builder: (BuildContext context, streamSnapshot) {
            if (streamSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (streamSnapshot.hasError) {
              return referalPageError();
            } else if (streamSnapshot.data == null) {
              return referalPageEmptyData();
            }
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                double lat = double.parse(streamSnapshot.data!.docs[index]['lat'].toString());
                double long = double.parse(streamSnapshot.data!.docs[index]['long'].toString());
                return Container(
                    margin: EdgeInsets.all(14),
                    padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(borderRadius: borderRadius20, color: Colors.white, boxShadow: [BoxShadow(color: Colors.grey.shade100, spreadRadius: 4, blurRadius: 4)]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        detailView('stationName', streamSnapshot.data!.docs[index]['name']),
                        detailView('location', streamSnapshot.data!.docs[index]['location']),
                        detailView('stationCount', streamSnapshot.data!.docs[index]['count'].toString()),
                        detailView('public', streamSnapshot.data!.docs[index]['public'] == true ? 'public'.tr : 'limited'.tr),
                        detailView('Lat', lat.toStringAsPrecision(6)),
                        detailView('Long', long.toStringAsPrecision(6)),
                        Row(
                          children: [
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: ElevatedButton.icon(
                                  onPressed: () {
                                    Get.to(() => UpdateDataFirebase(
                                          docID: streamSnapshot.data!.docs[index].id,
                                        ));
                                  },
                                  style: ElevatedButton.styleFrom(elevation: 0, shape: RoundedRectangleBorder(borderRadius: borderRadius5)),
                                  icon: Icon(
                                    IconlyBold.edit,
                                    color: kPrimaryColor,
                                  ),
                                  label: Text('edit'.tr)),
                            )),
                            Expanded(
                                child: ElevatedButton.icon(
                                    onPressed: () async {
                                      await FirebaseFirestore.instance.collection('stations').doc(streamSnapshot.data!.docs[index].id).delete().then((value) {
                                        showSnackBar('Pozuldy', 'Stansiýa pozuldy', Colors.green);
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(elevation: 0, shape: RoundedRectangleBorder(borderRadius: borderRadius5)),
                                    icon: Icon(
                                      IconlyBold.delete,
                                      color: kPrimaryColor,
                                    ),
                                    label: Text('delete'.tr))),
                          ],
                        )
                      ],
                    ));
              },
            );
          }),
    );
  }

  ElevatedButton addButton() {
    return ElevatedButton(
        onPressed: () {
          Get.to(() => AddFirebaseData());
        },
        style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor, elevation: 3, padding: EdgeInsets.all(10), shape: RoundedRectangleBorder(borderRadius: borderRadius10)),
        child: Text(
          'addStation'.tr,
          style: TextStyle(color: Colors.white, fontFamily: gilroyMedium, fontSize: 18),
        ));
  }

  Row detailView(String text1, String text2) {
    return Row(
      children: [
        Expanded(
            child: Text(
          text1.tr + ' : ',
          style: TextStyle(color: Colors.black, fontFamily: gilroyRegular, fontSize: 16),
        )),
        Expanded(child: Text(text2, style: TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 16))),
      ],
    );
  }
}

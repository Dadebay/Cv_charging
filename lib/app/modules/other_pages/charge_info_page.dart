import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';

import '../../constants/constants.dart';
import '../../constants/errors/empty_widgets.dart';
import '../../constants/errors/error_widgets.dart';

class ChargeInfoPage extends StatelessWidget {
  const ChargeInfoPage({super.key, required this.stationName, required this.docID});
  final String stationName;
  final String docID;

  @override
  Widget build(BuildContext context) {
    print(docID);
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
          stationName,
          style: nwtsM,
        ),
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('stations').doc(docID).snapshots(),
          builder: (BuildContext context, streamSnapshot) {
            if (streamSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (streamSnapshot.hasError) {
              return referalPageError();
            } else if (streamSnapshot.data == null) {
              return referalPageEmptyData();
            }
            print(streamSnapshot.data);
            return ListView(
              children: [
                Container(
                  width: Get.size.width,
                  height: 300,
                  child: Image.asset(
                    'assets/image/info.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                text('cFee', streamSnapshot.data!['fee'] + ' TMT / kWh'),
                text('bFee', streamSnapshot.data!['block_fee'] + ' TMT / min'),
                text('oFee', streamSnapshot.data!['occupy_fee'] + ' TMT / min'),
                Divider(
                  color: kPrimaryColor1,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'direction'.tr,
                    style: TextStyle(color: kPrimaryColor, fontFamily: gilroyMedium, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    streamSnapshot.data!['location'],
                    style: nbtsR,
                  ),
                )
              ],
            );
          }),
    );
  }

  Column text(String name, String price) {
    return Column(
      children: [
        Divider(
          color: kPrimaryColor1,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name.tr,
                style: nbtsR,
              ),
              Text(
                price,
                style: nbtsM,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';

import '../../constants/constants.dart';
import '../../constants/widgets.dart';
import '../home/main_pages/charge_start_finish.dart';
import 'charge_info_page.dart';

class InfoCustomCardpage extends StatefulWidget {
  const InfoCustomCardpage({super.key, required this.Location, required this.type, required this.address, required this.docID});
  final String Location;
  final String docID;
  final bool type;
  final String address;
  @override
  State<InfoCustomCardpage> createState() => _InfoCustomCardpageState();
}

class _InfoCustomCardpageState extends State<InfoCustomCardpage> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Container tabbars() {
    return Container(
      height: 50,
      margin: EdgeInsets.only(left: 25, right: 25, top: 25, bottom: 25),
      decoration: BoxDecoration(color: Colors.grey[300], borderRadius: borderRadius25),
      child: TabBar(
        controller: _tabController,
        isScrollable: false,
        labelPadding: EdgeInsets.symmetric(horizontal: 6),
        indicator: BoxDecoration(
          borderRadius: borderRadius25,
          color: Colors.white,
        ),
        labelColor: Colors.white,
        automaticIndicatorColorAdjustment: false,
        labelStyle: nbtsM,
        unselectedLabelStyle: nbtsR,
        padding: EdgeInsets.symmetric(vertical: 4),
        dividerColor: Colors.transparent,
        unselectedLabelColor: Colors.black,
        tabs: [
          Tab(
            child: Container(
              width: Get.size.width,
              alignment: Alignment.center,
              child: Text(
                'cards'.tr,
                style: nbtsR,
              ),
            ),
          ),
          Tab(
            child: Container(
              width: Get.size.width,
              alignment: Alignment.center,
              child: Text(
                'requests'.tr,
                style: nbtsR,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List weekdays = ['sunday'.tr, 'monday'.tr, 'tuesday'.tr, 'wednesday'.tr, 'thursday'.tr, 'friday'.tr, 'saturday'.tr];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        height: Get.size.height,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            tabbars(),
            Expanded(
              child: TabBarView(controller: _tabController, children: [
                page1(),
                page2(),
              ]),
            )
          ],
        ),
      ),
    );
  }

  Column page2() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(15),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: borderRadius15),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Icon(
                            Icons.electric_bolt_rounded,
                            color: kPrimaryColor,
                            size: 30,
                          ),
                        ),
                        Text(
                          'atoUse'.tr,
                          style: TextStyle(color: kPrimaryColor, fontFamily: gilroyRegular),
                        ),
                      ],
                    ),
                    Text(
                      'E8E15YZL - Limit 32A',
                      style: TextStyle(color: kPrimaryColor1, fontFamily: gilroyRegular, fontSize: 16),
                    )
                  ],
                ),
              ),
              Divider(
                color: kPrimaryColor1.withOpacity(0.4),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        showSnackBar('error2', 'error5', Colors.red);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade200,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'reserve'.tr,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey.shade400, fontFamily: gilroyRegular, fontSize: 16),
                      ),
                    ),
                  ),
                  VerticalDivider(
                    color: kPrimaryColor1,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(() => ChargeStartAndFinishView());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade200,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'startCharge2'.tr,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: kPrimaryColor, fontFamily: gilroyRegular, fontSize: 16),
                      ),
                    ),
                  ),
                  VerticalDivider(
                    color: kPrimaryColor1,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(() => ChargeInfoPage(
                              docID: widget.docID,
                              stationName: widget.address,
                            ));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade200,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'mInfo'.tr,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey, fontFamily: gilroyRegular, fontSize: 16),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Container page1() {
    return Container(
      alignment: Alignment.centerLeft,
      height: Get.size.height,
      color: Colors.white,
      child: ListView(shrinkWrap: true, children: [
        Divider(
          color: Colors.grey.shade300,
          height: 1,
        ),
        textFieldNameWidget('operator', "CV Charging Vehicles"),
        Divider(
          color: Colors.grey.shade300,
          height: 1,
        ),
        textFieldNameWidget('location', widget.address),
        Container(
          alignment: Alignment.centerLeft,
          width: Get.size.width,
          child: ElevatedButton.icon(
              onPressed: () async {
                await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('favorites').add({'itemID': widget.docID});
                showSnackBar('copySucces', 'setAsHome', Colors.green);
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  elevation: 0,
                  backgroundColor: Colors.white),
              icon: Icon(
                IconlyBold.star,
                color: Colors.grey.shade300,
              ),
              label: Text(
                'addtoFav'.tr,
                style: TextStyle(color: Colors.grey.shade400, fontFamily: gilroyMedium, fontSize: 18),
              )),
        ),
        Container(
          alignment: Alignment.centerLeft,
          width: Get.size.width,
          child: ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  elevation: 0,
                  backgroundColor: Colors.white),
              icon: Icon(
                IconlyBold.home,
                color: Colors.grey.shade300,
              ),
              label: Text(
                'setAsHome'.tr,
                style: TextStyle(color: Colors.grey.shade400, fontFamily: gilroyMedium, fontSize: 18),
              )),
        ),
        Container(
          alignment: Alignment.centerLeft,
          width: Get.size.width,
          child: ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  elevation: 0,
                  backgroundColor: Colors.white),
              icon: Icon(
                IconlyBold.work,
                color: Colors.grey.shade300,
              ),
              label: Text(
                'setAsWork'.tr,
                style: TextStyle(color: Colors.grey.shade400, fontFamily: gilroyMedium, fontSize: 18),
              )),
        ),
        Divider(
          color: Colors.grey.shade300,
          height: 1,
        ),
        textFieldNameWidget('uType', widget.type == true ? 'public'.tr : 'limited'.tr),
        Divider(
          color: Colors.grey.shade300,
          height: 1,
        ),
        textFieldNameWidget('address', widget.Location),
        Divider(
          color: Colors.grey.shade300,
          height: 1,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'sHours'.tr,
                  style: TextStyle(color: kPrimaryColor, fontFamily: gilroyRegular, fontSize: 16),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: weekdays.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        weekdays[index],
                        style: TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 18),
                      ),
                      Text(
                        '00.00 - 23.59',
                        style: TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 18),
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        ),
        SizedBox(
          height: 35,
        )
      ]),
    );
  }
}

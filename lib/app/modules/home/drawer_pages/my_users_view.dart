import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import '../../../constants/constants.dart';

class MyUserView extends StatefulWidget {
  const MyUserView({super.key});

  @override
  State<MyUserView> createState() => _MyUserViewState();
}

class _MyUserViewState extends State<MyUserView> {
  List cardRequested = [];
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
          'myUsers'.tr,
          style: nwtsM,
        ),
      ),
      backgroundColor: kPrimaryColor3,
      body: Column(
        children: [
          Expanded(
              child: Container(
                  color: Colors.white.withOpacity(0.9),
                  child: ListView.builder(
                    itemCount: cardRequested.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.only(top: 15, left: 15, right: 15),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: borderRadius15),
                        child: Material(
                          elevation: 1,
                          borderRadius: borderRadius15,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              'text7'.tr,
                              style: nbtsM,
                            ),
                          ),
                        ),
                      );
                    },
                  ))),
          bottomButtons(),
        ],
      ),
    );
  }

  SizedBox bottomButtons() {
    return SizedBox(
      width: Get.size.width,
      child: TextButton(
        onPressed: () {
          cardRequested.add('Sahedow Myrat');
          setState(() {});
        },
        style: TextButton.styleFrom(backgroundColor: kPrimaryColor3, elevation: 0.0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
        child: Text(
          'createNewUser'.tr,
          style: TextStyle(color: Colors.white, fontFamily: gilroyRegular, fontSize: 18),
        ),
      ),
    );
  }
}

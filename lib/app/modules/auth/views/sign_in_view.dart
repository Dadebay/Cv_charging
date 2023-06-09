import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cv_charing/app/constants/buttons/agree_button_view.dart';
import 'package:cv_charing/app/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/text_fields/custom_text_field.dart';
import '../../../constants/widgets.dart';
import '../../home/controllers/home_controller.dart';
import '../../home/views/home_view.dart';

class SignInView extends StatelessWidget {
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController surnameTextEditingController = TextEditingController();
  TextEditingController GmailTextEditingController = TextEditingController();
  TextEditingController PasswordTextEditingController = TextEditingController();
  FocusNode focusNodeName = FocusNode();
  FocusNode focusNodeSurname = FocusNode();
  FocusNode focusNodeGmail = FocusNode();
  FocusNode focusNodePassword = FocusNode();
  final login = GlobalKey<FormState>();
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor3,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            Container(
              height: Get.size.height / 4,
              padding: const EdgeInsets.all(25.0),
              child: Image.asset(logo),
            ),
            Container(
              height: Get.size.height / 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "text1".tr,
                    style: TextStyle(color: kPrimaryColor, fontFamily: gilroyBold, fontSize: 30),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "text2".tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: kPrimaryColor, fontFamily: gilroyMedium, fontSize: 20),
                  ),
                ],
              ),
            ),
            Form(
              key: login,
              child: Column(
                children: [
                  CustomTextField(
                    labelName: 'text7',
                    controller: nameTextEditingController,
                    focusNode: focusNodeName,
                    requestfocusNode: focusNodeSurname,
                    isNumber: false,
                    unFocus: false,
                    cursorColor: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: CustomTextField(
                        labelName: 'text8',
                        controller: surnameTextEditingController,
                        focusNode: focusNodeSurname,
                        requestfocusNode: focusNodeGmail,
                        isNumber: false,
                        unFocus: false,
                        cursorColor: Colors.white),
                  ),
                  CustomTextField(
                      labelName: 'text3',
                      controller: GmailTextEditingController,
                      focusNode: focusNodeGmail,
                      requestfocusNode: focusNodePassword,
                      isNumber: false,
                      unFocus: false,
                      cursorColor: Colors.white),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: CustomTextField(
                        labelName: 'text4',
                        controller: PasswordTextEditingController,
                        focusNode: focusNodePassword,
                        requestfocusNode: focusNodeName,
                        isNumber: false,
                        unFocus: false,
                        cursorColor: Colors.white),
                  ),
                  AgreeButton(
                      onTap: () async {
                        if (login.currentState!.validate()) {
                          try {
                            homeController.agreeButton.value = !homeController.agreeButton.value;

                            if (homeController.agreeButton.value == true) {
                              await FirebaseAuth.instance.createUserWithEmailAndPassword(email: GmailTextEditingController.text, password: PasswordTextEditingController.text);
                              await FirebaseFirestore.instance.collection('users').add({
                                'name': surnameTextEditingController.text + nameTextEditingController.text,
                              });
                              await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('favorites').get();

                              await FirebaseAuth.instance.currentUser!.updateDisplayName(surnameTextEditingController.text + nameTextEditingController.text).then((value) {
                                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) {
                                  return HomeView('${FirebaseAuth.instance.currentUser!.displayName ?? 'CV Charging Vehicles'}');
                                }), (Route<dynamic> route) => false);
                              });
                            } else {
                              showSnackBar('error2', 'Garaşyň', Colors.red);
                            }
                            homeController.agreeButton.value = !homeController.agreeButton.value;
                          } on FirebaseAuthException catch (e) {
                            homeController.agreeButton.value = !homeController.agreeButton.value;

                            if (e.code.toString() == 'user-not-found') {
                              showSnackBar('error2', 'error1', Colors.red);
                            } else if (e.code.toString() == 'wrong-password') {
                              showSnackBar('error2', 'error3', Colors.red);
                            } else {
                              showSnackBar('error2', e.message.toString(), Colors.red);
                            }
                          }
                        } else {
                          showSnackBar('noConnection3', 'errorEmpty', Colors.red);
                        }
                      },
                      name: 'text6',
                      style: false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container button(String name, VoidCallback onTapp, bool style) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      width: Get.size.width,
      child: ElevatedButton(
        onPressed: onTapp,
        style: ElevatedButton.styleFrom(
          backgroundColor: style ? Colors.white : Colors.grey.shade400,
          elevation: 0,
          padding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius10,
          ),
        ),
        child: Text(
          name.tr,
          style: TextStyle(color: style ? kPrimaryColor : Colors.black, fontFamily: gilroySemiBold, fontSize: 18),
        ),
      ),
    );
  }
}

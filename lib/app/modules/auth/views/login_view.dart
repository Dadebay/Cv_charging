import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cv_charing/app/constants/buttons/agree_button_view.dart';
import 'package:cv_charing/app/constants/constants.dart';
import 'package:cv_charing/app/constants/text_fields/custom_text_field.dart';
import 'package:cv_charing/app/modules/auth/views/sign_in_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/widgets.dart';
import '../../home/controllers/home_controller.dart';
import '../../home/main_pages/admin_page.dart';
import '../../home/views/home_view.dart';

class LoginView extends StatefulWidget {
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController textEditingController = TextEditingController();

  TextEditingController textEditingControllePassowrd = TextEditingController();

  FocusNode focusNode = FocusNode();

  FocusNode focusNodePassword = FocusNode();
  final HomeController homeController = Get.put(HomeController());
  final login = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor3,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [
            Container(
              height: Get.size.height / 4,
              padding: const EdgeInsets.all(25.0),
              child: Image.asset(logo),
            ),
            Container(
              height: Get.size.height / 4,
              child: Column(
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomTextField(
                      labelName: 'text3', controller: textEditingController, focusNode: focusNode, requestfocusNode: focusNodePassword, isNumber: false, unFocus: false, cursorColor: Colors.white),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    child: CustomTextField(
                        labelName: 'text4',
                        controller: textEditingControllePassowrd,
                        focusNode: focusNodePassword,
                        requestfocusNode: focusNode,
                        isNumber: false,
                        unFocus: false,
                        cursorColor: Colors.white),
                  ),
                  AgreeButton(
                      name: 'text5',
                      style: false,
                      onTap: () async {
                        if (login.currentState!.validate()) {
                          try {
                            homeController.agreeButton.value = !homeController.agreeButton.value;

                            if (homeController.agreeButton.value == true) {
                              await FirebaseAuth.instance.signInWithEmailAndPassword(email: textEditingController.text, password: textEditingControllePassowrd.text).then((value) async {
                                await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('favorites').get();
                                FirebaseAuth.instance.currentUser!.uid.toString() == 'Jl122H2qF7SnjkfNVVKbpTjBJ9L2'
                                    ? Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) {
                                        return AdminPage();
                                      }), (Route<dynamic> route) => false)
                                    : Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) {
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
                      }),
                  button('text6', () {
                    Get.to(() => SignInView());
                  }, false),
                ],
              ),
            )
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
          padding: EdgeInsets.all(12),
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius15,
          ),
        ),
        child: Text(
          name.tr,
          style: TextStyle(color: style ? kPrimaryColor : Colors.black, fontFamily: gilroySemiBold, fontSize: 20),
        ),
      ),
    );
  }
}

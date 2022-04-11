import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_tourism_operator/utils/assets.dart';
import 'package:smart_tourism_operator/utils/config.dart';

import '../../../router/constants.dart';
import '../../../utils/api.dart';

class LoginRoute extends StatefulWidget {
  const LoginRoute({Key? key}) : super(key: key);

  @override
  State<LoginRoute> createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final storage = const FlutterSecureStorage();
  late FirebaseMessaging messaging;

  @override
  void initState() {
    super.initState();
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) {
      // print('hasil $value');
      storage.write(key: fcmToken, value: value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Image.asset(
            imageSplashScreen,
            fit: BoxFit.fill,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              height: screenHeight(context) * 0.6,
              width: screenWidth(context) * 0.9,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 5,
                      spreadRadius: 5,
                      color: Colors.black12,
                      offset: Offset(0, 0),
                    )
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      imagesLogos,
                      height: screenHeight(context) * 0.05,
                    ),
                    Image.asset(
                      imagesTubaba,
                      height: screenHeight(context) * 0.05,
                    ),
                    Image.asset(
                      iconProfile,
                      scale: 3,
                    ),
                    const Text(
                      'Log in',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: primaryColor),
                    ),
                    TextFormField(
                      controller: emailController,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(
                          color: primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                      onSaved: (value) => emailController.text = value!,
                      decoration: InputDecoration(
                          hintText: 'E-mail',
                          hintStyle: const TextStyle(
                              color: primaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                          hoverColor: primaryColor,
                          focusColor: primaryColor,
                          fillColor: primaryColor,
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 2,
                                  color: primaryColor,
                                  style: BorderStyle.none),
                              borderRadius: BorderRadius.circular(30))),
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      style: const TextStyle(
                          color: primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                      validator: (value) =>
                          value!.isEmpty ? 'Mohon isi Password dahulu' : null,
                      onSaved: (value) => passwordController.text = value!,
                      cursorColor: primaryColor,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: const TextStyle(
                              color: primaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                          hoverColor: primaryColor,
                          focusColor: primaryColor,
                          fillColor: primaryColor,
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 2,
                                  color: primaryColor,
                                  style: BorderStyle.none),
                              borderRadius: BorderRadius.circular(30))),
                    ),
                    TextButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    side:
                                        const BorderSide(color: primaryColor))),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(primaryColor),
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                                    const EdgeInsets.symmetric(
                                        horizontal: 100, vertical: 14))),
                        onPressed: () async {
                          if (emailController.text.isEmpty &&
                              passwordController.text.isEmpty) {
                            const snackBar = SnackBar(
                              duration: Duration(seconds: 3),
                              content: Text("Email dan Password harus diisi"),
                              backgroundColor: Colors.red,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            return;
                          } else if (passwordController.text.isEmpty) {
                            const snackBar = SnackBar(
                              duration: Duration(seconds: 3),
                              content: Text("Password harus diisi"),
                              backgroundColor: Colors.red,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            return;
                          } else if (emailController.text.isEmpty) {
                            const snackBar = SnackBar(
                              duration: Duration(seconds: 3),
                              content: Text("Email harus diisi"),
                              backgroundColor: Colors.red,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            return;
                          }
                          String email = emailController.text;
                          String password = passwordController.text;
                          await login(email, password);
                        },
                        child: const Text(
                          '        Log  in        ',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Belum punya akun? tekan ',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: primaryColor),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, signUpRoute);
                          },
                          child: const Text(
                            'disini',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: primaryColor),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Future<void> login(String email, String password) async {
    var response;
    Uri url = Uri.parse(AppUrl.loginAPI);
    var tokenFCM = await storage.read(key: fcmToken);
    print(tokenFCM);
    Map body = {
      "email": email,
      "password": password,
      "fcm_registration_id": tokenFCM
    };
    var res = await http.post(url, body: body);
    response = json.decode(res.body);
    if (res.statusCode == 200) {
      var jsonResponse = json.decode(res.body);
      var valueToken = jsonResponse['access_token'];
      if (jsonResponse != null) {
        // setState(() {
        //   isLoading = false;
        // });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', jsonResponse['access_token']);
        prefs.setString('email', email);
        await storage.write(key: keyToken, value: valueToken);
        Navigator.of(context).pushReplacementNamed(bottomNavBar);
      }
    } else {
      Flushbar(
        message: response['message'].toString(),
        icon: const Icon(
          Icons.info_outline,
          size: 28.0,
          color: primaryColor,
        ),
        duration: const Duration(seconds: 3),
        leftBarIndicatorColor: Colors.red,
      ).show(context);
      // setState(() {
      //   // isLoading = false;
      // });
      // print('status ${re
    }
  }
}

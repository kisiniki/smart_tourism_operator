import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:core';

import '../../../router/constants.dart';
import '../../../utils/api.dart';
import '../../../utils/assets.dart';
import '../../../utils/config.dart';

class SignUpRoute extends StatefulWidget {
  const SignUpRoute(
      {Key? key,
      this.obsecure = false,
      this.onSaved,
      this.namaValidator,
      this.emailValidator})
      : super(key: key);
  final FormFieldSetter<String>? onSaved;
  final bool? obsecure;
  final FormFieldValidator<String>? namaValidator;
  final FormFieldValidator<String>? emailValidator;

  @override
  State<SignUpRoute> createState() => _SignUpRouteState();
}

class _SignUpRouteState extends State<SignUpRoute> {
  Duration get loginTime => const Duration(milliseconds: 2250);
  bool isLoading = false;
  TextEditingController namaLengkapController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController =
      TextEditingController();
  TextEditingController nikController = TextEditingController();
  TextEditingController noTelfController = TextEditingController();
  String photoUrl = '';
  XFile? file;
  String? base64Image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            height: screenHeight(context) * 0.9,
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
                    iconProfile,
                    scale: 3,
                  ),
                  TextFormField(
                    style: const TextStyle(
                        color: primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                    controller: namaLengkapController,
                    autofocus: true,
                    decoration: InputDecoration(
                        hintText: 'Nama Lengkap',
                        hintStyle: const TextStyle(
                            color: primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                        hoverColor: primaryColor,
                        focusColor: primaryColor,
                        fillColor: primaryColor,
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: primaryColor, style: BorderStyle.none),
                            borderRadius: BorderRadius.circular(30))),
                  ),
                  TextFormField(
                    style: const TextStyle(
                        color: primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
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
                                color: primaryColor, style: BorderStyle.none),
                            borderRadius: BorderRadius.circular(30))),
                  ),
                  TextFormField(
                    controller: passwordController,
                    style: const TextStyle(
                        color: primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                    obscureText: true,
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
                                color: primaryColor, style: BorderStyle.none),
                            borderRadius: BorderRadius.circular(30))),
                  ),
                  TextFormField(
                    controller: passwordConfirmationController,
                    style: const TextStyle(
                        color: primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                    decoration: InputDecoration(
                        hintText: 'Password Konfirmasi',
                        hintStyle: const TextStyle(
                            color: primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                        hoverColor: primaryColor,
                        focusColor: primaryColor,
                        fillColor: primaryColor,
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: primaryColor, style: BorderStyle.none),
                            borderRadius: BorderRadius.circular(30))),
                  ),
                  TextFormField(
                    controller: nikController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                        color: primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                    decoration: InputDecoration(
                        hintText: 'NIK',
                        hintStyle: const TextStyle(
                            color: primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                        hoverColor: primaryColor,
                        focusColor: primaryColor,
                        fillColor: primaryColor,
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: primaryColor, style: BorderStyle.none),
                            borderRadius: BorderRadius.circular(30))),
                  ),
                  TextFormField(
                    controller: noTelfController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                        color: primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                    decoration: InputDecoration(
                        hintText: 'Nomor Telf',
                        hintStyle: const TextStyle(
                            color: primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                        hoverColor: primaryColor,
                        focusColor: primaryColor,
                        fillColor: primaryColor,
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: primaryColor, style: BorderStyle.none),
                            borderRadius: BorderRadius.circular(30))),
                  ),
                  Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ElevatedButton(
                            style: ButtonStyle(backgroundColor:
                                MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.pressed)) {
                                return primaryColor;
                              }
                              return secondaryColor;
                            })),
                            onPressed: _choose,
                            child: const Text(
                              'Choose Image',
                              style: TextStyle(color: white),
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          ElevatedButton(
                            style: ButtonStyle(backgroundColor:
                                MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.pressed)) {
                                return primaryColor;
                              }
                              return secondaryColor;
                            })),
                            onPressed: _upload,
                            child: const Text('Upload Image',
                              style: TextStyle(color: white),),
                          )
                        ],
                      ),
                      file == null
                          ? const Text('No Image Selected')
                          : const Text('Image Selected')
                    ],
                  ),
                  TextButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  side: const BorderSide(color: primaryColor))),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(primaryColor),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                                  const EdgeInsets.symmetric(
                                      horizontal: 100, vertical: 14))),
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        String nama = namaLengkapController.text;
                        String email = emailController.text;
                        String password = passwordController.text;
                        String passwordConfirmation =
                            passwordConfirmationController.text;
                        String nik = nikController.text;
                        // String nikC = int.parse(nik);
                        String phone = noTelfController.text;
                        // String phoneC = int.parse(phone);
                        signUp(nama, email, password, passwordConfirmation, nik,
                            phone);
                      },
                      child: const Text(
                        'Daftar Sekarang',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signUp(String name, String email, String password,
      String passwordConfirmation, String nik, String phone) async {
    // String fileName = file.path.split("/").last;
    Uri url = Uri.parse(AppUrl.registerAPI);
    var tokenFCM = await storage.read(key: fcmToken);
    Map body = {
      'name': name,
      "email": email,
      "password": password,
      "password_confirmation": passwordConfirmation,
      "nik": nik,
      "phone": phone,
      'fcm_registration_id': tokenFCM,
      "photo": 'data:image/png;base64,$base64Image'
    };
    print('tokenya $tokenFCM');
    var res = await http.post(url, body: body);
    if (res.statusCode == 200) {
      var jsonResponse = json.decode(res.body);
      if (jsonResponse != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', jsonResponse['access_token']);
        prefs.setString('email', email);
        await storage.write(key: keyToken, value: jsonResponse['access_token']);
        Navigator.pushNamedAndRemoveUntil(
            context, bottomNavBar, (route) => false);
      }
    } else {
      Flushbar(
        message: 'Data yang dimasukan salah, Masukan data dengan benar!',
        icon: const Icon(
          Icons.info_outline,
          size: 28.0,
          color: primaryColor,
        ),
        duration: const Duration(seconds: 3),
        leftBarIndicatorColor: Colors.blue[300],
      ).show(context);
    }
  }

  Future _choose() async {
    final ImagePicker _picker = ImagePicker();
    // var file = await ImagePicker.pickImage(source: ImageSource.camera);
    // Capture a photo
    file = await _picker.pickImage(source: ImageSource.camera);
    // setState(() {
    //   file = File(file.path) as XFile;
    // });
  }

  void _upload() async {
    if (file == null) return;
    
    List<int> imageBytes = await file!.readAsBytes();
    base64Image = base64Encode(imageBytes);
    setState(() {
      
    });
    // String base64Image = base64Encode(file.readAsBytesSync());
    // String fileName = file.path.split("/").last;
    // final bytes = Io.File(file).readAsBytesSync();
    // String img64 = base64Encode(bytes);
    // photoUrl = base64Image;
    // print(img64.substring(0, 100));
    //   http.post(phpEndPoint, body: {
    //     "image": base64Image,
    //     "name": fileName,
    //   }).then((res) {
    //     print(res.statusCode);
    //   }).catchError((err) {
    //     print(err);
    //   });
  }
}

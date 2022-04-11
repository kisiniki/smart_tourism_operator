import 'dart:async';
import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import '../../../data/model/vehicle.dart';
import '../../../utils/api.dart';
import '../../../utils/assets.dart';
import '../../../utils/config.dart';

class SepedaDetailRoute extends StatefulWidget {
  String id;
  SepedaDetailRoute({Key? key, required this.id}) : super(key: key);
  @override
  State<SepedaDetailRoute> createState() => _SepedaDetailRouteState();
}

class _SepedaDetailRouteState extends State<SepedaDetailRoute> {
  String barcodeScanRes ='';
  @override
  void initState() {
    super.initState();
    barcodeScanRes='';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
            elevation: 0,
            backgroundColor: white,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: black,
                ))),
        body: SingleChildScrollView(
            child: FutureBuilder<VehicleDetailModel>(
                future: _getVehicleDetail(widget.id.toString()),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    Center(
                      child: Text(snapshot.hasError.toString()),
                    );
                  } else if (snapshot.hasData) {
                    final data = snapshot.data;
                    return Container(
                      child: Column(
                        children: [
                          Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 40),
                              child: Column(
                                children: [
                                  Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Container(
                                        height: screenHeight(context) * 0.5,
                                        width: screenWidth(context) * 0.9,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: primaryColor),
                                      ),
                                      Positioned(
                                          top: -50,
                                          right: -32,
                                          child: Image.asset(
                                            (data!.vehicleTypeId == 3)
                                                ? imageATV
                                                : imageSepeda,
                                            height: screenWidth(context) * 0.7,
                                            width: screenWidth(context) * 0.7,
                                          )),
                                      Positioned(
                                          bottom: 95,
                                          left: 20,
                                          child: Text(
                                              snapshot.data!.vehicleType!.type!,
                                              style: GoogleFonts.roboto(
                                                  fontSize: 40,
                                                  fontWeight: FontWeight.w700,
                                                  color: white))),
                                      Positioned(
                                          bottom: 60,
                                          left: 20,
                                          child: Text(
                                              snapshot.data!.serialNumber!,
                                              style: GoogleFonts.roboto(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w700,
                                                  color: white))),
                                      Positioned(
                                          bottom: 30,
                                          left: 20,
                                          child: Text(
                                              snapshot.data!.rentArea!.name!,
                                              style: GoogleFonts.roboto(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w700,
                                                  color: white)))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Tarif',
                                      style: GoogleFonts.roboto(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                          color: primaryColor),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                          text: (data.fare.toString() == null)
                                              ? 'Rp. - ,-'
                                              : 'Rp ${data.fare}',
                                          style: GoogleFonts.roboto(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              fontStyle: FontStyle.italic,
                                              color: primaryColor),
                                          children: [
                                            TextSpan(
                                                text: ' /menit',
                                                style: GoogleFonts.roboto(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.italic,
                                                ))
                                          ]),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: screenHeight(context) * 0.02,
                          ),
                          Center(
                            child: GestureDetector(
                              onTap: () async {
                                await rentVehicle(widget.id);
                              },
                              child: Container(
                                width: screenWidth(context) * 0.6,
                                height: screenHeight(context) * 0.07,
                                decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(30)),
                                child: const Center(
                                  child: Text(
                                    'Pesan',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700,
                                        color: white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight(context) * 0.01,
                          ),
                          Center(
                            child: GestureDetector(
                              onTap: () async {
                                await scanBarcodeNormal();
                              },
                              child: Container(
                                width: screenWidth(context) * 0.6,
                                height: screenHeight(context) * 0.07,
                                decoration: BoxDecoration(
                                    border: Border.all(color: primaryColor),
                                    color: white,
                                    borderRadius: BorderRadius.circular(30)),
                                child: const Center(
                                  child: Text(
                                    'Scan Ulang',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700,
                                        color: primaryColor),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight(context) * 0.05,
                          )
                        ],
                      ),
                    );
                  }
                  return Center(child: loadingIndicator);
                })));
  }
  Future<void> scanBarcodeNormal() async {
    String _scanBarcode = 'Unknown';
    
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      rentVehicle;
      // Navigator.pushReplacementNamed(context, sepedaMainRoute);
      // print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }
  Future<void> rentVehicle(String id) async {
    Uri url = Uri.parse(AppUrl.rentAPI(id));
    var jsonResponse;
    // var tokenResponse = await storage.read(key: keyToken);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokenS = prefs.getString('token');
    var responseError;
    var res = await http.post(url,
        headers: {HttpHeaders.authorizationHeader: 'Bearer $tokenS'});
        responseError= json.decode(res.body);
    if (res.statusCode == 200) {
      jsonResponse = json.decode(res.body);
      // print('status: ${res.statusCode}');
      // print('body: ${res.body}');
      if (jsonResponse != null) {
        // setState(() {
        // });
        await storage.read(key: keyToken);
      }
      Flushbar(
        message: jsonResponse['message'],
        icon: const Icon(
          Icons.info_outline,
          size: 28.0,
          color: primaryColor,
        ),
        duration: const Duration(seconds: 3),
        leftBarIndicatorColor: Colors.red[300],
      ).show(context);
    } else {
      Flushbar(
        message: responseError['message'],
        icon: const Icon(
          Icons.info_outline,
          size: 28.0,
          color: primaryColor,
        ),
        duration: const Duration(seconds: 3),
        leftBarIndicatorColor: Colors.blue[300],
      ).show(context);
      // setState(() {
      //   // isLoading = false;
      // });
      // print('status ${res.body}');
    }
  }
  Future<VehicleDetailModel> _getVehicleDetail(String id) async {
    // print('Detail id = $id');
    // var jsonResponse;
    // var tokenResponse = await storage.read(key: keyToken);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokenS = prefs.getString('token');
    final response = await http.get(
        Uri.parse(AppUrl.getVehicleDetailAPI(id)),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $tokenS'});
    if (response.statusCode == 200) {
      // print(response.body);
      var jsonResponse = json.decode(response.body);
      return VehicleDetailModel.fromJson(jsonResponse);
    } else {
      Flushbar(
        message: 'Terjadi kesalahan, silahkan coba lagi',
        icon: const Icon(
          Icons.info_outline,
          size: 28.0,
          color: primaryColor,
        ),
        duration: const Duration(seconds: 3),
        leftBarIndicatorColor: Colors.blue[300],
      ).show(context);
      // setState(() {
      //   // isLoading = false;
      // });
      // print('status2 ${response.body}');
    }
  return json.decode(response.body);
  }
}

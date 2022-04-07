import 'dart:convert';
import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:smart_tourism_operator/utils/config.dart';

import '../../../data/model/vehicle.dart';
import '../../../utils/api.dart';
import '../../../utils/assets.dart';

class SepedaDetailSRoute extends StatefulWidget {
  const SepedaDetailSRoute({Key? key}) : super(key: key);

  @override
  State<SepedaDetailSRoute> createState() => _VehicleDetailRouteState();
}

class _VehicleDetailRouteState extends State<SepedaDetailSRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<VehicleTypeModel>(
            future: _getVehicleTypeSepeda(),
            builder: (context, snapshot) {
              final data = snapshot.data;
              if (snapshot.hasError) {
                Center(
                  child: Text(snapshot.hasError.toString()),
                );
              } else if (snapshot.hasData) {
                return Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: screenHeight(context) * 0.1,
                    ),
                    Center(
                      child: Container(
                        width: screenWidth(context) * 0.9,
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            // SizedBox(
                            //   height: screenHeight(context) * 0.02,
                            // ),
                            Image.asset(
                              imageSepeda,
                              scale: 2,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 30.0),
                              child: Text(
                                'Sepeda',
                                style: TextStyle(
                                    fontSize: 89,
                                    fontWeight: FontWeight.w800,
                                    color: white),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 50, bottom: 10, top: 20),
                                child: Text(
                                  'Total Unit : ${data!.totalVehicle}',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                      color: white),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 50, bottom: 30),
                                child: Text(
                                  'Tersedia : ${data.availableVehicle}',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                      color: white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              }
              return Center(
                child: loadingIndicator,
              );
            }));
  }
  Future<VehicleTypeModel> _getVehicleTypeSepeda() async {
    // var jsonResponse;
    // var tokenResponse = await storage.read(key: keyToken);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokenS = prefs.getString('token');
    final response = await http.get(
        Uri.parse(AppUrl.getVehicleTypeAPI(1)),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $tokenS'});
    // print(tokenS);
    if (response.statusCode == 200) {
      return VehicleTypeModel.fromJson(json.decode(response.body));
    } else {
      Flushbar(
        message: 'Terjadi Keslaahan, Silahkan coba lagi',
        icon: const Icon(
          Icons.info_outline,
          size: 28.0,
          color: primaryColor,
        ),
        duration: Duration(seconds: 3),
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

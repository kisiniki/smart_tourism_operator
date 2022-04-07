import 'dart:convert';
import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../data/model/vehicle.dart';
import '../../../utils/api.dart';
import '../../../utils/assets.dart';
import '../../../utils/config.dart';

class VehicleDetailRoute extends StatefulWidget {
  const VehicleDetailRoute({Key? key}) : super(key: key);
  @override
  State<VehicleDetailRoute> createState() => _VehicleDetailRouteState();
}

class _VehicleDetailRouteState extends State<VehicleDetailRoute> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<VehicleTypeModel>(
            future: _getVehicleTypeATV(),
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
                                SizedBox(
                                  height: screenHeight(context) * 0.02,
                                ),
                                Image.asset(
                                  imageATV,
                                  scale: 2,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(right: 50.0),
                                  child: Text(
                                    'ATV',
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
                                      style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w500,
                                          color: white),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 50, bottom: 30),
                                    child: Text(
                                      'Tersedia : ${data.availableVehicle}',
                                      style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w500,
                                          color: white),
                                    ),
                                  ),
                                ),
                              ],
                            )))
                  ],
                );
              }
              return Center(
                child: loadingIndicator,
              );
            }));
  }
  Future<VehicleTypeModel> _getVehicleTypeATV() async {
    // var tokenResponse = await storage.read(key: keyToken);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokenS = prefs.getString('token');
    final response = await http.get(Uri.parse(AppUrl.getVehicleTypeAPI(3)),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $tokenS'});
    if (response.statusCode == 200) {
      // print(response.body);
      var jsonResponse = json.decode(response.body);
      return VehicleTypeModel.fromJson(jsonResponse);
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

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:smart_tourism_operator/presentation/widget/my_container.dart';

import '../../../data/model/running.dart';
import '../../../router/constants.dart';
import '../../../utils/api.dart';
import '../../../utils/config.dart';

class HistoryRoute extends StatefulWidget {
  const HistoryRoute({Key? key}) : super(key: key);
  @override
  _HistoryRouteState createState() => _HistoryRouteState();
}

class _HistoryRouteState extends State<HistoryRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: screenHeight(context) * 0.08,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Riwayat',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: primaryColor),
              ),
            ),
            SizedBox(
              child: FutureBuilder<List<Ended>>(
                  future: getListPaid(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Ended> data = snapshot.data!;
                      List vehicleTypeList = [];
                      for (var e in data) {
                        vehicleTypeList.add(e.vehicle!.vehicleTypeId);
                      }
                      List rentalList = [];
                      for (var e in data) {
                        rentalList.add(e.id);
                      }
                      List vehicleIdList = [];
                      for (var e in data) {
                        vehicleIdList.add(e.vehicleId);
                      }
                      List serialNumberList = [];
                      for (var e in data) {
                        serialNumberList.add(e.vehicle!.serialNumber);
                      }
                      return ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 10),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, tagihanRoute,
                                      arguments: {
                                        'idVehicle': vehicleIdList[index],
                                        'idRental': rentalList[index]
                                      });
                                },
                                child: MyContainer(
                                    name: serialNumberList[index],
                                    vehicleType: vehicleTypeList[index] == 1
                                        ? 'sepeda'
                                        : 'ATV'),
                              ),
                            );
                          });
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return Center(child: loadingIndicator);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

Future<List<Ended>> getListPaid() async {
  Uri url = Uri.parse(AppUrl.getAllVehicleAPI);
  // var jsonResponse;
  // var tokenResponse = await storage.read(key: keyToken);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var tokenS = prefs.getString('token');
  var res = await http
      .get(url, headers: {HttpHeaders.authorizationHeader: 'Bearer $tokenS'});
  if (res.statusCode == 200) {
    List waitingList = json.decode(res.body)['paid'];
    return waitingList.map((rsList) => Ended.fromJson(rsList)).toList();
  } else {
    throw Exception('Failed to load jobs from API');
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../data/model/detail_rental.dart';
import '../../../utils/api.dart';
import '../../../utils/config.dart';

class TagihanRoute extends StatefulWidget {
  int idVehicle, idRental;
  TagihanRoute({Key? key, required this.idVehicle, required this.idRental})
      : super(key: key);

  @override
  State<TagihanRoute> createState() => _TagihanRouteState();
}

class _TagihanRouteState extends State<TagihanRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: FutureBuilder<DetailRentalModel>(
              future:
                  getVehicleOngoingDetail(widget.idVehicle, widget.idRental),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.hasError.toString()),
                  );
                } else if (snapshot.hasData) {
                  var data = snapshot.data;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: screenHeight(context) * 0.05,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: primaryColor),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  'TAGIHAN',
                                  style: TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.w700,
                                      color: white),
                                ),
                              ),
                              SizedBox(
                                height: screenHeight(context) * 0.02,
                              ),
                              Text(
                                'Pemakaian',
                                style: TextStyle(
                                    fontSize: 34,
                                    fontWeight: FontWeight.w700,
                                    color: white),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Text(
                                  'Perjalanan',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700,
                                      color: white),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: Text(
                                  'Rp.${data!.rental!.vehicle!.fare},-/30menit',
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w400,
                                      color: white),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Text(
                                  'Tarif',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700,
                                      color: white),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: Text(
                                  '${data.duration == null ? '-' : '${data.duration}'} menit',
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w400,
                                      color: white),
                                ),
                              ),
                              Text(
                                'Jenis Kendaraan',
                                style: TextStyle(
                                    fontSize: 34,
                                    fontWeight: FontWeight.w700,
                                    color: white),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Text(
                                  data.rental!.vehicle!.vehicleTypeId == 1
                                      ? 'Sepeda'
                                      : "ATV",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w400,
                                      color: white),
                                ),
                              ),
                              SizedBox(
                                height: screenHeight(context) * 0.02,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Text(
                                  'Seri Kendaraan : ',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w400,
                                      color: white),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: Text(
                                  data.rental!.vehicle!.serialNumber!,
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w700,
                                      color: white),
                                ),
                              ),
                              SizedBox(
                                height: screenHeight(context) * 0.03,
                              ),
                              Text(
                                'Waktu',
                                style: TextStyle(
                                    fontSize: 34,
                                    fontWeight: FontWeight.w700,
                                    color: white),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Text(
                                  'Mulai :',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: white),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25.0),
                                child: Text(
                                  data.rental!.dateTimeStart!,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: white),
                                ),
                              ),
                              SizedBox(
                                height: screenHeight(context) * 0.02,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Text(
                                  'Selesai :',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: white),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25.0),
                                child: Text(
                                  data.rental!.dateTimeEnd!,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: white),
                                ),
                              ),
                              SizedBox(
                                height: screenHeight(context) * 0.02,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Text(
                                  'Status Pembayaran :',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: white),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25.0),
                                child: Text(
                                  data.rental!.invoice!.isPaid == 1
                                      ? 'LUNAS'
                                      : 'Belum Dibayar',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700,
                                      color: white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                                height: screenHeight(context) * 0.02,
                              ),
                      Divider(
                        color: primaryColor,
                        thickness: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Total Pembayaran',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: primaryColor),
                          ),
                          Text(
                            ':       Rp.${oCcy.format(data.rental!.invoice!.totalCharge)},-',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: primaryColor),
                          ),
                        ],
                      ),
                      Divider(
                        color: primaryColor,
                        thickness: 5,
                      ),
                      SizedBox(
                        height: screenHeight(context) * 0.02,
                      ),
                    ],
                  );
                }
                return Center(
                  child: loadingIndicator,
                );
              })),
    );
  }
  Future<DetailRentalModel> getVehicleOngoingDetail(
      int idVehicle, int idRental) async {
    // var tokenResponse = await storage.read(key: keyToken);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokenS = prefs.getString('token');
    final response = await http.get(
        Uri.parse(AppUrl.getVehicleRentalDetailAPI(idVehicle, idRental)),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $tokenS'});
    if (response.statusCode == 200) {
      // print('Berhasil mendapatkan getVehicleDetail');
      var jsonResponse = json.decode(response.body);
      return DetailRentalModel.fromJson(jsonResponse);
    } else {
      Flushbar(
        message: 'Terjadi kesalahan, silahkan coba lagi',
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
      // print('status ${response.body}');
    }
    return json.decode(response.body);
      }
}

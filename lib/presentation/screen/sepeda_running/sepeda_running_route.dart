import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../data/model/detail_rental.dart';
import '../../../utils/api.dart';
import '../../../utils/assets.dart';
import '../../../utils/config.dart';
import '../../../utils/location_service.dart';

class SepedaRunningRoute extends StatefulWidget {
  int idVehicle, idRental;
  SepedaRunningRoute(
      {Key? key, required this.idRental, required this.idVehicle})
      : super(key: key);
  @override
  State<SepedaRunningRoute> createState() => _SepedaRunningRouteState();
}

class _SepedaRunningRouteState extends State<SepedaRunningRoute> {
  //Google Maps
  Location location = Location();
  LocationService locationService = LocationService();
  Set<Marker> marker = {};
  GoogleMapController? mapController;
  BitmapDescriptor? iconMarker;
  void setMarker() async {
    iconMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(5, 5)), iconLocation);
  }

  @override
  void initState() {
    super.initState();
    locationService.locationStram.listen((userLocation) {
      setState(() {
        setMarker();
      });
    });
  }

  @override
  void dispose() {
    // locationService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SingleChildScrollView(
          child: FutureBuilder<DetailRentalModel>(
              future:
                  getVehicleOngoingDetail(widget.idVehicle, widget.idRental),
              builder: (context, snapshot) {
                var data = snapshot.data;
                // var tarif = data.duration * data.rental.vehicle.fare;
                if (snapshot.hasError) {
                  Center(
                    child: Text(snapshot.hasError.toString()),
                  );
                } else if (snapshot.hasData) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(0),
                        alignment: Alignment.center,
                        height: screenHeight(context),
                        width: screenWidth(context),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: GoogleMap(
                          markers: marker,
                          zoomControlsEnabled: false,
                          circles: {
                            Circle(
                              strokeColor: Colors.transparent,
                              fillColor: Color.fromRGBO(255, 54, 54, 0.2),
                              circleId: CircleId('1'),
                              center: LatLng(
                                  data!.location!.lat!, data.location!.long!),
                              radius: 1000,
                            )
                          },
                          mapType: MapType.normal,
                          onMapCreated: (GoogleMapController controller) {
                            setState(() {
                              marker.add(Marker(
                                  infoWindow:
                                      InfoWindow(title: 'Posisi Kendaraan'),
                                  icon: iconMarker!,
                                  markerId: MarkerId('id-1'),
                                  position: LatLng(
                                      data.rental!.vehicle!.vehiclePosition!
                                          .lat!,
                                      data.rental!.vehicle!.vehiclePosition!
                                          .long!)));
                            });
                            mapController = controller;
                            location.onLocationChanged.listen((l) {
                              mapController!.animateCamera(
                                CameraUpdate.newCameraPosition(
                                  CameraPosition(
                                    target: LatLng(
                                        data.rental!.vehicle!.vehiclePosition!
                                            .lat!,
                                        data.rental!.vehicle!.vehiclePosition!
                                            .long!),
                                    zoom: 18,
                                  ),
                                ),
                              );
                            });
                          },
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                                data.rental!.vehicle!.vehiclePosition!.lat!,
                                data.rental!.vehicle!.vehiclePosition!.long!),
                            zoom: 150,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 50,
                        left: 20,
                        child: InkWell(
                            onTap: () => Navigator.of(context).pop(),
                            child: Container(
                              width: screenWidth(context) * 0.11,
                              height: screenWidth(context) * 0.11,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: white),
                              child: Icon(
                                Icons.arrow_back_rounded,
                                color: primaryColor,
                              ),
                            )),
                      ),
                      Positioned(
                          bottom: 30,
                          child: Container(
                            height: screenHeight(context) * 0.25,
                            width: screenWidth(context) * 0.93,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: white),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 2.0, right: 2.0, top: 8.0),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        sepedaIcon,
                                        scale: 10,
                                      ),
                                      Expanded(
                                        // width: screenWidth(context) * 0.7,
                                        // height: screenHeight(context)*0.,
                                        child: RichText(
                                            text: const TextSpan(
                                                text:
                                                    'Hati-hati berkendara di jalan perhatikan ',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: primaryColor),
                                                children: [
                                              TextSpan(
                                                  text: 'BATAS BERMAIN',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: primaryColor)),
                                              TextSpan(
                                                  text: ' yang berada di map ',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: primaryColor))
                                            ])),
                                      )
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 50, vertical: 8),
                                  child: Divider(
                                    color: primaryColor,
                                    thickness: 3,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        Text('Tipe',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                                color: primaryColor)),
                                        Text(
                                            data.rental!.vehicle!
                                                        .vehicleTypeId ==
                                                    1
                                                ? 'Sepeda'
                                                : 'ATV',
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w700,
                                                color: primaryColor))
                                      ],
                                    ),
                                    Image.asset(
                                      data.rental!.vehicle!.vehicleTypeId == 1
                                          ? imageSepeda
                                          : imageATV,
                                      width: screenWidth(context) * 0.2,
                                      height: screenWidth(context) * 0.2,
                                    ),
                                    Column(
                                      children: [
                                        Text('Tagihan',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                                color: primaryColor)),
                                        Text('Rp.${oCcy.format(data.cost)},-',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                                color: primaryColor))
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ))
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
        message: 'Terjadi Kesalahan, Silahkan coba kembali',
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

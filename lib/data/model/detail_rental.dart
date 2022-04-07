import 'package:smart_tourism_operator/data/model/running.dart';
import 'package:smart_tourism_operator/data/model/vehicle.dart';

class DetailRentalModel {
  Rental? rental;
  int? duration;
  VehiclePosition? location;
  int? cost;
  DetailRentalModel({this.rental, this.duration, this.location, this.cost});
  DetailRentalModel.fromJson(Map<String, dynamic> json) {
    rental =
        json['rental'] != null ? Rental.fromJson(json['rental']) : null;
    duration = json['duration'];
    location = json['location'] != null
        ? VehiclePosition.fromJson(json['location'])
        : null;
  
    cost = json['cost'];
    }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (rental != null) {
      data['rental'] = rental!.toJson();
    }
    data['duration'] = duration;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['cost'] = cost;
    return data;
  }}
  class Rental {
  int? id;
  int? vehicleId;
  int? userId;
  int? operatorId;
  String? dateTimeStart;
  String? dateTimeEnd;
  String? status;
  String? createdAt;
  String? updatedAt;
  Vehicle? vehicle;
  Invoice? invoice;
  Rental(
      {this.id,
      this.vehicleId,
      this.userId,
      this.operatorId,
      this.dateTimeStart,
      this.dateTimeEnd,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.vehicle,
      this.invoice});
  Rental.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vehicleId = json['vehicle_id'];
    userId = json['user_id'];
    operatorId = json['operator_id'];
    dateTimeStart = json['date_time_start'];
    dateTimeEnd = json['date_time_end'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    vehicle =
        json['vehicle'] != null ? Vehicle.fromJson(json['vehicle']) : null;
    invoice =
        json['invoice'] != null ? Invoice.fromJson(json['invoice']) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['vehicle_id'] = vehicleId;
    data['user_id'] = userId;
    data['operator_id'] = operatorId;
    data['date_time_start'] = dateTimeStart;
    data['date_time_end'] = dateTimeEnd;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (vehicle != null) {
      data['vehicle'] = vehicle!.toJson();
    }
    if (invoice != null) {
      data['invoice'] = invoice?.toJson();
    }
    return data;
  }}
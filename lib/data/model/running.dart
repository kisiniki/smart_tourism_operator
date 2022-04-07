import 'package:smart_tourism_operator/data/model/vehicle.dart';

class Vehicle {
  int? id;
  int? vehicleTypeId;
  String? label;
  String? serialNumber;
  int? fare;
  int? isAvailable;
  String? description;
  String? isInside;
  int? rentAreaId;
  String? brand;
  String? createdAt;
  String? updatedAt;
  VehiclePosition? vehiclePosition;
  Vehicle(
      {this.id,
      this.vehicleTypeId,
      this.label,
      this.serialNumber,
      this.fare,
      this.isAvailable,
      this.description,
      this.isInside,
      this.rentAreaId,
      this.brand,
      this.createdAt,
      this.updatedAt,
      this.vehiclePosition});
  Vehicle.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vehicleTypeId = json['vehicle_type_id'];
    label = json['label'];
    serialNumber = json['serial_number'];
    fare = json['fare'];
    isAvailable = json['is_available'];
    description = json['description'];
    isInside = json['is_inside'];
    rentAreaId = json['rent_area_id'];
    brand = json['brand'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    vehiclePosition = json['vehicle_position'] != null
        ? VehiclePosition.fromJson(json['vehicle_position'])
        : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['vehicle_type_id'] = vehicleTypeId;
    data['label'] = label;
    data['serial_number'] = serialNumber;
    data['fare'] = fare;
    data['is_available'] = isAvailable;
    data['description'] = description;
    data['is_inside'] = isInside;
    data['rent_area_id'] = rentAreaId;
    data['brand'] = brand;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (vehiclePosition != null) {
      data['vehicle_position'] = vehiclePosition!.toJson();
    }
    return data;
  }
}

class Waiting {
  int? id;
  int? vehicleId;
  int? userId;
  String? operatorId;
  String? dateTimeStart;
  String? dateTimeEnd;
  String? status;
  String? createdAt;
  String? updatedAt;
  Vehicle? vehicle;
  Waiting(
      {this.id,
      this.vehicleId,
      this.userId,
      this.operatorId,
      this.dateTimeStart,
      this.dateTimeEnd,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.vehicle});
  Waiting.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

class Ongoing {
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
  Ongoing(
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
  Ongoing.fromJson(Map<String, dynamic> json) {
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
      data['invoice'] = invoice!.toJson();
    }
    return data;
  }
}

class Invoice {
  int? id;
  int? userId;
  int? operatorId;
  int? rentalId;
  int? isPaid;
  int? totalCharge;
  String? createdAt;
  String? updatedAt;
  Invoice(
      {this.id,
      this.userId,
      this.operatorId,
      this.rentalId,
      this.isPaid,
      this.totalCharge,
      this.createdAt,
      this.updatedAt});
  Invoice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    operatorId = json['operator_id'];
    rentalId = json['rental_id'];
    isPaid = json['is_paid'];
    totalCharge = json['total_charge'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['operator_id'] = operatorId;
    data['rental_id'] = rentalId;
    data['is_paid'] = isPaid;
    data['total_charge'] = totalCharge;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Ended {
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
  Ended(
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
  Ended.fromJson(Map<String, dynamic> json) {
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
      data['invoice'] = invoice!.toJson();
    }
    return data;
  }
}

class VehicleDetailModel {
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
  VehicleType? vehicleType;
  RentArea? rentArea;
  VehicleDetailModel(
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
      this.vehicleType,
      this.rentArea});
  VehicleDetailModel.fromJson(Map<String, dynamic> json) {
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
    vehicleType = json['vehicle_type'] != null
        ? VehicleType.fromJson(json['vehicle_type'])
        : null;
    rentArea =
        json['rent_area'] != null ? RentArea.fromJson(json['rent_area']) : null;
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
    if (vehicleType != null) {
      data['vehicle_type'] = vehicleType!.toJson();
    }
    if (rentArea != null) {
      data['rent_area'] = rentArea!.toJson();
    }
    return data;
  }
}

class VehicleType {
  int? id;
  String? type;
  String? description;
  String? createdAt;
  String? updatedAt;
  VehicleType(
      {this.id, this.type, this.description, this.createdAt, this.updatedAt});
  VehicleType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class RentArea {
  int? id;
  String? name;
  String? operationalHour;
  String? createdAt;
  String? updatedAt;
  String? origin;
  String? destination;
  int? tolerance;
  RentArea(
      {this.id,
      this.name,
      this.operationalHour,
      this.createdAt,
      this.updatedAt,
      this.origin,
      this.destination,
      this.tolerance});
  RentArea.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    operationalHour = json['operational_hour'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    origin = json['origin'];
    destination = json['destination'];
    tolerance = json['tolerance'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['operational_hour'] = operationalHour;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['origin'] = origin;
    data['destination'] = destination;
    data['tolerance'] = tolerance;
    return data;
  }
}

class VehiclePosition {
  int? id;
  int? vehicleId;
  double? lat;
  double? long;
  String? createdAt;
  String? updatedAt;
  VehiclePosition(
      {this.id,
      this.vehicleId,
      this.lat,
      this.long,
      this.createdAt,
      this.updatedAt});
  VehiclePosition.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vehicleId = json['vehicle_id'];
    lat = json['lat'];
    long = json['long'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['vehicle_id'] = vehicleId;
    data['lat'] = lat;
    data['long'] = long;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class UserLocationModel {
  final double? longitude;
  final double? latitude;
  UserLocationModel({this.longitude, this.latitude});
}

class VehicleTypeModel {
  Detail? detail;
  int? totalVehicle;
  int? availableVehicle;
  VehicleTypeModel({this.detail, this.totalVehicle, this.availableVehicle});
  VehicleTypeModel.fromJson(Map<String, dynamic> json) {
    detail = json['detail'] != null ? Detail.fromJson(json['detail']) : null;
    totalVehicle = json['total_vehicle'];
    availableVehicle = json['available_vehicle'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (detail != null) {
      data['detail'] = detail!.toJson();
    }
    data['total_vehicle'] = totalVehicle;
    data['available_vehicle'] = availableVehicle;
    return data;
  }
}

class Detail {
  int? id;
  String? type;
  String? description;
  String? createdAt;
  String? updatedAt;
  Detail(
      {this.id, this.type, this.description, this.createdAt, this.updatedAt});
  Detail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

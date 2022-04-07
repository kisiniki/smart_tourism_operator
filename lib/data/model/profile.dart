class ProfileModel {
  User? user;
  int? totalPaidRental;
  ProfileModel({this.user, this.totalPaidRental});
  ProfileModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    totalPaidRental = json['total_paid_rental'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['total_paid_rental'] = totalPaidRental;
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  int? nik;
  int? phone;
  String? createdAt;
  String? updatedAt;
  String? fcmRegistrationId;
  User(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.nik,
      this.phone,
      this.createdAt,
      this.updatedAt,
      this.fcmRegistrationId});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    nik = json['nik'];
    phone = json['phone'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fcmRegistrationId = json['fcm_registration_id'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['nik'] = nik;
    data['phone'] = phone;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['fcm_registration_id'] = fcmRegistrationId;
    return data;
  }
}

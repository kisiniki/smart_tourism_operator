import 'package:smart_tourism_operator/data/model/running.dart';

class HomeModel {
  List<Waiting>? waiting;
  List<Ongoing>? ongoing;
  List<Ended>? ended;
  // List<Paid> paid;
  HomeModel({this.waiting, this.ongoing, this.ended});
  HomeModel.fromJson(Map<String, dynamic> json) {
    if (json['waiting'] != null) {
      waiting = <Waiting>[];
      json['waiting'].forEach((v) {
        waiting!.add(Waiting.fromJson(v));
      });
    }
    if (json['ongoing'] != null) {
      ongoing = <Ongoing>[];
      json['ongoing'].forEach((v) {
        ongoing!.add(Ongoing.fromJson(v));
      });
    }
    if (json['ended'] != null) {
      ended = <Ended>[];
      json['ended'].forEach((v) {
        ended!.add(Ended.fromJson(v));
      });
    }
  }
    // if (json['paid'] != null) {
    //   paid = new List<Paid>();
    //   json['paid'].forEach((v) {
    //     paid.add(new Paid.fromJson(v));
    //   });
    // }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (waiting != null) {
      data['waiting'] = waiting!.map((v) => v.toJson()).toList();
    }
    if (ongoing != null) {
      data['ongoing'] = ongoing!.map((v) => v.toJson()).toList();
    }
    if (ended != null) {
      data['ended'] = ended!.map((v) => v.toJson()).toList();
    }
    // if (this.paid != null) {
    //   data['paid'] = this.paid.map((v) => v.toJson()).toList();
    // }
    return data;
  }}
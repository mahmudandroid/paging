import 'package:flutter/material.dart';

class AppomentStatusModel with ChangeNotifier{
  String id;
  int number;
  String patientName;
  Null patientPhone;
  String doctorId;
  Null medicalCenterId;
  int currentStatus;
  int appomentType;
  String userId;
  int timeTableId;
  String doctorName;
  String doctorNameAr;
  Null medicalCenterName;
  Null medicalCenterNameAr;
  Null timeTable;
  String userName;

//  List<Null> doctorRates;

  AppomentStatusModel({
    this.id,
    this.number,
    this.patientName,
    this.patientPhone,
    this.doctorId,
    this.medicalCenterId,
    this.currentStatus,
    this.appomentType,
    this.userId,
    this.timeTableId,
    this.doctorName,
    this.doctorNameAr,
    this.medicalCenterName,
    this.medicalCenterNameAr,
    this.timeTable,
    this.userName,
    //  this.doctorRates ,
  });

  AppomentStatusModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    number = json['number'];
    patientName = json['patientName'];
    patientPhone = json['patientPhone'];
    doctorId = json['doctorId'];
    medicalCenterId = json['medicalCenterId'];
    currentStatus = json['currentStatus'];
    appomentType = json['appomentType'];
    userId = json['userId'];
    timeTableId = json['timeTableId'];
    doctorName = json['doctorName'];
    doctorNameAr = json['doctorNameAr'];
    medicalCenterName = json['medicalCenterName'];
    medicalCenterNameAr = json['medicalCenterNameAr'];
    timeTable = json['timeTable'];
    userName = json['userName'];
//    if (json['doctorRates'] != null) {
//      doctorRates = new List<Null>();
//      json['doctorRates'].forEach((v) {
//        doctorRates.add(new Null.fromJson(v));
//      });
//    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['number'] = this.number;
    data['patientName'] = this.patientName;
    data['patientPhone'] = this.patientPhone;
    data['doctorId'] = this.doctorId;
    data['medicalCenterId'] = this.medicalCenterId;
    data['currentStatus'] = this.currentStatus;
    data['appomentType'] = this.appomentType;
    data['userId'] = this.userId;
    data['timeTableId'] = this.timeTableId;
    data['doctorName'] = this.doctorName;
    data['doctorNameAr'] = this.doctorNameAr;
    data['medicalCenterName'] = this.medicalCenterName;
    data['medicalCenterNameAr'] = this.medicalCenterNameAr;
    data['timeTable'] = this.timeTable;
    data['userName'] = this.userName;
//    if (this.doctorRates != null) {
//      data['doctorRates'] = this.doctorRates.map((v) => v.toJson()).toList();
//    }
    return data;
  }
}

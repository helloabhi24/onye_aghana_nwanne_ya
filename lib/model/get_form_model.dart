// To parse this JSON data, do
//
//     final dataAccordingFormModel = dataAccordingFormModelFromJson(jsonString);

import 'dart:convert';

DataAccordingFormModel dataAccordingFormModelFromJson(String str) =>
    DataAccordingFormModel.fromJson(json.decode(str));

String dataAccordingFormModelToJson(DataAccordingFormModel data) =>
    json.encode(data.toJson());

class DataAccordingFormModel {
  final int id;
  final dynamic firstName;
  final dynamic middelName;
  final dynamic surName;
  final dynamic telephone;
  final dynamic gender;
  final dynamic maritualStatus;
  final dynamic dob;
  final dynamic pollUnit;
  final int isVerified;

  DataAccordingFormModel({
    required this.id,
    required this.firstName,
    required this.middelName,
    required this.surName,
    required this.telephone,
    required this.gender,
    required this.maritualStatus,
    required this.dob,
    required this.pollUnit,
    required this.isVerified,
  });

  factory DataAccordingFormModel.fromJson(Map<String, dynamic> json) =>
      DataAccordingFormModel(
        id: json["id"],
        firstName: json["first_name"] ?? "",
        middelName: json["middel_name"] ?? "",
        surName: json["sur_name"] ?? "",
        telephone: json["telephone"] ?? "",
        gender: json["gender"] ?? "",
        maritualStatus: json["maritual_status"] ?? "",
        dob: json["dob"] ?? "",
        pollUnit: json["poll_unit"] ?? "",
        isVerified: json["is_verified"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "middel_name": middelName,
        "sur_name": surName,
        "telephone": telephone,
        "gender": gender,
        "maritual_status": maritualStatus,
        "dob": dob,
        "poll_unit": pollUnit,
        "is_verified": isVerified,
      };
}

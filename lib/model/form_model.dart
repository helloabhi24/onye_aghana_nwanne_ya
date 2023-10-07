// To parse this JSON data, do
//
//     final formModel = formModelFromJson(jsonString);

import 'dart:convert';

FormModel formModelFromJson(String str) => FormModel.fromJson(json.decode(str));

String formModelToJson(FormModel data) => json.encode(data.toJson());

class FormModel {
  final int id;
  final int subAdminId;
  final String formName;
  final String firstName;
  final String middelName;
  final String surName;
  final String telephone;
  final String gender;
  final String address;
  final String maritualStatus;
  final String dob;
  final String pollUnit;
  final List<FormDatum> formData;
  final String status;
  final int createdBy;
  final int updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int votersCount;

  FormModel({
    required this.id,
    required this.subAdminId,
    required this.formName,
    required this.firstName,
    required this.middelName,
    required this.surName,
    required this.telephone,
    required this.gender,
    required this.address,
    required this.maritualStatus,
    required this.dob,
    required this.pollUnit,
    required this.formData,
    required this.status,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.votersCount,
  });

  factory FormModel.fromJson(Map<String, dynamic> json) => FormModel(
        id: json["id"],
        subAdminId: json["sub_admin_id"],
        formName: json["form_name"],
        firstName: json["first_name"],
        middelName: json["middel_name"],
        surName: json["sur_name"],
        telephone: json["telephone"],
        gender: json["gender"],
        address: json["address"],
        maritualStatus: json["maritual_status"],
        dob: json["dob"],
        pollUnit: json["poll_unit"],
        formData: List<FormDatum>.from(
            json["form_data"].map((x) => FormDatum.fromJson(x))),
        status: json["status"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        votersCount: json["voters_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sub_admin_id": subAdminId,
        "form_name": formName,
        "first_name": firstName,
        "middel_name": middelName,
        "sur_name": surName,
        "telephone": telephone,
        "gender": gender,
        "address": address,
        "maritual_status": maritualStatus,
        "dob": dob,
        "poll_unit": pollUnit,
        "form_data": List<dynamic>.from(formData.map((x) => x.toJson())),
        "status": status,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "voters_count": votersCount,
      };
}

class FormDatum {
  final dynamic value;
  final String question;
  final String mandatory;
  final String questionType;

  FormDatum({
    required this.value,
    required this.question,
    required this.mandatory,
    required this.questionType,
  });

  factory FormDatum.fromJson(Map<String, dynamic> json) => FormDatum(
        value: json["_value"],
        question: json["question"] ?? "",
        mandatory: json["mandatory"],
        questionType: json["question_type"],
      );

  Map<String, dynamic> toJson() => {
        "_value": value,
        "question": question,
        "mandatory": mandatory,
        "question_type": questionType,
      };
}

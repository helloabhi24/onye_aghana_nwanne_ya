// To parse this JSON data, do
//
//     final formDataModel = formDataModelFromJson(jsonString);

import 'dart:convert';

FormDataModel formDataModelFromJson(String str) =>
    FormDataModel.fromJson(json.decode(str));

String formDataModelToJson(FormDataModel data) => json.encode(data.toJson());

class FormDataModel {
  final String value;
  final String question;
  final String mandatory;
  final String questionType;

  FormDataModel({
    required this.value,
    required this.question,
    required this.mandatory,
    required this.questionType,
  });

  factory FormDataModel.fromJson(Map<String, dynamic> json) => FormDataModel(
        value: json["_value"] ?? "",
        question: json["question"],
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

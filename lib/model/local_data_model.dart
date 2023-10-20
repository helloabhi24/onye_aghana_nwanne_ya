class LocalDataModel {
  final int id;
  final Map<dynamic, dynamic> data;
  final bool shouldDeleteAfterUpload;
  final String formName;
  final String userid;
  final String subadminid;
  final String formid;

  LocalDataModel(
      {required this.data,
      required this.id,
      required this.shouldDeleteAfterUpload,
      required this.formName,
      required this.userid,
      required this.formid,
      required this.subadminid});

  factory LocalDataModel.fromJson(Map<String, dynamic> json) {
    return LocalDataModel(
        id: json['id'],
        data: json['data'],
        shouldDeleteAfterUpload: json['shouldDeleteAfterUpload'],
        formName: json['formName'],
        userid: json['userid'],
        formid: json['formid'],
        subadminid: json['subadminid']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'data': data,
      'shouldDeleteAfterUpload': shouldDeleteAfterUpload,
      'formName': formName,
      'userid': userid,
      'formid': formid,
      'subadminid': subadminid
    };
  }
}

class SyncLocalDataModel {
  final int id;
  final Map<dynamic, dynamic> data;
  final bool shouldDeleteAfterUpload;
  final String formName;
  final List wholelist;
  final String userid;
  final String subadminid;
  final String formid;

  SyncLocalDataModel(
      {required this.data,
      required this.id,
      required this.shouldDeleteAfterUpload,
      required this.formName,
      required this.wholelist,
      required this.userid,
      required this.formid,
      required this.subadminid});

  factory SyncLocalDataModel.fromJson(Map<String, dynamic> json) {
    return SyncLocalDataModel(
        id: json['id'],
        data: json['data'],
        shouldDeleteAfterUpload: json['shouldDeleteAfterUpload'],
        formName: json['formName'],
        wholelist: json['wholelist'],
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
      'wholelist': wholelist,
      'userid': userid,
      'formid': formid,
      'subadminid': subadminid
    };
  }
}

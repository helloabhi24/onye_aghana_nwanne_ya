class DBDataModel {
  final String firstName;
  final String middleName;
  final String surName;
  final String phone;
  final String gender;
  final String address;
  final String maritalStatus;
  final String dob;
  final String pollUnit;

  final int isSubmit;
  final String wholelist;
  final String userid;
  final String subadminid;
  final String formid;

  DBDataModel(
      {required this.firstName,
      required this.middleName,
      required this.surName,
      required this.phone,
      required this.gender,
      required this.address,
      required this.maritalStatus,
      required this.dob,
      required this.pollUnit,

      // required this.id,
      required this.isSubmit,
      required this.wholelist,
      required this.userid,
      required this.formid,
      required this.subadminid});

  factory DBDataModel.fromJson(Map<String, dynamic> json) {
    return DBDataModel(
        // id: json['id'],
        firstName: json['firstName'],
        middleName: json['middleName'],
        surName: json['surName'],
        phone: json['phone'],
        gender: json['gender'],
        address: json['address'],
        maritalStatus: json['maritalStatus'],
        dob: json['dob'],
        pollUnit: json['pollUnit'],
        isSubmit: json['isSubmit'],
        wholelist: json['wholelist'],
        userid: json['userid'],
        formid: json['formid'],
        subadminid: json['subadminid']);
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'firstName': firstName,
      'middleName': middleName,
      'surName': surName,
      'phone': phone,
      'gender': gender,
      'address': address,
      'maritalStatus': maritalStatus,
      'dob': dob,
      'pollUnit': pollUnit,
      'isSubmit': isSubmit,

      'wholelist': wholelist,
      'userid': userid,
      'formid': formid,
      'subadminid': subadminid
    };
  }
}

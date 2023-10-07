class LocalDataModel {
  final Map<dynamic, dynamic> data;
  final bool shouldDeleteAfterUpload;

  LocalDataModel({
    required this.data,
    required this.shouldDeleteAfterUpload,
  });

  factory LocalDataModel.fromJson(Map<String, dynamic> json) {
    return LocalDataModel(
      data: json['data'],
      shouldDeleteAfterUpload: json['shouldDeleteAfterUpload'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'shouldDeleteAfterUpload': shouldDeleteAfterUpload,
    };
  }
}

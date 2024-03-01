class ResponseUploadPatientModel {
  String? sId;
  ResponseUploadPatientModel({this.sId});
  ResponseUploadPatientModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
  }
}

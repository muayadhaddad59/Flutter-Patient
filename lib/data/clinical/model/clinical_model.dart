class ClinicalDataModel {
  String? sId;
  int? bpSystolic;
  int? bpDiastolic;
  int? respiratoryRate;
  int? bloodOxygenLevel;
  int? pulseRate;
  String? clinicStaff;
  String? patientId;
  bool? isCriticalCondition;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ClinicalDataModel(
      {this.sId,
      this.bpSystolic,
      this.bpDiastolic,
      this.respiratoryRate,
      this.bloodOxygenLevel,
      this.pulseRate,
      this.clinicStaff,
      this.patientId,
      this.isCriticalCondition,
      this.createdAt,
      this.updatedAt,
      this.iV});

  ClinicalDataModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    bpSystolic = json['bp_systolic'];
    bpDiastolic = json['bp_diastolic'];
    respiratoryRate = json['respiratory_rate'];
    bloodOxygenLevel = json['blood_oxygen_level'];
    pulseRate = json['pulse_rate'];
    clinicStaff = json['clinic_staff'];
    patientId = json['patientId'];
    isCriticalCondition = json['is_critical_condition'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bp_systolic'] = bpSystolic;
    data['bp_diastolic'] = bpDiastolic;
    data['respiratory_rate'] = respiratoryRate;
    data['blood_oxygen_level'] = bloodOxygenLevel;
    data['pulse_rate'] = pulseRate;
    data['is_critical_condition'] = isCriticalCondition;
    return data;
  }
}

class ClinicalModel {
  List<ClinicalDataModel>? model;

  ClinicalModel({this.model});

  ClinicalModel.fromJson(List<dynamic> json) {
    model = json.map((e) => ClinicalDataModel.fromJson(e)).toList();
  }
}

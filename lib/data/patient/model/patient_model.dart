class PatientDataModel {
  String? sId;
  String? firstName;
  String? lastName;
  String? dateOfBirth;
  int? age;
  String? gender;
  int? height;
  int? weight;
  String? address;
  String? city;
  String? province;
  String? postalCode;
  String? contactNumber;
  String? email;
  String? identification;
  String? identificationType;
  String? purposeOfVisit;
  String? primaryCarePhysician;
  String? physicianContactNumber;
  String? listOfAllergies;
  String? currentMedications;
  String? medicalConditions;
  String? insuranceProvider;
  String? insuranceIdNumber;
  String? insuranceContactNumber;
  String? emergencyContactPerson;
  String? emergencyContactNumber;
  String? createdAt;
  String? updatedAt;
  int? iV;
  bool? isPatientCritical;

  PatientDataModel(
      {this.sId,
      this.firstName,
      this.lastName,
      this.dateOfBirth,
      this.age,
      this.gender,
      this.height,
      this.weight,
      this.address,
      this.city,
      this.province,
      this.postalCode,
      this.contactNumber,
      this.email,
      this.identification,
      this.identificationType,
      this.purposeOfVisit,
      this.primaryCarePhysician,
      this.physicianContactNumber,
      this.listOfAllergies,
      this.currentMedications,
      this.medicalConditions,
      this.insuranceProvider,
      this.insuranceIdNumber,
      this.insuranceContactNumber,
      this.emergencyContactPerson,
      this.emergencyContactNumber,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.isPatientCritical});

  PatientDataModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    dateOfBirth = json['dateOfBirth'];
    age = json['age'];
    gender = json['gender'];
    height = json['height'];
    weight = json['weight'];
    address = json['address'];
    city = json['city'];
    province = json['province'];
    postalCode = json['postalCode'];
    contactNumber = json['contactNumber'];
    email = json['email'];
    identification = json['identification'];
    identificationType = json['identificationType'];
    purposeOfVisit = json['purposeOfVisit'];
    primaryCarePhysician = json['primaryCarePhysician'];
    physicianContactNumber = json['physicianContactNumber'];
    listOfAllergies = json['listOfAllergies'];
    currentMedications = json['currentMedications'];
    medicalConditions = json['medicalConditions'];
    insuranceProvider = json['insuranceProvider'];
    insuranceIdNumber = json['insuranceIdNumber'];
    insuranceContactNumber = json['insuranceContactNumber'];
    emergencyContactPerson = json['emergencyContactPerson'];
    emergencyContactNumber = json['emergencyContactNumber'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    isPatientCritical = json['is_patient_critical'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['_id'] = sId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['dateOfBirth'] = dateOfBirth;
    data['age'] = age;
    data['gender'] = gender;
    data['height'] = height;
    data['weight'] = weight;
    data['address'] = address;
    data['city'] = city;
    data['province'] = province;
    data['postalCode'] = postalCode;
    data['contactNumber'] = contactNumber;
    data['email'] = email;
    data['identification'] = identification;
    data['identificationType'] = identificationType;
    data['purposeOfVisit'] = purposeOfVisit;
    data['primaryCarePhysician'] = primaryCarePhysician;
    data['physicianContactNumber'] = physicianContactNumber;
    data['listOfAllergies'] = listOfAllergies;
    data['currentMedications'] = currentMedications;
    data['medicalConditions'] = medicalConditions;
    data['insuranceProvider'] = insuranceProvider;
    data['insuranceIdNumber'] = insuranceIdNumber;
    data['insuranceContactNumber'] = insuranceContactNumber;
    data['emergencyContactPerson'] = emergencyContactPerson;
    data['emergencyContactNumber'] = emergencyContactNumber;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['is_patient_critical'] = isPatientCritical;
    return data;
  }

  PatientDataModel copyFrom(PatientDataModel other) {
    return PatientDataModel(
      sId: other.sId ?? sId,
      firstName: other.firstName ?? firstName,
      lastName: other.lastName ?? lastName,
      dateOfBirth: other.dateOfBirth ?? dateOfBirth,
      age: other.age ?? age,
      gender: other.gender ?? gender,
      height: other.height ?? height,
      weight: other.weight ?? weight,
      address: other.address ?? address,
      city: other.city ?? city,
      province: other.province ?? province,
      postalCode: other.postalCode ?? postalCode,
      contactNumber: other.contactNumber ?? contactNumber,
      email: other.email ?? email,
      identification: other.identification ?? identification,
      identificationType: other.identificationType ?? identificationType,
      purposeOfVisit: other.purposeOfVisit ?? purposeOfVisit,
      primaryCarePhysician: other.primaryCarePhysician ?? primaryCarePhysician,
      physicianContactNumber: other.physicianContactNumber ?? physicianContactNumber,
      listOfAllergies: other.listOfAllergies ?? listOfAllergies,
      currentMedications: other.currentMedications ?? currentMedications,
      medicalConditions: other.medicalConditions ?? medicalConditions,
      insuranceProvider: other.insuranceProvider ?? insuranceProvider,
      insuranceIdNumber: other.insuranceIdNumber ?? insuranceIdNumber,
      insuranceContactNumber: other.insuranceContactNumber ?? insuranceContactNumber,
      emergencyContactPerson: other.emergencyContactPerson ?? emergencyContactPerson,
      emergencyContactNumber: other.emergencyContactNumber ?? emergencyContactNumber,
      createdAt: other.createdAt ?? createdAt,
      updatedAt: other.updatedAt ?? updatedAt,
      iV: other.iV ?? iV,
      isPatientCritical: other.isPatientCritical ?? isPatientCritical,
    );
  }

}
class PatientModel {
  List<PatientDataModel>? model;

  PatientModel({this.model});

  PatientModel.fromJson(List<dynamic> json) {
    model = json.map((e) => PatientDataModel.fromJson(e)).toList();
  }
  
}

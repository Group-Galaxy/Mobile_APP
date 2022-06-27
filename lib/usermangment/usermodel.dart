class VehicleOwnerModel {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;

  VehicleOwnerModel({this.uid, this.email, this.firstName, this.secondName});

  // receiving data from server
  factory VehicleOwnerModel.fromMap(map) {
    return VehicleOwnerModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      secondName: map['secondName'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
    };
  }
}
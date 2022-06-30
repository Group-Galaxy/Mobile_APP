class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;
  String? contactNO;
  String? location;
  String? imgUrl;

  UserModel(
      {this.uid,
      this.email,
      this.firstName,
      this.secondName,
      this.contactNO,
      this.location,
      this.imgUrl});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        firstName: map['firstName'],
        contactNO: map['contactNo'],
        location: map['location'],
        imgUrl: map['imgUrl']);
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'contactNo': contactNO,
      'location': location,
      'imgUrl': imgUrl
    };
  }
}

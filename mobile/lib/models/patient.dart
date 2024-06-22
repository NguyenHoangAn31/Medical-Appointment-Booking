class Patient{
  late final int id;
  late final String fullName;
  late final String gender;
  late final String birthday;
  late final String address;
  late final String image;
  late final bool status;
  Patient({
    required this.id,
    required this.fullName,
    required this.gender,
    required this.birthday,
    required this.address,
    required this.image,
    required this.status,
  });
  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      fullName: json['fullName'],
      gender: json['gender'],
      birthday: json['birthday'],
      address: json['address'],
      image: json['image'],
      status: json['status'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'gender': gender,
      'birthday': birthday,
      'address': address,
      'image': image,
     'status': status,
    };
  }

}
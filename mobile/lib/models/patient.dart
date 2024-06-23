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
      id: json['id'] as int, // Convert 'id' to int
      fullName: json['fullName'] as String,
      gender: json['gender'] as String,
      birthday: json['birthday'] as String,
      address: json['address'] as String,
      image: json['image'] as String,
      status: json['status'] == 1, // Assuming 'status' is 1 or 0 in JSON
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
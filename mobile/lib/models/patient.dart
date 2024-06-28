class Patient{
  late final int id;
  late final String fullName;
  late final String gender;
  late final DateTime birthday;
  late final String address;
  late final String image;
  late final bool status;
  late final DateTime createdAt;
  Patient({
    required this.id,
    required this.fullName,
    required this.gender,
    required this.birthday,
    required this.address,
    required this.image,
    required this.status,
    required this.createdAt,
  });
  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'] as int,
      fullName: json['fullName'] as String,
      gender: json['gender'] as String,
      birthday: DateTime(
        (json['birthday'][0] as int),
        (json['birthday'][1] as int),
        (json['birthday'][2] as int),
      ),
      address: json['address'] as String,
      image: json['image'] as String,
      status: json['status'] as bool,
      createdAt: DateTime(
        (json['createdAt'][0] as int),
        (json['createdAt'][1] as int),
        (json['createdAt'][2] as int),
        (json['createdAt'][3] as int),
        (json['createdAt'][4] as int),
        (json['createdAt'][5] as int),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'gender': gender,
      'birthday': [birthday.year, birthday.month, birthday.day],
      'address': address,
      'image': image,
      'status': status,
      'createdAt': [
        createdAt.year,
        createdAt.month,
        createdAt.day,
        createdAt.hour,
        createdAt.minute,
        createdAt.second,
      ],
    };
  }

}
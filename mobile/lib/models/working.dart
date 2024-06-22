class Working{
  late final int id;
  late final String company;
  late final String address;
  late final String startWork;
  late final String endWork;
  late final bool status;
  late final int doctorId;
  Working({
    required this.id,
    required this.company,
    required this.address,
    required this.startWork,
    required this.endWork,
    required this.status,
    required this.doctorId,
  }) ;
  factory Working.fromJson(Map<String, dynamic> json) {
    return Working(
      id: json['id'],
      company: json['company'] ?? '',
      address: json['address'] ?? '',
      startWork: json['startWork'] ?? '',
      endWork: json['endWork'] ?? '',
      status: json['status'] as bool,
      doctorId: json['doctorId'] as int,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company': company,
      'address': address,
     'startWork': startWork,
      'endWork': endWork,
     'status': status,
      'doctorId': doctorId,
    };
  }


}
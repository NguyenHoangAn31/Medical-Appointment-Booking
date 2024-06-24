class Appointment{
  late final int id;
  late final int partientId;
  late final int scheduledoctorId;
  late final double price;
  late final String image;
  late final String title;
  late final String fullName;
  late final String departmentName;
  late final String status;
  late final String note;
  late final String appointmentDate;
  late final String clinicHours;
  late final String medicalExaminationDay;
  late final String payment;
  Appointment({
    required this.id,
    required this.partientId,
    required this.scheduledoctorId,
    required this.price,
    required this.image,
    required this.title,
    required this.fullName,
    required this.departmentName,
    required this.status,
    required this.note,
    required this.appointmentDate,
    required this.clinicHours,
    required this.medicalExaminationDay,
    required this.payment,
  });
  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      partientId: json['partientId'],
      scheduledoctorId: json['scheduledoctorId'],
      price: json['price'],
      image: json['image'],
      title: json['title'],
      fullName: json['fullName'],
      departmentName: json['departmentName'],
      status: json['status'],
      note: json['note'],
      appointmentDate: json['appointmentDate'],
      clinicHours: json['clinicHours'],
      medicalExaminationDay: json['medicalExaminationDay'],
      payment: json['payment'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'partientId': partientId,
      'scheduledoctorId': scheduledoctorId,
      'price': price,
      'image': image,
      'title': title,
      'fullName': fullName,
      'departmentName': departmentName,
      'status': status,
      'note': note,
      'appointmentDate': appointmentDate,
      'clinicHours': clinicHours,
      'medicalExaminationDay': medicalExaminationDay,
      'payment': payment,
    };
  }
}

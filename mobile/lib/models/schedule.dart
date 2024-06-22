class Schedule{
  final int? id;
  final String? startTime;
  final int? status;
  final int? scheduleDoctorId;
  Schedule({
    this.id,
    this.startTime,
    this.status,
    this.scheduleDoctorId,
  });

  factory Schedule.fromJson(Map<String, dynamic> json){
    return Schedule(
      id: json['id'],
      startTime: json['startTime'],
      status: json['status'],
      scheduleDoctorId: json['scheduleDoctorId'],
    );
  }
  Map<String, dynamic> toJson(){
    return {
      'id': id,
     'startTime': startTime,
     'status': status,
     'scheduleDoctorId': scheduleDoctorId,
    };
  }
}
class Schedule{
  final int? id;
  final String? startTime;
  final int? status;
  late final int scheduledoctorId;
  Schedule({
    this.id,
    this.startTime,
    this.status,
    required this.scheduledoctorId,
  });

  factory Schedule.fromJson(Map<String, dynamic> json){
    return Schedule(
      id: json['id'],
      startTime: json['startTime'],
      status: json['status'],
      scheduledoctorId: json['scheduledoctorId'],
    );
  }
  Map<String, dynamic> toJson(){
    return {
      'id': id,
     'startTime': startTime,
     'status': status,
     'scheduledoctorId': scheduledoctorId,
    };
  }
}
class ScheduleDoctor{
  late final int id;
  late final int doctorId;
  late final int scheduleId;
  ScheduleDoctor({
    required this.id,
    required this.doctorId,
    required this.scheduleId,
  });
  factory ScheduleDoctor.fromJson(Map<String, dynamic> json){
    return ScheduleDoctor(
      id: json['id'],
      doctorId: json['doctor_id'],
      scheduleId: json['schedule_id'],
    );
  }
  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'doctor_id': doctorId,
     'schedule_id': scheduleId,
    };
  }
}
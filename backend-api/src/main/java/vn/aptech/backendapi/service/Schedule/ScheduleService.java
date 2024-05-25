package vn.aptech.backendapi.service.Schedule;

import vn.aptech.backendapi.dto.ScheduleDto;

import java.time.LocalDate;
import java.util.List;

public interface ScheduleService {


    // Hàm tìm lịch theo doctorID
    List<ScheduleDto> findScheduleByDoctorId(int doctorId);

    // Hàm tìm lịch theo DayWorking
    List<ScheduleDto> findByDayWorking(LocalDate dayWorking);

    List<ScheduleDto> findByDayWorkingAndDoctorId(LocalDate dayWorking, int doctorId);
}

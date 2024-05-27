package vn.aptech.backendapi.service.Schedule;

import vn.aptech.backendapi.dto.SlotDto;
import vn.aptech.backendapi.dto.Schedule.ScheduleWithDepartmentDto;

import java.time.LocalDate;
import java.util.List;

public interface ScheduleService {

    // // Hàm tìm lịch theo doctorID
    // List<ScheduleDto> findByDoctorId(int doctorId);

    // // Hàm tìm lịch theo DayWorking
    // List<ScheduleDto> findByDayWorking(LocalDate dayWorking);

    // List<ScheduleDto> findByDayWorkingAndDoctorId(LocalDate dayWorking, int
    // doctorId);

    // void updateScheduleForAdmin(int clinicId , int departmentId , int slotId ,
    // int[] doctorList);

    ScheduleWithDepartmentDto getDepartmentsWithSlotsAndDoctors(LocalDate dayWorking);
    List<String> findAllOnlyDay();
    List<SlotDto> findSlotsByDayAndDoctorId(LocalDate dayWorking, int doctorId);

}

package vn.aptech.backendapi.service.Schedule;

import vn.aptech.backendapi.dto.CustomSlotWithScheduleDoctorId;
import vn.aptech.backendapi.dto.SlotDto;
import vn.aptech.backendapi.dto.Schedule.ScheduleWithDepartmentDto;

import java.time.LocalDate;
import java.util.List;

public interface ScheduleService {


    ScheduleWithDepartmentDto getDepartmentsWithSlotsAndDoctors(LocalDate dayWorking);
    List<Object[]> findAllOnlyDay();
    List<CustomSlotWithScheduleDoctorId> findSlotsByDayAndDoctorId(LocalDate dayWorking, int doctorId);
    void updateScheduleForAdmin(LocalDate dayWorking , int departmentId , int slotId ,
    int[] doctorList);

}

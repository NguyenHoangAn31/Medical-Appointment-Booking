package vn.aptech.backendapi.service.Clinic;

import java.time.LocalDate;
import java.util.List;

import vn.aptech.backendapi.dto.Schedule.ClinicScheduleDTO;


public interface ClinicService {
    List<String> findAllOnlyDay();
    ClinicScheduleDTO getDepartmentsWithSlotsAndDoctors(LocalDate dayWorking);
    
}

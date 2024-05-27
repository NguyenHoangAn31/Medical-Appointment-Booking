package vn.aptech.backendapi.service.Clinic;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import vn.aptech.backendapi.dto.Schedule.ClinicScheduleDTO;
import vn.aptech.backendapi.dto.Schedule.DepartmentWithSlotsDTO;
import vn.aptech.backendapi.dto.Schedule.DoctorDtoForSchedule;
import vn.aptech.backendapi.dto.Schedule.SlotWithDoctorsDTO;
import vn.aptech.backendapi.entities.ClinicSchedule;
import vn.aptech.backendapi.entities.Department;
import vn.aptech.backendapi.entities.Doctor;
import vn.aptech.backendapi.entities.Slot;
import vn.aptech.backendapi.repository.ClinicScheduleRepository;

@Service
public class ClinicServiceImpl implements ClinicService {
    @Autowired
    private ClinicScheduleRepository clinicScheduleRepository;



    @Override
    public List<String> findAllOnlyDay() {
        return clinicScheduleRepository.findDistinctDayWork();
    }

    @Override
    public ClinicScheduleDTO getDepartmentsWithSlotsAndDoctors(LocalDate dayWorking) {
        ClinicSchedule clinicSchedule = clinicScheduleRepository.findByDayWorking(dayWorking);

        List<Department> departments = clinicScheduleRepository.findDistinctDepartmentsByDayWorking(dayWorking);

        List<DepartmentWithSlotsDTO> departmentWithSlotsDTOs = departments.stream().map(department -> {
            List<Slot> slots = clinicScheduleRepository.findDistinctSlotsByDayWorkingAndDepartment(dayWorking, department.getId());
            List<SlotWithDoctorsDTO> slotDTOs = slots.stream().map(slot -> {
                List<Doctor> doctors = clinicScheduleRepository.findDoctorsByDayWorkingAndDepartmentAndSlot(dayWorking, department.getId(), slot.getId());
                List<DoctorDtoForSchedule> doctorDTOs = doctors.stream().map(doctor -> new DoctorDtoForSchedule(doctor.getId(), doctor.getFullName(),doctor.getImage())).collect(Collectors.toList());
                return new SlotWithDoctorsDTO(slot.getId() , slot.getStartTime().toString(), slot.getEndTime().toString(), doctorDTOs);
            }).collect(Collectors.toList());
            return new DepartmentWithSlotsDTO(department.getId(), department.getName() , department.getIcon(), slotDTOs);
        }).collect(Collectors.toList());

        return new ClinicScheduleDTO(clinicSchedule.getId(), dayWorking.toString(), departmentWithSlotsDTOs);


    }
}

package vn.aptech.backendapi.service.Schedule;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import vn.aptech.backendapi.dto.SlotDto;
import vn.aptech.backendapi.dto.Schedule.DepartmentWithSlotsDTO;
import vn.aptech.backendapi.dto.Schedule.DoctorDtoForSchedule;
import vn.aptech.backendapi.dto.Schedule.ScheduleWithDepartmentDto;
import vn.aptech.backendapi.dto.Schedule.SlotWithDoctorsDTO;
import vn.aptech.backendapi.entities.Department;
import vn.aptech.backendapi.entities.Doctor;
import vn.aptech.backendapi.entities.Slot;

import vn.aptech.backendapi.repository.ScheduleRepository;


import java.time.LocalDate;
import java.util.List;

import java.util.stream.Collectors;

@Service
public class ScheduleServiceImpl implements ScheduleService {
    @Autowired
    private ScheduleRepository scheduleRepository;


    @Override
    public List<String> findAllOnlyDay() {
        return scheduleRepository.findDistinctDayWork();
    }

    @Override
    public ScheduleWithDepartmentDto getDepartmentsWithSlotsAndDoctors(LocalDate dayWorking) {

        List<Department> departments = scheduleRepository.findDistinctDepartmentsByDay(dayWorking);

        List<DepartmentWithSlotsDTO> departmentWithSlotsDTOs = departments.stream().map(department -> {
            List<Slot> slots = scheduleRepository.findDistinctSlotsByDayWorkingAndDepartment(dayWorking,
                    department.getId());
            List<SlotWithDoctorsDTO> slotDTOs = slots.stream().map(slot -> {
                List<Doctor> doctors = scheduleRepository.findDoctorsByDayWorkingAndDepartmentAndSlot(dayWorking,
                        department.getId(), slot.getId());
                List<DoctorDtoForSchedule> doctorDTOs = doctors.stream().map(
                        doctor -> new DoctorDtoForSchedule(doctor.getId(), doctor.getFullName(), doctor.getImage()))
                        .collect(Collectors.toList());
                return new SlotWithDoctorsDTO(slot.getId(), slot.getStartTime().toString(),
                        slot.getEndTime().toString(), doctorDTOs);
            }).collect(Collectors.toList());
            return new DepartmentWithSlotsDTO(department.getId(), department.getName(), department.getIcon(), slotDTOs);
        }).collect(Collectors.toList());

        return new ScheduleWithDepartmentDto(dayWorking.toString(), departmentWithSlotsDTOs);

    }

    public List<SlotDto> findSlotsByDayAndDoctorId(LocalDate dayWorking, int doctorId){
        List<Slot> s = scheduleRepository.findSlotsByDayAndDoctorId(dayWorking,doctorId);
        return s.stream().map(
            slot -> new SlotDto(slot.getId(), slot.getStartTime().toString(), slot.getEndTime().toString()))
            .collect(Collectors.toList());
    }

   
}

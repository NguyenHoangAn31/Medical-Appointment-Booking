package vn.aptech.backendapi.service.Schedule;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import vn.aptech.backendapi.dto.ScheduleDto;
import vn.aptech.backendapi.dto.SlotDto;
import vn.aptech.backendapi.entities.ClinicSchedule;
import vn.aptech.backendapi.entities.Department;
import vn.aptech.backendapi.entities.Doctor;
import vn.aptech.backendapi.entities.Schedule;
import vn.aptech.backendapi.entities.Slot;
import vn.aptech.backendapi.repository.ClinicScheduleRepository;
import vn.aptech.backendapi.repository.DepartmentRepository;
import vn.aptech.backendapi.repository.DoctorRepository;
import vn.aptech.backendapi.repository.ScheduleRepository;
import vn.aptech.backendapi.repository.SlotRepository;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class ScheduleServiceImpl implements ScheduleService {
    @Autowired
    private ScheduleRepository scheduleRepository;

    @Autowired
    private ClinicScheduleRepository clinicScheduleRepository;

    @Autowired
    private DepartmentRepository departmentRepository;

    @Autowired
    private SlotRepository slotRepository;

    @Autowired
    private DoctorRepository doctorRepository;

    @Autowired
    private ModelMapper mapper;

    private ScheduleDto mapToScheduleDto(Schedule schedule) {
        if (schedule == null) {
            return null;
        }

        ScheduleDto scheduleDto = new ScheduleDto();
        scheduleDto.setId(schedule.getId());
        scheduleDto.setDoctorId(schedule.getDoctor().getId());
        scheduleDto.setClinicScheduleId(schedule.getClinicSchedule().getId());
        scheduleDto.setDayWorking(schedule.getClinicSchedule().getDayWorking().toString());
        scheduleDto.setSlot(mapper.map(schedule.getSlot(), SlotDto.class));
        scheduleDto.setStatus(schedule.isStatus());

        // Lấy danh sách các SlotInfo từ schedulesOfDay

        return scheduleDto;
    }

    // Hàm tìm lịch theo doctorID
    @Override
    public List<ScheduleDto> findByDoctorId(int doctorId) {
        List<Schedule> schedules = scheduleRepository.findByDoctorId(doctorId);
        return schedules.stream()
                .map(schedule -> mapToScheduleDto(schedule))
                .collect(Collectors.toList());
    }

    // Hàm tìm lịch theo DayWorking
    @Override
    public List<ScheduleDto> findByDayWorking(LocalDate dayWorking) {
        List<Schedule> schedules = scheduleRepository.findByClinicSchedule_DayWorking(dayWorking);

        return schedules.stream()
                .map(schedule -> mapToScheduleDto(schedule))
                .collect(Collectors.toList());
    }

    public List<ScheduleDto> findByDayWorkingAndDoctorId(LocalDate dayWorking, int doctorId) {
        List<Schedule> schedules = scheduleRepository.findByClinicScheduleDayWorkingAndDoctorId(dayWorking, doctorId);
        return schedules.stream()
                .map(schedule -> mapToScheduleDto(schedule))
                .collect(Collectors.toList());
    }

    // Insert

    // Update

    // Delete

    // writed by An in 27/5
    public void updateScheduleForAdmin(int clinicId, int departmentId, int slotId, int[] doctorList) {
        List<Schedule> schedules = scheduleRepository.findByClinicIdAndDepartmentIdAndSlotId(clinicId, departmentId,
                slotId);

        List<Integer> existingDoctorIds = new ArrayList<>();
        for (Schedule schedule : schedules) {
            existingDoctorIds.add(schedule.getDoctor().getId());
        }

        List<Integer> newDoctorIds = new ArrayList<>();
        for (int doctorId : doctorList) {
            newDoctorIds.add(doctorId);
        }

        for (Schedule schedule : schedules) {
            if (!newDoctorIds.contains(schedule.getDoctor().getId())) {
                scheduleRepository.delete(schedule);
            }
        }

        for (int doctorId : doctorList) {
            if (!existingDoctorIds.contains(doctorId)) {
                Schedule schedule = new Schedule();

                Optional<Doctor> d = doctorRepository.findById(doctorId);
                d.ifPresent(doctor -> schedule.setDoctor(mapper.map(d, Doctor.class)));

                Optional<ClinicSchedule> c = clinicScheduleRepository.findById(clinicId);
                c.ifPresent(clinic -> schedule.setClinicSchedule(mapper.map(c, ClinicSchedule.class)));

                Optional<Department> department = departmentRepository.findById(departmentId);
                department.ifPresent(de -> schedule.setDepartment(mapper.map(department, Department.class)));

                Optional<Slot> s = slotRepository.findById(slotId);
                s.ifPresent(slot -> schedule.setSlot(mapper.map(s, Slot.class)));

                scheduleRepository.save(schedule);
            }
        }
    }

}

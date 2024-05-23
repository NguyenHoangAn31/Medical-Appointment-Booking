package vn.aptech.backendapi.service.Clinic;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import vn.aptech.backendapi.dto.ClinicDto;
import vn.aptech.backendapi.dto.DepartmentDto;
import vn.aptech.backendapi.dto.ScheduleDto;
import vn.aptech.backendapi.dto.CustomSchedule;
import vn.aptech.backendapi.dto.SlotDto;
import vn.aptech.backendapi.entities.ClinicSchedule;
import vn.aptech.backendapi.entities.Schedule;
import vn.aptech.backendapi.repository.ClinicScheduleRepository;
import vn.aptech.backendapi.service.Department.DepartmentService;
import vn.aptech.backendapi.service.Doctor.DoctorService;
import vn.aptech.backendapi.service.User.UserService;

@Service
public class ClinicServiceImpl implements ClinicService {
    @Autowired
    private ClinicScheduleRepository clinicScheduleRepository;

    @Autowired
    private ModelMapper mapper;

    @Autowired
    private UserService userService;

    @Autowired
    private DoctorService doctorService;

    @Autowired
    private DepartmentService departmentService;

    private ScheduleDto toScheduleDto(Schedule s) {
        ScheduleDto schedule = new ScheduleDto();
        schedule.setId(s.getId());
        schedule.setStatus(s.isStatus());
        schedule.setDepartment_id(s.getDepartment().getId());
        schedule.setSlot(mapper.map(s.getSlot(), SlotDto.class));
        if (s.getDoctor() != null) {
            schedule.setDoctorDto(doctorService.findById(s.getDoctor().getId()).get());
        }
        return schedule;
    }

    private CustomSchedule customSchedulesDto(Schedule s) {
        CustomSchedule schedule = new CustomSchedule();
        DepartmentDto departmentDto = departmentService.findById(s.getDepartment().getId()).orElse(null);
        if (departmentDto != null) {
            schedule.setDepartmentDto(departmentDto);
        }
        return schedule;
    }

    private ClinicDto toDto(ClinicSchedule c) {
        ClinicDto clinic = new ClinicDto();
        clinic.setId(c.getId());
        clinic.setStatus(c.getStatus());
        clinic.setDayWorking(c.getDayWorking().toString());
        clinic.setUser(userService.findById(c.getUser().getId()).orElse(null));

        List<CustomSchedule> customSchedules = c.getSchedules().stream()
                .map(this::customSchedulesDto)
                .collect(Collectors.toList());


        Set<DepartmentDto> seenDepartments = new HashSet<>();

        List<CustomSchedule> uniqueSchedules = customSchedules.stream()
                .filter(schedule -> seenDepartments.add(schedule.getDepartmentDto()))
                .collect(Collectors.toList());

        uniqueSchedules.forEach(customSchedule -> {
            List<ScheduleDto> scheduleDtos = c.getSchedules().stream()
                    .filter(schedule -> schedule.getDepartment().getId() == customSchedule.getDepartmentDto().getId())
                    .map(this::toScheduleDto)
                    .collect(Collectors.toList());
            customSchedule.setSchedules(scheduleDtos);
        });

        clinic.setSchedules(uniqueSchedules);

        // clinic.setSchedules(c.getSchedules().stream().map(this::toScheduleDto).collect(Collectors.toList()));
        return clinic;
    }

    @Override
    public List<String> findAllOnlyDay() {
        return clinicScheduleRepository.findDistinctDayWork();
    }

    @Override
    public Optional<ClinicDto> searchByDay(String day) {
        Optional<ClinicSchedule> c = clinicScheduleRepository.findScheduleByDay(day);
        return c.map(this::toDto);

    }
}

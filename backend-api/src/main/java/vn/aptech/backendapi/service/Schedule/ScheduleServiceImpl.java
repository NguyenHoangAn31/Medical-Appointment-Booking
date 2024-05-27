package vn.aptech.backendapi.service.Schedule;


import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import vn.aptech.backendapi.dto.DoctorDto;
import vn.aptech.backendapi.dto.ScheduleDto;
import vn.aptech.backendapi.dto.SlotDto;
import vn.aptech.backendapi.entities.Schedule;
import vn.aptech.backendapi.repository.ScheduleRepository;
import vn.aptech.backendapi.service.Doctor.DoctorService;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class ScheduleServiceImpl implements ScheduleService {
    @Autowired
    private ScheduleRepository scheduleRepository;

    @Autowired
    private DoctorService doctorService;

    @Autowired
    private ModelMapper mapper; 

    private ScheduleDto mapToScheduleDto(Schedule schedule) {
        if (schedule == null) {
            return null;
        }

        ScheduleDto scheduleDto = new ScheduleDto();
        scheduleDto.setId(schedule.getId());
        scheduleDto.setDoctorDto(doctorService.findById(schedule.getDoctor().getId()).get());
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




}

package vn.aptech.backendapi.service.Appointment;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.Optional;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import vn.aptech.backendapi.dto.AppointmentDto;
import vn.aptech.backendapi.entities.Appointment;

import vn.aptech.backendapi.entities.Partient;
import vn.aptech.backendapi.entities.ScheduleDoctor;
import vn.aptech.backendapi.repository.AppointmentRepository;
import vn.aptech.backendapi.repository.PartientRepository;
import vn.aptech.backendapi.repository.ScheduleDoctorRepository;

@Service
public class AppointmentServiceImpl implements AppointmentService {

    @Autowired
    private AppointmentRepository appointmentRepository;
    @Autowired
    private ModelMapper mapper;
    @Autowired
    private PartientRepository partientRepository;
    @Autowired
    private ScheduleDoctorRepository scheduleDoctorRepository;


    private AppointmentDto toDto(Appointment appointment) {
        AppointmentDto a = mapper.map(appointment, AppointmentDto.class);
        a.setPartientId(appointment.getPartient().getId());
        a.setScheduledoctorId(appointment.getScheduledoctor().getId());
        return a;
    }

    public AppointmentDto save(AppointmentDto dto) {
        Appointment a = mapper.map(dto, Appointment.class);
        a.setBookingDate(LocalDate.parse(dto.getBookingDate()));
        a.setClinicHours(LocalTime.parse(dto.getClinicHours()));
        if(dto.getPartientId() != 0){
            Optional<Partient> p = partientRepository.getPatientByUserId(dto.getPartientId());
            p.ifPresent(patient -> a.setPartient(mapper.map(p, Partient.class)));
        }
        if(dto.getScheduledoctorId() != 0){
            Optional<ScheduleDoctor> s = scheduleDoctorRepository.findById(dto.getScheduledoctorId());
            s.ifPresent(scheduledoctor -> a.setScheduledoctor(mapper.map(s,ScheduleDoctor.class)));
        }
        Appointment result = appointmentRepository.save(a);
        return toDto(result);
    }

}

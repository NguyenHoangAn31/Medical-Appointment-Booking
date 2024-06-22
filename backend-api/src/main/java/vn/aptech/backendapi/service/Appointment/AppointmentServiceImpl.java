package vn.aptech.backendapi.service.Appointment;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import vn.aptech.backendapi.dto.AppointmentDto;
import vn.aptech.backendapi.dto.PatientDto;
import vn.aptech.backendapi.dto.Appointment.AppointmentDetail;
import vn.aptech.backendapi.dto.Appointment.CustomAppointmentDto;
import vn.aptech.backendapi.entities.Appointment;

import vn.aptech.backendapi.entities.Partient;
import vn.aptech.backendapi.entities.ScheduleDoctor;
import vn.aptech.backendapi.repository.AppointmentRepository;
import vn.aptech.backendapi.repository.PartientRepository;
import vn.aptech.backendapi.repository.ScheduleDoctorRepository;
import vn.aptech.backendapi.service.Doctor.DoctorService;
import vn.aptech.backendapi.service.Patient.PatientService;

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
    @Autowired
    private PatientService patientService;
    @Autowired
    private DoctorService doctorService;

    private AppointmentDto toDto(Appointment appointment) {
        AppointmentDto a = mapper.map(appointment, AppointmentDto.class);
        a.setPartientId(appointment.getPartient().getId());
        a.setScheduledoctorId(appointment.getScheduledoctor().getId());
        return a;
    }

    private CustomAppointmentDto toCustomDto(Appointment appointment) {
        CustomAppointmentDto a = mapper.map(appointment, CustomAppointmentDto.class);
        // a.setImage(partientRepository.findById(appointment.getPartient().getId()).get().getImage());
        // a.setFullName(partientRepository.findById(appointment.getPartient().getId()).get().getFullName());
        a.setPatientDto(mapper.map(appointment.getPartient(), PatientDto.class));
        return a;
    }

    private AppointmentDetail toAppointmentDetail(Appointment appointment) {
        AppointmentDetail a = mapper.map(appointment, AppointmentDetail.class);
        a.setPatient(patientService.getPatientByPatientId(appointment.getPartient().getId()).get());
        a.setDoctor(doctorService.findById(appointment.getScheduledoctor().getDoctor().getId()).get());
        return a;
    }

    @Override
    public List<CustomAppointmentDto> findAll() {
        List<Appointment> a = appointmentRepository.findAll();
        return a.stream().map(this::toCustomDto)
                .collect(Collectors.toList());
    }

    @Override
    public boolean changestatus(int id, String status) {
        Appointment a = appointmentRepository.findById(id).get();
        a.setStatus(status);
        try {
            appointmentRepository.save(a);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public AppointmentDetail appointmentDetail(int appointmentId) {
        Appointment a = appointmentRepository.findById(appointmentId).get();
        return toAppointmentDetail(a);
    }

    @Override
    public AppointmentDto save(AppointmentDto dto) {
        Appointment a = mapper.map(dto, Appointment.class);
        a.setAppointmentDate(LocalDate.parse(dto.getAppointmentDate()));
        a.setMedicalExaminationDay(LocalDate.parse(dto.getMedicalExaminationDay()));
        a.setClinicHours(LocalTime.parse(dto.getClinicHours()));
        if (dto.getPartientId() != 0) {
            Partient p = partientRepository.getPatientByUserId(dto.getPartientId());
            a.setPartient(mapper.map(p, Partient.class));
        }
        if (dto.getScheduledoctorId() != 0) {
            Optional<ScheduleDoctor> s = scheduleDoctorRepository.findById(dto.getScheduledoctorId());
            s.ifPresent(scheduledoctor -> a.setScheduledoctor(mapper.map(s, ScheduleDoctor.class)));
        }
        Appointment result = appointmentRepository.save(a);
        return toDto(result);
    }

    @Override
    public List<CustomAppointmentDto> findPatientsByDoctorIdAndAppointmentDates(int doctorId , LocalDate startDate , LocalDate endDate){
        return appointmentRepository.findPatientsByDoctorIdAndAppointmentDates(doctorId,startDate,endDate).stream().map(this::toCustomDto)
        .collect(Collectors.toList());
    }

    @Override
    public List<CustomAppointmentDto> findPatientsByDoctorIdAndMedicalExaminationDates(int doctorId , LocalDate startDate , LocalDate endDate){
        return appointmentRepository.findPatientsByDoctorIdAndMedicalExaminationDates(doctorId,startDate,endDate).stream().map(this::toCustomDto)
        .collect(Collectors.toList());
    }

}

package vn.aptech.backendapi.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import vn.aptech.backendapi.dto.AppointmentDto;
import vn.aptech.backendapi.dto.PatientDoctorInfo;
import vn.aptech.backendapi.dto.Appointment.CustomAppointmentDto;
import vn.aptech.backendapi.repository.AppointmentRepository;
import vn.aptech.backendapi.service.Appointment.AppointmentService;

@RestController
@RequestMapping(value = "/api/appointment", produces = MediaType.APPLICATION_JSON_VALUE)
public class AppointmentController {
    @Autowired
    private AppointmentService appointmentService;

    @Autowired
    private AppointmentRepository appointmentRepository;


    @GetMapping(value = "/all", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<List<CustomAppointmentDto>> findAll() {
        List<CustomAppointmentDto> result = appointmentService.findAll();
        return ResponseEntity.ok(result);
    }


    @PostMapping(value = "/create")
    public ResponseEntity<AppointmentDto> test(@RequestBody AppointmentDto dto) {
        System.out.println(dto);
        AppointmentDto result = appointmentService.save(dto);
        if (result != null) {
            return ResponseEntity.ok(result);
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}

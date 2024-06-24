package vn.aptech.backendapi.controller;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import vn.aptech.backendapi.dto.CustomDoctorForEdit;
import vn.aptech.backendapi.dto.CustomPatientEditDto;
import vn.aptech.backendapi.dto.PatientDto;
import vn.aptech.backendapi.entities.Partient;
import vn.aptech.backendapi.repository.PartientRepository;
import vn.aptech.backendapi.service.Patient.PatientService;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@RestController
@RequestMapping(value = "/api/patient", produces = MediaType.APPLICATION_JSON_VALUE)
public class PatientController {

    @Autowired
    private PatientService patientService;

    @GetMapping("/{userId}")
    public ResponseEntity<PatientDto> findByUserId(@PathVariable("userId") int userId) {
        Optional<PatientDto> result = patientService.getPatientByUserId(userId);
        if (result.isPresent()) {
            return ResponseEntity.ok(result.get());
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    // writed by An in 5/6
    @GetMapping("/patientid/{patientId}")
    public ResponseEntity<PatientDto> findByPatientId(@PathVariable("patientId") int patientId) {
        Optional<PatientDto> result = patientService.getPatientByPatientId(patientId);
        if (result.isPresent()) {
            return ResponseEntity.ok(result.get());
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    // wrtied by An in 5/11
    @GetMapping("/all")
    public ResponseEntity<List<PatientDto>> findAll() {
        List<PatientDto> result = patientService.getAll();
        return ResponseEntity.ok(result);
    }


    @GetMapping("/patientbyscheduledoctoridandstarttime/{scheduledoctorid}/{starttime}")
    public ResponseEntity<List<PatientDto>> test(
            @PathVariable(value = "starttime", required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalTime starttime,
            @PathVariable("scheduledoctorid") int scheduledoctorid
    ) {
        List<PatientDto> result = patientService.findPatientsByScheduleDoctorIdAndStartTime(scheduledoctorid,starttime);
        return ResponseEntity.ok(result);
    }


    @GetMapping("/patientsbydoctoridandfinishedstatus/{doctorId}")
    public ResponseEntity<List<PatientDto>> getPatientsByDoctorIdAndFinishedStatus(
            @PathVariable("doctorId") int doctorId) {
        List<PatientDto> result = patientService.findPatientsByDoctorIdAndFinishedStatus(doctorId);
        return ResponseEntity.ok(result);
    }

    @PutMapping(value = "/edit-patient/{patientId}", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<?> editPatient(@PathVariable("patientId") int patientId,@RequestBody CustomPatientEditDto dto) throws IOException {
        boolean result = patientService.editPatient(patientId, dto);
        if (result) {
            return ResponseEntity.ok().build();
        }
        return ResponseEntity.notFound().build();
    }

    @GetMapping(value = "/get-patient-detail/{patientId}", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<CustomPatientEditDto> getPatientDetail(@PathVariable("patientId") int patientId) throws IOException {
        CustomPatientEditDto result = patientService.getPatientDetail(patientId);
        if (result != null) {
            return ResponseEntity.ok(result);
        }
        return ResponseEntity.notFound().build();
    }

}

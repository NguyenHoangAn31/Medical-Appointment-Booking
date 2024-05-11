package vn.aptech.backendapi.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import vn.aptech.backendapi.dto.DepartmentDto;
import vn.aptech.backendapi.dto.PatientDto;
import vn.aptech.backendapi.service.Patient.PatientService;

import java.util.List;
import java.util.Optional;

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

    @PutMapping(value = "/changestatus/{id}/{status}", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<?> changeStatusPatient(@PathVariable("id") int id, @PathVariable("status") int status) {
        boolean changed = patientService.changeStatus(id, status);
        if (changed) {
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}

package vn.aptech.backendapi.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import vn.aptech.backendapi.dto.PatientDto;
import vn.aptech.backendapi.service.Patient.PatientService;

import java.util.Optional;

@RestController
@RequestMapping(value = "/api/patient", produces = MediaType.APPLICATION_JSON_VALUE )
public class PatientController {

    @Autowired
    private PatientService patientService;


    @GetMapping("/{userId}")
    public ResponseEntity<PatientDto> findByUserId(@PathVariable("userId") int userId){
        Optional<PatientDto> result = patientService.getPatientByUserId(userId);
        if (result.isPresent()) {
            return ResponseEntity.ok(result.get());
        } else {
            return ResponseEntity.notFound().build();
        }
    }
    //writed by An in 5/6
    @GetMapping("/patientid/{patientId}")
    public ResponseEntity<PatientDto> findByPatientId(@PathVariable("patientId") int patientId){
        Optional<PatientDto> result = patientService.getPatientByPatientId(patientId);
        if (result.isPresent()) {
            return ResponseEntity.ok(result.get());
        } else {
            return ResponseEntity.notFound().build();
        }
    }

}

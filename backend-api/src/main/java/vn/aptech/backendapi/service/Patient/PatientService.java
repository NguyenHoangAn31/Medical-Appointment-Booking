package vn.aptech.backendapi.service.Patient;

import vn.aptech.backendapi.dto.PatientDto;

import java.util.Optional;

public interface PatientService {
    Optional<PatientDto> getPatientByUserId(int userId);
    // writed by An in 5/6
    Optional<PatientDto> getPatientByPatientId(int patientId);
}

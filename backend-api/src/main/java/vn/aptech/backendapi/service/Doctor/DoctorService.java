package vn.aptech.backendapi.service.Doctor;

import vn.aptech.backendapi.dto.DoctorDto;

import java.util.List;
import java.util.Optional;

public interface DoctorService {
    List<DoctorDto> findAll();
    Optional<DoctorDto> findById(int id);
}

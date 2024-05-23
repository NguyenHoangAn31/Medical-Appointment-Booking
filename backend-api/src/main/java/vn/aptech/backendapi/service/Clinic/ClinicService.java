package vn.aptech.backendapi.service.Clinic;

import java.util.List;
import java.util.Optional;

import vn.aptech.backendapi.dto.ClinicDto;

public interface ClinicService {
    List<String> findAllOnlyDay();
    Optional<ClinicDto> searchByDay(String day);
    
}

package vn.aptech.backendapi.service.Working;

import java.util.List;
import java.util.Optional;

import vn.aptech.backendapi.dto.WorkingDto;

public interface WorkingService {
    List<WorkingDto> findAll();
    Optional<WorkingDto> findById(int id);
    WorkingDto save(WorkingDto dto);
    boolean deleteById(int id);
}

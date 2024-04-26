package vn.aptech.backendapi.service.Department;

import java.util.List;
import java.util.Optional;

import vn.aptech.backendapi.dto.DepartmentDto;

public interface DepartmentService {
    List<DepartmentDto> findAll();
    Optional<DepartmentDto> findById(int id);
    DepartmentDto save(DepartmentDto dto);
    boolean deleteById(int id);
}

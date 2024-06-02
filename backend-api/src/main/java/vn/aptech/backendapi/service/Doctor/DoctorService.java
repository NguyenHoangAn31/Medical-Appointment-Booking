package vn.aptech.backendapi.service.Doctor;

import vn.aptech.backendapi.dto.DoctorDto;

import java.util.List;
import java.util.Optional;

public interface DoctorService {
    List<DoctorDto> findAll();
    Optional<DoctorDto> findById(int id);
    DoctorDto findByUserId(int id);
    //Hien Create 30/4/2024
    List<DoctorDto> findDoctorsByDepartmentId(int departmentId);
    // writed by An in 5/11
    boolean changeStatus(int id,int status);
    DoctorDto updatePriceAndDepartment(int id , double price , int departmentId);
    List<DoctorDto> findAllWithAllStatus();

    List<DoctorDto> searchDoctorsByName(String name);

}

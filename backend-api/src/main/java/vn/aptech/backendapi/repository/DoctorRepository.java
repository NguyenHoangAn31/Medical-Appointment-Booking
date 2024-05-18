package vn.aptech.backendapi.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import vn.aptech.backendapi.entities.Doctor;

import java.util.List;
import java.util.Optional;

public interface DoctorRepository extends JpaRepository<Doctor, Integer> {
    // Hien Create 30/4/2024
    List<Doctor> findDoctorsByDepartmentId(int id);
    List<Doctor> findDoctorsByFullNameContaining(String name);
}

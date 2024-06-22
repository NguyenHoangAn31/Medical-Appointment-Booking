package vn.aptech.backendapi.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import vn.aptech.backendapi.entities.Doctor;

import java.util.List;

public interface DoctorRepository extends JpaRepository<Doctor, Integer> {
    // Hien Create 30/4/2024
    List<Doctor> findDoctorsByDepartmentId(int id);
    List<Doctor> findDoctorsByFullNameContaining(String name);

    @Query("SELECT d FROM Doctor d WHERE d.user.id = :userId")
    Doctor findDoctorByUserId(@Param("userId") int userId);

    @Query("SELECT d FROM Doctor d WHERE d.department.id IS NULL")
    List<Doctor> findDoctorsWithNoDepartment();
}

package vn.aptech.backendapi.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import vn.aptech.backendapi.entities.Department;

@Repository
public interface DepartmentRepository extends JpaRepository<Department, Integer> {
}
package vn.aptech.backendapi.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import vn.aptech.backendapi.entities.ClinicSchedule;

public interface ClinicScheduleRepository extends JpaRepository<ClinicSchedule, Integer> {
}

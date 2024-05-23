package vn.aptech.backendapi.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import vn.aptech.backendapi.entities.ClinicSchedule;

import java.time.LocalDate;
import java.util.List;

public interface ClinicScheduleRepository extends JpaRepository<ClinicSchedule, Integer> {
    List<ClinicSchedule> findByDayWorking(LocalDate dayWorking);
}

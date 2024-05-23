package vn.aptech.backendapi.repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import vn.aptech.backendapi.entities.ClinicSchedule;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface ClinicScheduleRepository extends JpaRepository<ClinicSchedule, Integer> {

    @Query(value = "SELECT DISTINCT CAST(day_work AS CHAR) FROM clinic_schedules", nativeQuery = true)
    List<String> findDistinctDayWork();

    @Query(value = "SELECT * FROM clinic_schedules WHERE day_work = :day", nativeQuery = true)
    Optional<ClinicSchedule> findScheduleByDay(@Param("day") String day);
    
  List<ClinicSchedule> findByDayWorking(LocalDate dayWorking);
}

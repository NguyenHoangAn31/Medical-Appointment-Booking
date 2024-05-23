package vn.aptech.backendapi.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import vn.aptech.backendapi.entities.Schedule;

import java.time.LocalDate;
import java.util.List;


@Repository
public interface ScheduleRepository extends JpaRepository<Schedule, Integer> {
    List<Schedule> findByDoctorId(int doctorId);
    List<Schedule> findByClinicSchedule_DayWorking(LocalDate dayWorking);

    List<Schedule> findByClinicScheduleDayWorkingAndDoctorId(LocalDate dayWorking, int doctorId);
}

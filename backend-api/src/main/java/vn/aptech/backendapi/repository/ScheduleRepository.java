package vn.aptech.backendapi.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import vn.aptech.backendapi.entities.Schedule;

import java.time.LocalDate;
import java.util.List;


@Repository
public interface ScheduleRepository extends JpaRepository<Schedule, Integer> {
    List<Schedule> findByDoctorId(int doctorId);
    List<Schedule> findByClinicSchedule_DayWorking(LocalDate dayWorking);

    List<Schedule> findByClinicScheduleDayWorkingAndDoctorId(LocalDate dayWorking, int doctorId);


    // writed by An in 27/5
    @Query("SELECT s FROM Schedule s WHERE s.clinicSchedule.id = :clinicId AND s.department.id = :departmentId AND s.slot.id = :slotId")
        List<Schedule> findByClinicIdAndDepartmentIdAndSlotId(@Param("clinicId") int clinicId,
                        @Param("departmentId") int departmentId, @Param("slotId") int slotId);
}

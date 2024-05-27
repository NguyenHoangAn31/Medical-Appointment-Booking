package vn.aptech.backendapi.repository;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import vn.aptech.backendapi.entities.ClinicSchedule;
import vn.aptech.backendapi.entities.Department;
import vn.aptech.backendapi.entities.Doctor;
import vn.aptech.backendapi.entities.Slot;


@Repository
public interface ClinicScheduleRepository extends JpaRepository<ClinicSchedule, Integer> {

        ClinicSchedule findByDayWorking(LocalDate dayWorking);

        @Query(value = "SELECT DISTINCT CAST(day_work AS CHAR) FROM clinic_schedules", nativeQuery = true)
        List<String> findDistinctDayWork();

        @Query("SELECT DISTINCT s.department FROM Schedule s WHERE s.clinicSchedule.dayWorking = :dayWorking")
        List<Department> findDistinctDepartmentsByDayWorking(@Param("dayWorking") LocalDate dayWorking);

        @Query("SELECT DISTINCT s.slot FROM Schedule s WHERE s.clinicSchedule.dayWorking = :dayWorking AND s.department.id = :departmentId")
        List<Slot> findDistinctSlotsByDayWorkingAndDepartment(@Param("dayWorking") LocalDate dayWorking,
                        @Param("departmentId") int departmentId);

        @Query("SELECT s.doctor FROM Schedule s WHERE s.clinicSchedule.dayWorking = :dayWorking AND s.department.id = :departmentId AND s.slot.id = :slotId")
        List<Doctor> findDoctorsByDayWorkingAndDepartmentAndSlot(@Param("dayWorking") LocalDate dayWorking,
                        @Param("departmentId") int departmentId, @Param("slotId") int slotId);

        // @Query("SELECT s.id FROM Schedule s WHERE s.doctor.id = :doctorId AND
        // s.clinicSchedule.dayWorking = :dayWorking AND s.department.id = :departmentId
        // AND s.slot.id = :slotId")
        // Integer findScheduleIdByDoctorAndDayWorking(@Param("doctorId") int doctorId,
        // @Param("dayWorking") LocalDate dayWorking, @Param("departmentId") int
        // departmentId,
        // @Param("slotId") int slotId);s

}

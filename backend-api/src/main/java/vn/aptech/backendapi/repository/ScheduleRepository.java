package vn.aptech.backendapi.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import vn.aptech.backendapi.entities.Department;
import vn.aptech.backendapi.entities.Doctor;
import vn.aptech.backendapi.entities.Schedule;
import vn.aptech.backendapi.entities.Slot;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface ScheduleRepository extends JpaRepository<Schedule, Integer> {
        // List<Schedule> findByDoctorId(int doctorId);

        // List<Schedule> findByClinicSchedule_DayWorking(LocalDate dayWorking);

        // List<Schedule> findByClinicScheduleDayWorkingAndDoctorId(LocalDate
        // dayWorking, int doctorId);

        // writed by An in 27/5
        // @Query("SELECT s FROM Schedule s WHERE s.clinicSchedule.id = :clinicId AND
        // s.department.id = :departmentId AND s.slot.id = :slotId")
        // List<Schedule> findByClinicIdAndDepartmentIdAndSlotId(@Param("clinicId") int
        // clinicId,
        // @Param("departmentId") int departmentId, @Param("slotId") int slotId);

        // @Query(value = "SELECT DISTINCT CAST(day_work AS CHAR) FROM
        // clinic_schedules", nativeQuery = true)
        // List<String> findDistinctDayWork();

        // @Query("SELECT DISTINCT s.department FROM Schedule s WHERE
        // s.clinicSchedule.dayWorking = :dayWorking")
        // List<Department> findDistinctDepartmentsByDayWorking(@Param("dayWorking")
        // LocalDate dayWorking);

        // @Query("SELECT DISTINCT s.slot FROM Schedule s WHERE
        // s.clinicSchedule.dayWorking = :dayWorking AND s.department.id =
        // :departmentId")
        // List<Slot> findDistinctSlotsByDayWorkingAndDepartment(@Param("dayWorking")
        // LocalDate dayWorking,
        // @Param("departmentId") int departmentId);

        // @Query("SELECT s.doctor FROM Schedule s WHERE s.clinicSchedule.dayWorking =
        // :dayWorking AND s.department.id = :departmentId AND s.slot.id = :slotId")
        // List<Doctor> findDoctorsByDayWorkingAndDepartmentAndSlot(@Param("dayWorking")
        // LocalDate dayWorking,
        // @Param("departmentId") int departmentId, @Param("slotId") int slotId);

        @Query(value = "SELECT DISTINCT CAST(day_working AS CHAR) FROM schedules", nativeQuery = true)
        List<String> findDistinctDayWork();

        @Query("SELECT DISTINCT s.department FROM Schedule s WHERE s.dayWorking = :day")
        List<Department> findDistinctDepartmentsByDay(@Param("day") LocalDate day);

        @Query("SELECT DISTINCT s.slot FROM Schedule s WHERE s.dayWorking = :dayWorking AND s.department.id = :departmentId")
        List<Slot> findDistinctSlotsByDayWorkingAndDepartment(@Param("dayWorking") LocalDate dayWorking,
                        @Param("departmentId") int departmentId);

        @Query("SELECT DISTINCT sd.doctor " +
                        "FROM ScheduleDoctor sd " +
                        "JOIN sd.schedule s " +
                        "WHERE s.dayWorking = :dayWorking " +
                        "AND s.department.id = :departmentId " +
                        "AND s.slot.id = :slotId")
        List<Doctor> findDoctorsByDayWorkingAndDepartmentAndSlot(
                        @Param("dayWorking") LocalDate dayWorking,
                        @Param("departmentId") int departmentId,
                        @Param("slotId") int slotId);

                        

        @Query("SELECT DISTINCT sd.schedule.slot FROM ScheduleDoctor sd " +
                        "WHERE sd.schedule.dayWorking = :day AND sd.doctor.id = :doctorId")
        List<Slot> findSlotsByDayAndDoctorId(@Param("day") LocalDate day, @Param("doctorId") int doctorId);

}

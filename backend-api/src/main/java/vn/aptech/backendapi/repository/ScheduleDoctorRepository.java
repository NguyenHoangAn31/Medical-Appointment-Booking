package vn.aptech.backendapi.repository;

import java.time.LocalDate;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import vn.aptech.backendapi.entities.ScheduleDoctor;

public interface ScheduleDoctorRepository extends JpaRepository<ScheduleDoctor, Integer> {
    @Query(value = "SELECT sd.id FROM schedules_doctors sd " +
            "JOIN schedules s ON sd.schedule_id = s.id " +
            "WHERE s.day_working = :dayWorking " +
            "AND s.slot_id = :slotId " +
            "AND sd.doctor_id = :doctorId", nativeQuery = true)

    Integer findScheduleDoctorIdByDayWorkingSlotIdAndDoctorId(
            @Param("dayWorking") LocalDate dayWorking,
            @Param("slotId") int slotId,
            @Param("doctorId") int doctorId);
}

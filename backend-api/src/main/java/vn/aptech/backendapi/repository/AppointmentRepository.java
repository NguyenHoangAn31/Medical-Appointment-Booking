package vn.aptech.backendapi.repository;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import vn.aptech.backendapi.dto.ReportDto;
import vn.aptech.backendapi.entities.Appointment;
import vn.aptech.backendapi.entities.Partient;

@Repository
public interface AppointmentRepository extends JpaRepository<Appointment, Integer> {

       @Query("SELECT a.clinicHours FROM Appointment a " +
                     "WHERE a.medicalExaminationDay = :medicalExaminationDay AND a.scheduledoctor.doctor.id = :doctorId")
       List<LocalTime> findClinicHoursByBookingDateAndDoctorId(
                     @Param("medicalExaminationDay") LocalDate medicalExaminationDay,
                     @Param("doctorId") int doctorId);

       @Query("SELECT new vn.aptech.backendapi.dto.ReportDto(sd.doctor.id, " +
                     "d.fullName, d.image, d.price, " +
                     "SUM(CASE WHEN a.status = 'success' THEN 1 ELSE 0 END), " +
                     "SUM(CASE WHEN a.status = 'cancel' THEN 1 ELSE 0 END), " +
                     "de.name, " +
                     "(d.price * SUM(CASE WHEN a.status = 'success' THEN 1 ELSE 0 END) + " +
                     "d.price * 0.3 * SUM(CASE WHEN a.status = 'cancel' THEN 1 ELSE 0 END)) " +
                     ") " +
                     "FROM Appointment a " +
                     "JOIN a.scheduledoctor sd " +
                     "JOIN sd.doctor d " +
                     "JOIN d.department de " +
                     "WHERE (:startDate IS NULL OR a.appointmentDate >= :startDate) " +
                     "AND (:endDate IS NULL OR a.appointmentDate <= :endDate) " +
                     "GROUP BY sd.doctor.id, d.fullName, d.image, d.price, de.name " +
                     "HAVING SUM(CASE WHEN a.status = 'success' THEN 1 ELSE 0 END) > 0 " +
                     "OR SUM(CASE WHEN a.status = 'cancel' THEN 1 ELSE 0 END) > 0")
       List<ReportDto> findDoctorAppointmentsReport(@Param("startDate") LocalDate startDate,
                     @Param("endDate") LocalDate endDate);





}

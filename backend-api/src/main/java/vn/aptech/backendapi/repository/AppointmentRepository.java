package vn.aptech.backendapi.repository;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import vn.aptech.backendapi.entities.Appointment;

@Repository
public interface AppointmentRepository extends JpaRepository<Appointment, Integer> {

    @Query("SELECT a.clinicHours FROM Appointment a " +
           "WHERE a.bookingDate = :bookingDate AND a.scheduledoctor.doctor.id = :doctorId")
    List<LocalTime> findClinicHoursByBookingDateAndDoctorId(
            @Param("bookingDate") LocalDate bookingDate, 
            @Param("doctorId") int doctorId);
}

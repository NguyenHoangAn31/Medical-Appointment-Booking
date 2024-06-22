package vn.aptech.backendapi.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import vn.aptech.backendapi.entities.Partient;

import java.time.LocalTime;
import java.util.List;
import java.util.Optional;


@Repository
public interface PartientRepository extends JpaRepository<Partient, Integer> {
    Optional<Partient> getPatientByUserId(int userId);


    @Query("SELECT a.partient FROM Appointment a WHERE a.scheduledoctor.id = :scheduledoctorid AND a.clinicHours = :starttime")
    List<Partient> findPatientsByScheduleDoctorIdAndStartTime(@Param("scheduledoctorid") int scheduleDoctorId,
                                                              @Param("starttime") LocalTime startTime);
}

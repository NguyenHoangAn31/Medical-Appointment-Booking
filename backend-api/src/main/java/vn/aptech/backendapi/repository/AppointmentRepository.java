package vn.aptech.backendapi.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import vn.aptech.backendapi.entities.Appointment;

@Repository
public interface AppointmentRepository extends JpaRepository<Appointment, Integer> {
}

package vn.aptech.backendapi.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import vn.aptech.backendapi.entities.Partient;

import java.util.Optional;


@Repository
public interface PartientRepository extends JpaRepository<Partient, Integer> {
    Optional<Partient> getPatientByUserId(int userId);
}

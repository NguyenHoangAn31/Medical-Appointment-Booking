package vn.aptech.backendapi.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import vn.aptech.backendapi.entities.Partient;


@Repository
public interface PartientRepository extends JpaRepository<Partient, Integer> {
}

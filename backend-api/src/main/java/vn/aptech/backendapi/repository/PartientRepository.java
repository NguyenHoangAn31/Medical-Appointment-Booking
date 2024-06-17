package vn.aptech.backendapi.repository;

import java.time.LocalDate;
import java.time.LocalDateTime;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import vn.aptech.backendapi.entities.Partient;

@Repository
public interface PartientRepository extends JpaRepository<Partient, Integer> {
    Partient getPatientByUserId(int userId);

    @Query("SELECT COUNT(a) FROM Partient a " +
            "WHERE FUNCTION('DATE', a.createdAt) BETWEEN :startDate AND :endDate")

    Integer getCountRegister(@Param("startDate") LocalDate startDate,@Param("endDate") LocalDate endDate);
}

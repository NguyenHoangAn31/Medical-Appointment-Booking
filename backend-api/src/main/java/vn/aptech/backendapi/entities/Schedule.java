package vn.aptech.backendapi.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name="schedules")
public class Schedule extends  BaseEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    @ManyToOne
    @JoinColumn(name = "doctor_id", referencedColumnName = "id")
    private Doctor doctor;

    @ManyToOne
    @JoinColumn(name="clinic_id", referencedColumnName = "id")
    private ClinicSchedule clinicSchedule;

//    private String starTime;
//    private String endTime;
    @ManyToOne
    @JoinColumn(name="slot_id", referencedColumnName = "id")
    private Slot slot;

    private boolean status;


}

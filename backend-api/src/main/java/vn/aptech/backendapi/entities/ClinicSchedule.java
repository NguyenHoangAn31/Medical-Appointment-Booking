package vn.aptech.backendapi.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.util.List;


@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "clinic_schedules", uniqueConstraints = @UniqueConstraint(columnNames = "day_work"))
public class ClinicSchedule extends BaseEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    @Column(name = "day_work", unique = true)
    private LocalDate dayWorking;
    private String startDate;
    private String endDate;
    @ManyToOne
    @JoinColumn(name = "user_id", referencedColumnName = "id")
    private User user;
    private Boolean status;
    @OneToMany(mappedBy = "clinicSchedule", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Schedule> schedules;
}

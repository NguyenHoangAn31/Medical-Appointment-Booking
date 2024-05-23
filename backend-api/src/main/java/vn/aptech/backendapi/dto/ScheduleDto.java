package vn.aptech.backendapi.dto;

import jakarta.persistence.Column;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.*;
import vn.aptech.backendapi.entities.ClinicSchedule;
import vn.aptech.backendapi.entities.Doctor;
import vn.aptech.backendapi.entities.Slot;

import java.time.LocalDate;
import java.util.List;

@Data
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ScheduleDto {
    private int id;
    private int doctorId;
    private int clinicScheduleId;
    private LocalDate dayWorking;
    private int slotId;
    private String slotName;
    private boolean status;
}

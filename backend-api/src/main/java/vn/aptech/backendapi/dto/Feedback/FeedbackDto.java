package vn.aptech.backendapi.dto.Feedback;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import vn.aptech.backendapi.dto.DoctorDto;
import vn.aptech.backendapi.dto.PatientDto;
import vn.aptech.backendapi.entities.Partient;


@Data
@Setter
@Getter
public class FeedbackDto {
    private int id;
    private double rate;
    private String comment;
    private int patientId;
    private int doctorId;
    private byte status;
    private PatientDto patient;
}

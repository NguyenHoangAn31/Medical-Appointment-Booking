package vn.aptech.backendapi.dto.Feedback;


import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import vn.aptech.backendapi.dto.PatientDto;



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
    private String createdAt;
    private PatientDto patient;
}

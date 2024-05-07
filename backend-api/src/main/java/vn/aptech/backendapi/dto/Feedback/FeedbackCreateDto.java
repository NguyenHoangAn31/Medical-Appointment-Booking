package vn.aptech.backendapi.dto.Feedback;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Setter
@Getter
public class FeedbackCreateDto {
    private int id;
    private double rate;
    private String comment;
    private int doctor_id;
    private int patient_id;
    private byte status;

}

package vn.aptech.backendapi.dto.Feedback;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;


@Data
@Setter
@Getter
public class FeedbackShowDto {
    private String id;
    private String fullName;
    private String title; 
    private String gender; 
    private String birthday; 
    private String address; 
    private String image; 
    private String department;
    private double rate;
}

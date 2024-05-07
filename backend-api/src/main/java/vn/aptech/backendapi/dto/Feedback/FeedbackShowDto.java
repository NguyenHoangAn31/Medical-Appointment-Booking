package vn.aptech.backendapi.dto.Feedback;

import java.time.LocalDate;
import java.util.List;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import vn.aptech.backendapi.dto.DoctorDto;
import vn.aptech.backendapi.dto.QualificationDto;
import vn.aptech.backendapi.dto.WorkingDto;
import vn.aptech.backendapi.entities.Department;

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

package vn.aptech.backendapi.dto;

import lombok.*;
import vn.aptech.backendapi.entities.Department;

import java.time.LocalDate;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class DoctorDto {
    private String id;
    private String fullName;
    private String title; //Chức danh
    private String gender; // giới tính
    private String birthday; // ngày sinh
    private String address; // Địa chỉ
    private String image; // Image
    private Double price;
    private Boolean status;
    private Department department;
    //private User user;
    private List<WorkingDto> workings;
    private List<QualificationDto> qualifications;

}

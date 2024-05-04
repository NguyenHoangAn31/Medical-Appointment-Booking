package vn.aptech.backendapi.dto;

import lombok.*;
import vn.aptech.backendapi.entities.Department;
import vn.aptech.backendapi.entities.Working;

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
    private LocalDate birthday; // ngày sinh
    private String address; // Địa chỉ
    private String image; // Image
    private Double price;
    private Department department;
    //private User user;
    private List<WorkingDto> workings;
    private List<QualificationDto> qualifications;



}

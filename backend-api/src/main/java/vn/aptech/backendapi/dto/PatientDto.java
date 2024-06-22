package vn.aptech.backendapi.dto;


import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.util.List;

@Data
@Setter
@Getter
public class PatientDto {
    private  int id;
    private String fullName;
    private String gender; // giới tính
    private String birthday; // ngày sinh
    private String address; // Địa chỉ
    private String image; // Image
    private Boolean status;
    private List<MedicalDto> medicals;
}

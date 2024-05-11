package vn.aptech.backendapi.dto;


import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import vn.aptech.backendapi.entities.Medical;

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
    private int status;
    private List<MedicalDto> medicals;
}

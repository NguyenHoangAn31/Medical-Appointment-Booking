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
    private LocalDate birthday; // ngày sinh
    private String address; // Địa chỉ
    private String image; // Image
    private boolean status;
    private List<MedicalDto> medicals;
}

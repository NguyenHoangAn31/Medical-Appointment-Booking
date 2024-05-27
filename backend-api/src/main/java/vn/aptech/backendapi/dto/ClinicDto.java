package vn.aptech.backendapi.dto;



import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class ClinicDto {
    private int id;
    private String dayWorking;
    private UserDto user;
    private Boolean status;
}

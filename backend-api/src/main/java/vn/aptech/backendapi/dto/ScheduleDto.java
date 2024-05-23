package vn.aptech.backendapi.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
@Data
@Getter
@Setter
public class ScheduleDto {

    private int id;
    private DoctorDto doctorDto;
    private int department_id;
    private SlotDto slot;
    private boolean status;

}

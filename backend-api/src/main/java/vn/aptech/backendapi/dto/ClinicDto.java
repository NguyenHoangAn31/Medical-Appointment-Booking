package vn.aptech.backendapi.dto;

import java.util.List;


import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import vn.aptech.backendapi.entities.User;

@Data
@Getter
@Setter
public class ClinicDto {
    private int id;
    private String dayWorking;
    private UserDto user;
    private Boolean status;
    private List<CustomSchedule> schedules;
    // private List<ScheduleDto> schedules;
}

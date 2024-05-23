package vn.aptech.backendapi.dto;

import java.util.List;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class CustomSchedule {
    private DepartmentDto departmentDto;
    private List<ScheduleDto> schedules;
}

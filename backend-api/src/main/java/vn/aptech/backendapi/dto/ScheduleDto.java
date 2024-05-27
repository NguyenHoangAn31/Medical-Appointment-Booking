package vn.aptech.backendapi.dto;


import lombok.*;


@Data
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor

public class ScheduleDto {

    private int id;
    private int clinicScheduleId;
    private String dayWorking;
    private int doctorId;
    private SlotDto slot;
    private boolean status;

}

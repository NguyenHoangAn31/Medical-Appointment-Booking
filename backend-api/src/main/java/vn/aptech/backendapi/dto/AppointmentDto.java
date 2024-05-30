package vn.aptech.backendapi.dto;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@Data
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class AppointmentDto {
    private int id;
    private int partientId;
    private int scheduledoctorId;
    private int price;
    private String payment;
    private String status;
    private String bookingDate;
    private String clinicHours;
}

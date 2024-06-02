
package vn.aptech.backendapi.dto.Appointment;

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
public class CustomAppointmentDto {
    private int id;
    private String image;
    private String fullName;
    private int price;
    private String payment;
    private String status;
    private String bookingDate;
    private String clinicHours;
}

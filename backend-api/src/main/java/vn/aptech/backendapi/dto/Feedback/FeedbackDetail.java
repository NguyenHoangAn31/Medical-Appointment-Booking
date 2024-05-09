package vn.aptech.backendapi.dto.Feedback;

import java.util.List;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import vn.aptech.backendapi.dto.DoctorDto;

@Data
@Setter
@Getter
public class FeedbackDetail {
    private DoctorDto doctor;
    private List<FeedbackDto> feedbackList;
}

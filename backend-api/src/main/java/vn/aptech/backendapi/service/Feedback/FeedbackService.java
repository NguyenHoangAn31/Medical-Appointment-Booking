package vn.aptech.backendapi.service.Feedback;

import java.util.List;

import vn.aptech.backendapi.dto.Feedback.FeedbackDetail;
import vn.aptech.backendapi.dto.Feedback.FeedbackDto;
import vn.aptech.backendapi.dto.Feedback.FeedbackShowDto;

public interface FeedbackService {
    FeedbackDto save(FeedbackDto dto);
    List<FeedbackShowDto> findAll();
    FeedbackDetail feedbackDetail(int doctorId);
    boolean deleteById(int id);
    boolean changeStatus(int id,int status);

}


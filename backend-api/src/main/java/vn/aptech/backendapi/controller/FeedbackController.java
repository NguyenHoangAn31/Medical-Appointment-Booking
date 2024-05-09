package vn.aptech.backendapi.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import vn.aptech.backendapi.dto.Feedback.FeedbackCreateDto;
import vn.aptech.backendapi.dto.Feedback.FeedbackDetail;
import vn.aptech.backendapi.dto.Feedback.FeedbackShowDto;
import vn.aptech.backendapi.service.Feedback.FeedbackService;

@RestController
@RequestMapping(value = "/api/feedback")
public class FeedbackController {
    @Autowired
    private FeedbackService feedbackService;



    @GetMapping(value = "/all", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<List<FeedbackShowDto>> findAll() {
        List<FeedbackShowDto> result = feedbackService.findAll();
        return ResponseEntity.ok(result);
    }


    @GetMapping(value = "/{doctorId}", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<FeedbackDetail> findByDoctorId(@PathVariable("doctorId") int doctorId) {
        FeedbackDetail result = feedbackService.feedbackDetail(doctorId);
        if (result != null) {
            return ResponseEntity.ok(result);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PostMapping(value = "/create", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<FeedbackCreateDto> Create(@RequestBody FeedbackCreateDto dto) {
        FeedbackCreateDto result = feedbackService.save(dto);
        if (result != null) {
            return ResponseEntity.ok(result);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PutMapping(value = "/changestatus/{feedbackId}/{statusOfFeedback}", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<FeedbackCreateDto> changeStatusFeedback(@PathVariable("feedbackId") int feedbackId,@PathVariable("statusOfFeedback") int statusOfFeedback) {
        boolean changed = feedbackService.changeStatus(feedbackId,statusOfFeedback);
        if (changed) {
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping(value = "/delete/{feedbackId}", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<FeedbackCreateDto> delteFeedback(@PathVariable("feedbackId") int feedbackId) {
        boolean deleted = feedbackService.deleteById(feedbackId);
        if (deleted) {
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}

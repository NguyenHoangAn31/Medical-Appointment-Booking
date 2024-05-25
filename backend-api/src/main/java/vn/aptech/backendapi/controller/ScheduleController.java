package vn.aptech.backendapi.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import vn.aptech.backendapi.dto.ScheduleDto;
import vn.aptech.backendapi.service.Schedule.ScheduleService;

import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping(value = "/api/schedules", produces = MediaType.APPLICATION_JSON_VALUE)
public class ScheduleController {
    @Autowired
    private ScheduleService scheduleService;

    @GetMapping(value = "/doctor/{doctorId}")
    public ResponseEntity<List<ScheduleDto>> findScheduleById(@PathVariable("doctorId") int doctorId) {
        List<ScheduleDto> result = scheduleService.findScheduleByDoctorId(doctorId);
        if (!result.isEmpty()) {
            return ResponseEntity.ok(result);
        } else {
            return ResponseEntity.noContent().build(); // Trả về 204 No Content nếu không tìm thấy lịch
        }
    }

    @GetMapping(value = "/doctor/{doctorId}/day/{dayWorking}")
    public ResponseEntity<List<ScheduleDto>> findByDayWorkingAndDoctorId(
            @PathVariable("doctorId") int doctorId,
            @PathVariable("dayWorking") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate dayWorking) {
        List<ScheduleDto> result = scheduleService.findByDayWorkingAndDoctorId(dayWorking, doctorId);
        if (!result.isEmpty()) {
            return ResponseEntity.ok(result);
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}

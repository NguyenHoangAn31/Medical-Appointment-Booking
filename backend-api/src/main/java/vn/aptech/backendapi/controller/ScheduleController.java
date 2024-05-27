package vn.aptech.backendapi.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
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
        List<ScheduleDto> result = scheduleService.findByDoctorId(doctorId);
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
            System.out.println("alo");
            return ResponseEntity.notFound().build();
        }
    }

    // writed by An in 27/5
    @PutMapping(value = "/updatelistschedule/{clinicId}/{departmentId}/{slotId}", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<?> updateScheduleForAdmin(
            @PathVariable("clinicId") int clinicId,
            @PathVariable("departmentId") int departmentId,
            @PathVariable("slotId") int slotId,
            @RequestBody int[] doctorList) {
                // System.out.println(departmentId);
                // return ResponseEntity.notFound().build();

       
        try {
            scheduleService.updateScheduleForAdmin(clinicId, departmentId, slotId, doctorList);
            return ResponseEntity.ok().build();

        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Đã xảy ra lỗi khi cập nhật lịch: " + e.getMessage());

        }

    }
}

package vn.aptech.backendapi.controller;

import java.time.LocalDate;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


import vn.aptech.backendapi.dto.Schedule.ClinicScheduleDTO;
import vn.aptech.backendapi.service.Clinic.ClinicService;

@RestController
@RequestMapping(value = "/api/clinic")
public class ClinicController {

    @Autowired
    private ClinicService clinicService;

    @GetMapping(value = "/allday", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<List<String>> findAllOnlyDay() {
        List<String> result = clinicService.findAllOnlyDay();
        return ResponseEntity.ok(result);
    }

    @GetMapping(value = "/schedulebyday/{day}", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<ClinicScheduleDTO> getScheduleByDay(
            @PathVariable("day") String dayWorking) {
        return ResponseEntity.ok(clinicService.getDepartmentsWithSlotsAndDoctors(LocalDate.parse(dayWorking)));
    }

}

package vn.aptech.backendapi.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import vn.aptech.backendapi.dto.ClinicDto;
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

    @GetMapping(value = "/work_day/{day}", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<ClinicDto> workDay(@PathVariable("day") String day) {
        System.out.println(day);
        Optional<ClinicDto> result = clinicService.searchByDay(day);
        return ResponseEntity.ok(result.get());
        // return ResponseEntity.notFound().build();

    }
}

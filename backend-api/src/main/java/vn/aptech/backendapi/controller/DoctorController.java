package vn.aptech.backendapi.controller;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import vn.aptech.backendapi.dto.DoctorDto;
import vn.aptech.backendapi.service.Doctor.DoctorService;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping(value = "/api/doctor")
public class DoctorController {

    @Autowired
    private DoctorService doctorService;

    @Autowired
    private ModelMapper mapper;

    @GetMapping(value = "/all", produces = MediaType.APPLICATION_JSON_VALUE)
    // @PreAuthorize("hasAnyAuthority('ADMIN', 'USER')")
    public ResponseEntity<List<DoctorDto>> findAll() {
        List<DoctorDto> result = doctorService.findAll();
        return ResponseEntity.ok(result);
    }

    @GetMapping(value = "/{id}", produces = MediaType.APPLICATION_JSON_VALUE)
    // @PreAuthorize("hasAnyAuthority('ADMIN')")
    public ResponseEntity<DoctorDto> findById(@PathVariable("id") int id) {
        Optional<DoctorDto> result = doctorService.findById(id);
        if (result.isPresent()) {
            return ResponseEntity.ok(result.get());
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    // Hien Create 30/4/2024
    @GetMapping(value = "/related-doctor/{departmentId}", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<List<DoctorDto>> findRDoctorsByDepartment(@PathVariable("departmentId") int departmentId) {
        List<DoctorDto> relatedDoctors = doctorService.findDoctorsByDepartmentId(departmentId);
        return ResponseEntity.ok(relatedDoctors);
    }

    // writed by An in 5/11
    @PutMapping(value = "/changestatus/{id}/{status}", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<?> changeStatusDoctor(@PathVariable("id") int id, @PathVariable("status") int status) {
        System.out.println("alo alo");
        boolean changed = doctorService.changeStatus(id, status);
        if (changed) {
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PutMapping(value = "/updatepriceanddepartment/{id}/{price}/{departmentid}", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<DoctorDto> UpdatePriceAndDepartment(@PathVariable("id") int id,
            @PathVariable("price") double price, @PathVariable("departmentid") int departmentId) {

        doctorService.findById(id).orElseThrow(() -> new RuntimeException());
        DoctorDto result = doctorService.updatePriceAndDepartment(id, price, departmentId);
        return ResponseEntity.ok(result);

    }
    // @GetMapping(value = "/star/{doctorId}", produces =
    // MediaType.APPLICATION_JSON_VALUE)
    // public ResponseEntity<List<DoctorDto>>
    // findRDoctorsStar(@PathVariable("doctorId") int doctorId) {
    // List<DoctorDto> starDoctors =
    // doctorService.findDoctorsByDepartmentId(doctorId);
    // return ResponseEntity.ok(relatedDoctors);
    //
    // }

}

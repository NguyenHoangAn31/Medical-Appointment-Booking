package vn.aptech.backendapi.controller;

import java.util.List;
import java.util.Optional;

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

import vn.aptech.backendapi.dto.DepartmentDto;
import vn.aptech.backendapi.service.Department.DepartmentService;

@RestController
@RequestMapping(value = "/api/department")
public class DepartmentController {
    @Autowired
    private DepartmentService departmentService;

    @GetMapping(value = "/all", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<List<DepartmentDto>> findAll() {
        List<DepartmentDto> result = departmentService.findAll();
        return ResponseEntity.ok(result);
    }

    @GetMapping(value = "/{id}", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<DepartmentDto> findById(@PathVariable("id") int id) {
        Optional<DepartmentDto> result = departmentService.findById(id);
        if (result.isPresent()) {
            return ResponseEntity.ok(result.get());
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping(value = "/delete/{id}", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<?> deleteById(@PathVariable("id") int id) {
        boolean deleted = departmentService.deleteById(id);
        System.out.println("Alo");
        if (deleted) {
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PostMapping(value = "/create", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<DepartmentDto> Create(@RequestBody DepartmentDto dto) {
        System.out.println("ok");
        DepartmentDto result = departmentService.save(dto);
        if (result != null) {
            return ResponseEntity.ok(result); // Return the created SlotDto
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PutMapping(value = "/update/{id}", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<DepartmentDto> updateTutorial(@PathVariable("id") int id, @RequestBody DepartmentDto dto) {
        Optional<DepartmentDto> existingDepartmentOptional = departmentService.findById(id);
        if (existingDepartmentOptional.isPresent()) {
            DepartmentDto existingDepartment = existingDepartmentOptional.get();
            existingDepartment.setName(dto.getName());
            existingDepartment.setUrl(dto.getUrl());
            existingDepartment.setStatus(dto.getStatus());
            DepartmentDto updatedDepartment = departmentService.save(existingDepartment);
            return ResponseEntity.ok(updatedDepartment);
        }
        return ResponseEntity.notFound().build();

    }
}

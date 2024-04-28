package vn.aptech.backendapi.controller;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import vn.aptech.backendapi.dto.UserDto;
import vn.aptech.backendapi.service.User.UserService;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping(value = "/api/user")
public class UserController {
    @Autowired
    private UserService userService;

    @Autowired
    private ModelMapper mapper;



    @GetMapping
    public ResponseEntity<List<UserDto>> findAll() {
        List<UserDto> result = userService.findAll();
        return ResponseEntity.ok(result);
    }

    // findById

    @GetMapping("/{id}")
    public ResponseEntity<UserDto> findById(@PathVariable("id") int id){
        Optional<UserDto> result = userService.findById(id);
        if (result.isPresent()) {
            return ResponseEntity.ok(result.get());
        } else {
            return ResponseEntity.notFound().build();
        }
    }

}

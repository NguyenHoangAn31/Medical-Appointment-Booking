package vn.aptech.backendapi.dto;


import lombok.*;

import java.util.List;

@Getter
public class UserDto {
    private  int id;
    private  String email;
    private  String phone;
    private  String fullName;
    private  String provider;
    private  List<String> roles;
}

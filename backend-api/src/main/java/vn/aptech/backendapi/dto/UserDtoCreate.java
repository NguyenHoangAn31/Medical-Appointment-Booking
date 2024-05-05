package vn.aptech.backendapi.dto;


import lombok.Getter;

import java.util.List;

@Getter
public class UserDtoCreate {
    private  int id;
    private  String email;
    private  String phone;
    private  String fullName;
    private  String provider;
    private  String keyCode;
    private  int roleId;
    private boolean status;
}

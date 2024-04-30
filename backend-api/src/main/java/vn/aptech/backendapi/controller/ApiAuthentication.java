package vn.aptech.backendapi.controller;

import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import vn.aptech.backendapi.dto.Authentication;
import vn.aptech.backendapi.dto.AuthenticationWithUsernameAndKeycode;
import vn.aptech.backendapi.entities.RefreshToken;
import vn.aptech.backendapi.entities.User;
import vn.aptech.backendapi.repository.RefreshTokenRepository;
import vn.aptech.backendapi.service.Auth.AuthenticationWithUsernameAndKeycodeService;
import vn.aptech.backendapi.service.User.UserService;

import java.time.LocalDateTime;
import java.util.Optional;


//Khoa edit 18/04/2024
@RestController
@RequestMapping(value = "/api/auth")
@Slf4j
public class ApiAuthentication {
    @Autowired
    private AuthenticationWithUsernameAndKeycodeService service;

    @Autowired
    private UserService userService;


    @Autowired
    private RefreshTokenRepository refreshTokenRepository;

    // Login
    @PostMapping(value = "/login", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Authentication> login(@RequestBody AuthenticationWithUsernameAndKeycode body){
        var session = service.processLogin(body);
        return ResponseEntity.ok(session);
    }

//    @PostMapping("/sign-in")
//    public ResponseEntity<String> signIn(@@RequestBody )


    @PostMapping(value = "/send-otp", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Boolean> sendOtp(@RequestBody AuthenticationWithUsernameAndKeycode body) {
        String username = body.getUsername();
        String provider = body.getProvider();
        Optional<User> userOptional = userService.findByEmailOrPhone(username);
        if(userOptional.isPresent() && userOptional.get().getProvider().equals(provider)){
            Optional<RefreshToken> refreshTokenOptional = refreshTokenRepository.findRefreshTokenByUsername(username);
            if (refreshTokenOptional.isPresent()) {
                RefreshToken refreshToken = refreshTokenOptional.get();
                LocalDateTime expiredAt = refreshToken.getExpiredAt();
                LocalDateTime now = LocalDateTime.now();
                // Kiểm tra tính hợp lệ của token
                if (now.isBefore(expiredAt)) {
                    return ResponseEntity.ok(true); // Token chưa hết hạn, không thực hiện gửi OTP
                } else {
                    refreshTokenRepository.delete(refreshToken);
                    return ResponseEntity.ok(false); // Token đã hết hạn, thực hiện đăng nhập
                }
            } else {
                String otp = RandomStringUtils.randomNumeric(6);
                // String otp ="";
                if (userOptional.isPresent()) {
                    User user = userOptional.get();
                    if(provider.equals("phone")){
                        user.setKeyCode(otp);
                        userService.save(user);
                    }
                    return ResponseEntity.ok(true);
                } else {
                    return ResponseEntity.status(HttpStatus.NOT_FOUND)
                            .body(false); // Không tìm thấy người dùng
                }
            }
        }else{
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(false);
        }
    }

   // public ResponseEntit


}


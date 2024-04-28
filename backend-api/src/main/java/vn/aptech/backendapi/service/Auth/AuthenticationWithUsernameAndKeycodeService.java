package vn.aptech.backendapi.service.Auth;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import vn.aptech.backendapi.dto.Authentication;
import vn.aptech.backendapi.dto.AuthenticationWithUsernameAndKeycode;
import vn.aptech.backendapi.dto.UserInformation;
import vn.aptech.backendapi.entities.RefreshToken;
import vn.aptech.backendapi.entities.User;
import vn.aptech.backendapi.jwt.JWT;
import vn.aptech.backendapi.repository.RefreshTokenRepository;
import vn.aptech.backendapi.repository.UserRepository;

import java.time.LocalDateTime;

@Service
@Slf4j
public class AuthenticationWithUsernameAndKeycodeService {

    @Value("jwt.secret")
    public String TOKEN_SECRET;

    @Autowired
    private RefreshTokenRepository refreshTokenRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private JWT jwt;

    public Authentication processLogin(AuthenticationWithUsernameAndKeycode body){
        String username = body.getUsername();
        String keycode = body.getKeycode();
        User user = userRepository.findByEmailOrPhone(username, username)
                .orElseThrow(() -> new UsernameNotFoundException("Invalid Username or Password"));
        if(!keycode.equals(user.getKeyCode())){
            throw new UsernameNotFoundException("Invalid Username or Password");
        }
        var expiredAt = LocalDateTime.now().plusDays(1);
        var accessToken = jwt.encode(user.getId(), user.getAuthorities(), expiredAt, TOKEN_SECRET);
        // tao refresh token
        refreshTokenRepository.disableOldRefreshTokenFromUser(user.getId());
        RefreshToken refresh = new RefreshToken(user, 7);
        refreshTokenRepository.save(refresh);

        Authentication auth = new Authentication(new UserInformation(user), accessToken, refresh.getCode(), expiredAt);
        return  auth;

    }
}

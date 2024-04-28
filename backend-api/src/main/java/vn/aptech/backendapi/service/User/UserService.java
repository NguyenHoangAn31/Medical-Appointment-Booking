package vn.aptech.backendapi.service.User;

import vn.aptech.backendapi.dto.UserDto;
import vn.aptech.backendapi.dto.UserInformation;
import vn.aptech.backendapi.entities.User;

import java.util.List;
import java.util.Optional;

public interface UserService {
    Optional<User> findByEmailOrPhone(String username);

    User save(User user);

    List<UserDto> findAll();

    Optional<UserDto> findById(int id);
}

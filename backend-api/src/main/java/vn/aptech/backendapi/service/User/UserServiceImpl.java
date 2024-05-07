package vn.aptech.backendapi.service.User;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vn.aptech.backendapi.dto.UserDto;
import vn.aptech.backendapi.dto.UserDtoCreate;
import vn.aptech.backendapi.entities.Role;
import vn.aptech.backendapi.entities.User;
import vn.aptech.backendapi.repository.RoleRepository;
import vn.aptech.backendapi.repository.UserRepository;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserRepository userRepository;

    @Autowired
    private RoleRepository roleRepository;

    @Autowired
    private ModelMapper mapper;

    // edited by An in 5/6
    private UserDto toDto(User user) {
        UserDto userDto = new UserDto();
        userDto.setId(user.getId());
        userDto.setEmail(user.getEmail());
        userDto.setPhone(user.getPhone());
        userDto.setFullName(user.getFullName());
        userDto.setProvider(user.getProvider());
        userDto.setRoles(null);
        return userDto;
    }

    public Optional<User> findByEmailOrPhone(String username) {
        return userRepository.findByEmailOrPhone(username, username);
    }

    // public Optional<UserDto> findByPhone(String phone){
    // Optional<User> result = userRepository.findByPhone(phone);
    // return result.map(this::toDto);
    // }

    public User save(User user) {
        return userRepository.save(user);
    }

    public Optional<UserDto> findById(int id) {
        System.out.println(id);
        Optional<User> result = userRepository.findById(id);
        return result.map(this::toDto);
    }

    public List<UserDto> findAll() {
        List<User> users = userRepository.findAll();
        return users.stream().map(this::toDto)
                .collect(Collectors.toList());
    }

    public UserDtoCreate registerNewUser(UserDtoCreate userDtoCreate) {
        User user = mapper.map(userDtoCreate, User.class);
        Optional<Role> roleOptional = roleRepository.findById(userDtoCreate.getRoleId());
        roleOptional.ifPresent(role -> user.setRoles(Collections.singletonList(role)));
        User savedUser = userRepository.save(user);
        return mapper.map(savedUser, UserDtoCreate.class);
    }
}

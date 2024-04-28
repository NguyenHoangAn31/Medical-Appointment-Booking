package vn.aptech.backendapi.service.User;


import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vn.aptech.backendapi.dto.UserDto;
import vn.aptech.backendapi.dto.UserInformation;
import vn.aptech.backendapi.entities.User;
import vn.aptech.backendapi.repository.UserRepository;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserRepository userRepository;

    @Autowired
    private ModelMapper mapper;

    private UserDto toDto(User user) {
        return mapper.map(user, UserDto.class);
    }
    public Optional<User> findByEmailOrPhone(String username){
        return userRepository.findByEmailOrPhone(username, username);
    }

    public User save(User user) {
        return userRepository.save(user);
    }

    public Optional<UserDto> findById(int id){
        Optional<User> result = userRepository.findById(id);
        return result.map(this::toDto);
    }

    public List<UserDto> findAll(){
        List<User> users = userRepository.findAll();
        return users.stream().map(this::toDto)
                .collect(Collectors.toList());
    }


}

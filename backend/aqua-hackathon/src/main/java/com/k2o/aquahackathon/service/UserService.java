package com.k2o.aquahackathon.service;

import com.k2o.aquahackathon.dto.UserDto;
import com.k2o.aquahackathon.entity.User;
import com.k2o.aquahackathon.mapper.UserMapper;
import com.k2o.aquahackathon.repository.UserRepository;
import com.k2o.aquahackathon.util.SecurityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class UserService {

    Logger log = LoggerFactory.getLogger(this.toString());

    @Autowired
    UserRepository userRepository;


    public String createUser(User user) {
        log.info("Create User: login = "+user.getLogin()+" pass="+user.getPassword() );
        Optional<User> existingUser = userRepository.findByLogin(user.getLogin());
        if (existingUser.isPresent()) {
            System.out.println("Found user: "+existingUser.get().getLogin());
            return "User already exists";
        }
        else {
            user.setPassword(SecurityUtils.sha1EncodedText(user.getPassword()));
            userRepository.save(user);
            return "Success";
        }
    }

    public UserDto checkUser(User user) {
        Optional<User> existingUser = userRepository.findByLoginAndPassword(user.getLogin(), SecurityUtils.sha1EncodedText(user.getPassword()));
        if (existingUser.isPresent()) {
            User u = existingUser.get();
            return UserMapper.INSTANCE.userToUserDto(u);
        }
        else
            return null;
    }

    public String updateUser(User user) {
        Optional<User> existingUser = userRepository.findById(user.getId());
        if (existingUser.isPresent()) {
            User u = existingUser.get();
            if (user.getNickname() != null)
                u.setNickname(user.getNickname());
            if (user.getLatitude() != null)
                u.setLatitude(user.getLatitude());
            if (user.getLongitude() != null)
                u.setLongitude(user.getLongitude());
            userRepository.save(u);
            return "Success";
        }
        else {
            return "Invalid user";
        }
    }

    public UserDto getUserInfo(Integer userId) {
        Optional<User> existingUser = userRepository.findById(userId);
        if (existingUser.isPresent()) {
            User u = existingUser.get();
            return UserMapper.INSTANCE.userToUserDto(u);
        }
        else
            return null;
    }


}

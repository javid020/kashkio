package com.k2o.aquahackathon.controller;

import com.k2o.aquahackathon.dto.UserDto;
import com.k2o.aquahackathon.entity.User;
import com.k2o.aquahackathon.service.UserService;
import com.k2o.aquahackathon.util.KkoResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/user")
public class UserController {

    Logger log = LoggerFactory.getLogger(this.toString());

    @Autowired
    UserService userService;

    @PostMapping("/register")
    public String register(@RequestBody User user) {
        log.info("register: login = "+user.getLogin()+" pass="+user.getPassword() );
        return userService.createUser(user);
    }

    @PostMapping("/login")
    public KkoResult login(@RequestBody User user) {
        UserDto res = userService.checkUser(user);

        KkoResult result = new KkoResult();
        if (res == null) {
            result.setMessage("Wrong credentials");
        }
        else {
            result.setMessage("User retrieved successfully");
            result.setResult(res);
        }
        return result;
    }


    @PostMapping("/update")
    public String update(@RequestBody User user) {
        log.info("update: login = "+user.getLogin()+" pass="+user.getPassword() );
        return userService.updateUser(user);
    }

    @GetMapping("/{userId}")
    public KkoResult getUser(@PathVariable Integer userId) {
        UserDto res = userService.getUserInfo(userId);

        KkoResult result = new KkoResult();
        if (res == null) {
            result.setMessage("User does not exist");
        }
        else {
            result.setMessage("User retrieved successfully");
            result.setResult(res);
        }
        return result;
    }

    @GetMapping("/all")
    public Iterable<UserDto> getAllUsers() {
        return userService.getAllUsers();
    }

}

package com.k2o.aquahackathon.dto;

import lombok.Data;

@Data
public class UserDto {
    Integer id;

    String login;

    String nickname;

    Float latitude;

    Float longitude;

    Integer points;

    String badge;

}

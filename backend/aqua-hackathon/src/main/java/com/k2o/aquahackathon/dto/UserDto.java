package com.k2o.aquahackathon.dto;

import lombok.Data;

@Data
public class UserDto {
    Integer id;

    String login;

    String nickname;

    String imageUrl;

    Float latitude;

    Float longitude;

    Integer points;

    String badge;

}

package com.k2o.aquahackathon.entity;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

import javax.persistence.*;

import static com.fasterxml.jackson.annotation.JsonProperty.Access.WRITE_ONLY;

@Entity
@Data
public class User {
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    Integer id;

    String login;

    @JsonProperty(access = WRITE_ONLY)
    String password;

    String nickname;

    String imageUrl;

    Float latitude = 0.0f;

    Float longitude = 0.0f;

    Integer points = 0;

    String badge = "Şəffaf su damcısı";
}

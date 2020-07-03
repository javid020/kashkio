package com.k2o.aquahackathon.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import javax.persistence.*;
import java.util.Date;

@Entity
@Data
public class WaterRequest {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    Integer id;

    @ManyToOne
    @JoinColumn(name="user_id")
    User initiator;

    @JsonFormat(pattern="yyyy-MM-dd HH:mm")
    Date createdDate = new Date();

    @JsonFormat(pattern="yyyy-MM-dd HH:mm")
    Date availTill = null;

    Float latitude = 0.0f;

    Float longitude = 0.0f;

    Integer requestType;

    String additionalInfo;


}

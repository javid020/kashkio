package com.k2o.aquahackathon.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import javax.persistence.*;
import java.util.Date;

@Entity
@Data
public class WrApplication {

    public enum ApplicationStatus {
        OPEN, ACCEPTED, CLOSED
    }

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    Integer id;

    @ManyToOne
    @JoinColumn(name="wr_id")
    WaterRequest waterRequest;

    @ManyToOne
    @JoinColumn(name="user_id")
    User appliedUser;

    @JsonFormat(pattern="yyyy-MM-dd HH:mm")
    Date appliedDate = new Date();

    @JsonFormat(pattern="yyyy-MM-dd HH:mm")
    Date closedDate = null;

    ApplicationStatus status = ApplicationStatus.OPEN;


}

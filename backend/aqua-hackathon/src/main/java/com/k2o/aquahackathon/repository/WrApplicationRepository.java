package com.k2o.aquahackathon.repository;

import com.k2o.aquahackathon.entity.WrApplication;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface WrApplicationRepository extends CrudRepository<WrApplication,Integer> {

    @Query("select wa from WrApplication wa where wa.waterRequest.id = :requestId")
    List<WrApplication> findByWrID(@Param("requestId") Integer requestId);
}

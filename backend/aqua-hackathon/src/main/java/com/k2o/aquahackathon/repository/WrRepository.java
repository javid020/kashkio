package com.k2o.aquahackathon.repository;

import com.k2o.aquahackathon.entity.WaterRequest;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface WrRepository extends CrudRepository<WaterRequest,Integer> {

    @Query("select wr from WaterRequest wr where wr.availTill is null or wr.availTill < now()")
    List<WaterRequest> getAllOpen();
}

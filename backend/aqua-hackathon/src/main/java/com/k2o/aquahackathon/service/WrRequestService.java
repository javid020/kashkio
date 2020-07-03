package com.k2o.aquahackathon.service;

import com.k2o.aquahackathon.entity.User;
import com.k2o.aquahackathon.entity.WaterRequest;
import com.k2o.aquahackathon.repository.UserRepository;
import com.k2o.aquahackathon.repository.WrRepository;
import com.k2o.aquahackathon.util.GpsUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
public class WrRequestService {

    @Autowired
    WrRepository wrRepository;

    @Autowired
    UserRepository userRepository;

    public String addRequest(WaterRequest wr) {
        try {
            wrRepository.save(wr);
            return "Success";
        }
        catch (Exception ex ) {
            return "Error: "+ex.getMessage();
        }
    }


    public List<WaterRequest> getOpen(Integer userId, Integer meters) {
        List<WaterRequest> wrList = new ArrayList<>();

        Optional<User> userOp = userRepository.findById(userId);
        if (userOp.isPresent() ) {
            User user = userOp.get();
            float la = user.getLatitude();
            float lo = user.getLongitude();

            List<WaterRequest> wrOpenAll = wrRepository.getAllOpen();
            for ( WaterRequest wr : wrOpenAll) {
                double distance = GpsUtils.distFrom(la,lo,wr.getLatitude(),wr.getLongitude());
                if ( distance <= meters) {
                    wrList.add(wr);
                }
            }
        }
        return wrList;
    }

    public String closeRequest(Integer requestId) {
        Optional<WaterRequest> wrOp = wrRepository.findById(requestId);
        if (wrOp.isPresent()) {
            WaterRequest wr = wrOp.get();
            wr.setAvailTill(new Date());
            wrRepository.save(wr);
            return "Success";
        }
        else {
            return "Request does not exist...";
        }
    }
}

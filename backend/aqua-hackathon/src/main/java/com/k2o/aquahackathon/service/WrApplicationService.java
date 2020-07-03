package com.k2o.aquahackathon.service;

import com.k2o.aquahackathon.entity.WrApplication;
import com.k2o.aquahackathon.repository.WrApplicationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
public class WrApplicationService {

    @Autowired
    WrApplicationRepository wrApplicationRepository;


    public String addApplication(WrApplication awApp) {
        try {
            wrApplicationRepository.save(awApp);
            return "Success";
        }
        catch (Exception ex) {
            return "Error: " + ex.getMessage();
        }
    }


    public List<WrApplication> getApplications(Integer requestId) {
        List<WrApplication> waList = wrApplicationRepository.findByWrID(requestId);
        return waList;
    }

    public String updateApplication(WrApplication awApply) {
        try {
            Optional<WrApplication> wrApp = wrApplicationRepository.findById(awApply.getId());
            if (wrApp.isPresent()) {
                WrApplication wr = wrApp.get();
                if (awApply.getStatus() != null) {
                    wr.setStatus(awApply.getStatus());
                    if (awApply.getStatus() == WrApplication.ApplicationStatus.CLOSED)
                        wr.setClosedDate(new Date());
                }

                wrApplicationRepository.save(wr);
                return "Success";
            } else {
                return "Application does not exist...";
            }
        }
        catch (Exception ex) {
            return "Error : "+ex.getMessage();
        }
    }
}

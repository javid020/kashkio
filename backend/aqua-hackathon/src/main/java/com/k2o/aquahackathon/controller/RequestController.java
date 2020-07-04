package com.k2o.aquahackathon.controller;

import com.k2o.aquahackathon.entity.WaterRequest;
import com.k2o.aquahackathon.entity.WrApplication;
import com.k2o.aquahackathon.service.WrApplicationService;
import com.k2o.aquahackathon.service.WrRequestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/request")
public class RequestController {

    @Autowired
    WrRequestService wrRequestService;

    @Autowired
    WrApplicationService wrApplicationService;

    @PostMapping("/add")
    public String addRequest(@RequestBody WaterRequest wr) {
        return wrRequestService.addRequest(wr);
    }

    @PostMapping("/close/{requestId}")
    public String closeRequest(@PathVariable Integer requestId) {
        return wrRequestService.closeRequest(requestId);
    }

    @GetMapping("/open/{userId}/{meters}")
    public List<WaterRequest> getOpenRequests(@PathVariable Integer userId,@PathVariable Integer meters) {
        List<WaterRequest> wrList = wrRequestService.getOpen(userId,meters);
        return wrList;
    }

    @PostMapping("/apply")
    public String applyToRequest(@RequestBody WrApplication awApply) {
        return wrApplicationService.addApplication(awApply);
    }

    @GetMapping("/applied/{requestId}")
    public List<WrApplication> getOpenApplications(@PathVariable Integer requestId) {
        List<WrApplication> wrAppList = wrApplicationService.getApplications(requestId);
        return wrAppList;
    }

    @PostMapping("/update")
    public String updateApplication(@RequestBody WrApplication awApply) {
        return wrApplicationService.updateApplication(awApply);
    }

}

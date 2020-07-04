package com.k2o.aquahackathon.bootstrap;

import com.k2o.aquahackathon.entity.User;
import com.k2o.aquahackathon.entity.WaterRequest;
import com.k2o.aquahackathon.repository.UserRepository;
import com.k2o.aquahackathon.repository.WrRepository;
import com.k2o.aquahackathon.util.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Component
public class DataFiller implements CommandLineRunner {

    @Autowired
    UserRepository userRepository;

    @Autowired
    WrRepository wrRepository;

    @Override
    public void run(String... args) throws Exception {
        User u1 = new User();
        u1.setLogin("+994502100080");
        u1.setNickname("Jamal");
        u1.setPassword(SecurityUtils.sha1EncodedText("123456"));
        userRepository.save(u1);

        User u2 = new User();
        u2.setLogin("+994554811148");
        u2.setNickname("Javid");
        u2.setPassword(SecurityUtils.sha1EncodedText("123456"));

        userRepository.save(u2);

        WaterRequest wr = new WaterRequest();
        wr.setInitiator(u1);
        wr.setLatitude(0.0f);
        wr.setLongitude(0.0f);
        wr.setRequestType(1);
        wr.setAdditionalInfo("Demo istek");

        wrRepository.save(wr);

        wr = new WaterRequest();
        wr.setInitiator(u2);
        wr.setLatitude(0.0f);
        wr.setLongitude(0.0f);
        wr.setRequestType(2);
        wr.setAdditionalInfo("Basqa bir istek");

        wrRepository.save(wr);

    }
}

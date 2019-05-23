package com.dncrm.service.system.e_offer;

public interface KieSession {
    int fireAllRules();

    void insert(Message message);
}

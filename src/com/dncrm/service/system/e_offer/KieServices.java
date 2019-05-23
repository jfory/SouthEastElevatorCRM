package com.dncrm.service.system.e_offer;

public interface KieServices {

    public static class Factory {
        public static KieServices get() {
            return null;
        }
    }

    KieContainer getKieClasspathContainer();
}

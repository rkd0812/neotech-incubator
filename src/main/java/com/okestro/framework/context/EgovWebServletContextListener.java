package com.okestro.framework.context;

import lombok.extern.slf4j.Slf4j;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

@Slf4j
public class EgovWebServletContextListener implements ServletContextListener {

    public EgovWebServletContextListener(){
        setEgovProfileSetting();
    }

    public void setEgovProfileSetting(){
        try {
            log.debug("===========================Start EgovServletContextLoad START ===========");
        } catch(IllegalArgumentException e) {
            log.error("[IllegalArgumentException] Try/Catch...usingParameters Runing : "+ e.getMessage());
        } catch (RuntimeException e) {
            log.error("[" + e.getClass() +"] search fail : " + e.getMessage());
        }
    }
}

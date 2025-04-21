package com.okestro.app.cmmn.layout.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class LayoutCtr {


    @RequestMapping("/layout/cmmnlib.do")
    public String cmmnlib() {
        return "cmmn/cmmnLib";
    }

}

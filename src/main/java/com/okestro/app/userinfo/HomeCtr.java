package com.okestro.app.userinfo;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeCtr {

    @RequestMapping("/")
    public String redirectToLogin() {
        return "redirect:/userinfo/loginForm.do";
    }
}

package com.okestro.app.code;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import javax.annotation.Resource;

@Controller
public class CodeCtr {

    @Resource(name="codeSvc")
    CodeSvc codeSvc;

}

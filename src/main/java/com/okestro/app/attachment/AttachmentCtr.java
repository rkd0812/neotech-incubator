package com.okestro.app.attachment;

import org.springframework.stereotype.Controller;

import javax.annotation.Resource;

@Controller
public class AttachmentCtr {

    @Resource(name="attachmentSvc")
    AttachmentSvc attachmentSvc;


    
}

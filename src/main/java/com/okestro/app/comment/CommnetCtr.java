package com.okestro.app.comment;

import org.springframework.stereotype.Controller;

import javax.annotation.Resource;

@Controller
public class CommnetCtr {

    @Resource(name="commentSvc")
    CommentSvc commentSvc;

}

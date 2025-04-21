package com.okestro.app.user;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import javax.annotation.Resource;
import java.util.List;

@Controller
public class UserCtr {

    @Resource(name="userSvc")
    UserSvc userSvc;

    @GetMapping("/user/list")
    public String retrieveUserList() {
        List<UserVo> userList = userSvc.retrieveUserList();
        return "user/userList";
    }
}

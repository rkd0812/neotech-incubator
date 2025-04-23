package com.okestro.app.user;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class UserCtr {

    @Resource(name="userSvc")
    UserSvc userSvc;

    // 사용자 목록조회
    @GetMapping("/user/list.do")
    public String retrieveUserList() {
        List<UserVo> userList = userSvc.retrieveUserList();
        return "user/userList";
    }

    // 사용자 상세조회
    @GetMapping("/user/detail.do")
    public String detailUser(HttpServletRequest request, Model model) {

        String userId = request.getParameter("userId");
        UserVo param = new UserVo();
        param.setUserId(userId);

        UserVo userDetail = userSvc.retrieveUserDetail(param);
        model.addAttribute("userDetail", userDetail);
        return "user/userDetail";
    }


}

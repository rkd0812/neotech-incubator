package com.okestro.app.user;

import com.okestro.app.code.CodeSvc;
import com.okestro.app.code.CodeVo;
import org.aspectj.apache.bcel.classfile.Code;
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

    @Resource(name="codeSvc")
    CodeSvc codeSvc;

    // 사용자 목록조회
    @GetMapping("/user/list.do")
    public String retrieveUserList(HttpServletRequest request, Model model) {

        String inputEmail = request.getParameter("inputEmail");
        String userRole = request.getParameter("userRole");

        request.setAttribute("inputEmail", inputEmail);
        request.setAttribute("userRole", userRole);

        UserVo userVo = new UserVo();
        userVo.setUserEmail(inputEmail);
        userVo.setRoleCd(userRole);

        // 사용자 목록조회
        List<UserVo> userList = userSvc.retrieveUserList(userVo);
        model.addAttribute("userList", userList);

        // 사용자 권한 조회 (ROLE)
        CodeVo codeVo = new CodeVo();
        codeVo.setCodeName("ROLE");
        List<CodeVo> codeList = codeSvc.retrieveCodeList(codeVo);
        model.addAttribute("codeList", codeList);

        return "user/userList";
    }

    // 사용자 상세조회
    @GetMapping("/user/detail.do")
    public String detailUser(HttpServletRequest request, Model model) {

        String userEmail = request.getParameter("userEmail");
        UserVo param = new UserVo();
        param.setUserEmail(userEmail);

        UserVo userDetail = userSvc.retrieveUserDetail(param);
        model.addAttribute("userDetail", userDetail);

        // 사용자 권한 조회 (ROLE)
        CodeVo codeVo = new CodeVo();
        codeVo.setCodeName("ROLE");
        List<CodeVo> codeList = codeSvc.retrieveCodeList(codeVo);
        model.addAttribute("codeList", codeList);

        return "user/userDetail";
    }


}

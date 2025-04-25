package com.okestro.app.user;

import com.okestro.app.code.CodeSvc;
import com.okestro.app.code.CodeVo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
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
    public String retrieveUserList(@ModelAttribute UserVo userVo, Model model) {

        model.addAttribute("userVo", userVo);

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

    @PostMapping("/user/update.do")
    public String updateUser(@ModelAttribute UserVo userVo) {
        int cnt = userSvc.updateUser(userVo);

        return "redirect:/user/detail.do?userEmail=" + userVo.getUserEmail();
    }

    @GetMapping("/user/openRegist.do")
    public String registerUser(Model model) {
        // 사용자 권한 조회 (ROLE)
        CodeVo codeVo = new CodeVo();
        codeVo.setCodeName("ROLE");
        List<CodeVo> codeList = codeSvc.retrieveCodeList(codeVo);
        model.addAttribute("codeList", codeList);
        return "user/userRegist";
    }

    @PostMapping("/user/regist.do")
    public String registerUser(@ModelAttribute UserVo userVo) {
        int cnt = userSvc.registUser(userVo);

        return "redirect:/user/list.do";
    }

    @GetMapping("/user/delete.do")
    public String deleteUser(@RequestParam("userEmail") String userEmail) {
        int cnt = userSvc.deleteUser(userEmail);

        return "redirect:/user/list.do";
    }



}

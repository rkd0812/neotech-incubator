package com.okestro.app.admin.user;

import com.okestro.app.admin.code.CodeSvc;
import com.okestro.app.admin.code.CodeVo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.time.LocalDate;
import java.util.List;

@Controller
public class UserCtr {

    @Resource(name="userSvc")
    UserSvc userSvc;

    @Resource(name="codeSvc")
    CodeSvc codeSvc;

    // 사용자 목록조회
    @GetMapping("/admin/user/list.do")
    public String retrieveUserList(@ModelAttribute UserVo userVo, Model model) {

        if(userVo.getStartDate() == null && userVo.getEndDate() == null) {
            LocalDate nowDate = LocalDate.now();
            userVo.setStartDate(nowDate.minusMonths(1).toString());
            userVo.setEndDate(nowDate.toString());
        }

        model.addAttribute("userVo", userVo);

        // 사용자 목록조회
        List<UserVo> userList = userSvc.retrieveUserList(userVo);
        model.addAttribute("userList", userList);

        // 사용자 권한 조회 (ROLE)
        CodeVo codeVo = new CodeVo();
        codeVo.setUpperCodeName("ROLE");
        List<CodeVo> codeList = codeSvc.retrieveCodeList(codeVo);
        model.addAttribute("codeList", codeList);

        return "admin/user/userList";
    }

    // 사용자 상세조회
    @GetMapping("/admin/user/detail.do")
//    public String detailUser(HttpServletRequest request, Model model) {
    public String detailUser(@RequestParam String userEmail, Model model) {

        UserVo user = new UserVo();
        user.setUserEmail(userEmail);

        UserVo userDetail = userSvc.retrieveUserDetail(user);
        model.addAttribute("userDetail", userDetail);

        // 사용자 권한 조회 (ROLE)
        CodeVo codeVo = new CodeVo();
        codeVo.setUpperCodeName("ROLE");
        List<CodeVo> codeList = codeSvc.retrieveCodeList(codeVo);
        model.addAttribute("codeList", codeList);

        return "admin/user/userDetail";
    }

    @PostMapping("/admin/user/update.do")
    public String updateUser(@ModelAttribute UserVo userVo, RedirectAttributes redirectAttributes) {
        int cnt = userSvc.updateUser(userVo);

        if (cnt > 0) {
            redirectAttributes.addFlashAttribute("msg", "수정 완료");
        } else {
            redirectAttributes.addFlashAttribute("msg", "수정 실패");
        }

        return "redirect:admin/user/detail.do?userEmail=" + userVo.getUserEmail();
    }

    @GetMapping("/admin/user/openRegist.do")
    public String openRegistUser(Model model) {
        // 사용자 권한 조회 (ROLE)
        CodeVo codeVo = new CodeVo();
        codeVo.setUpperCodeName("ROLE");
        List<CodeVo> codeList = codeSvc.retrieveCodeList(codeVo);
        model.addAttribute("codeList", codeList);
        return "admin/user/userRegist";
    }

    @PostMapping("/admin/user/regist.do")
    public String registerUser(@ModelAttribute UserVo userVo, RedirectAttributes redirectAttributes) {
        int cnt = userSvc.registUser(userVo);

        if(cnt > 0) {
            redirectAttributes.addFlashAttribute("msg", "등록 완료");
        } else {
            redirectAttributes.addFlashAttribute("msg", "등록 실패");
        }

        return "redirect:/admin/user/list.do";
    }

    @GetMapping("/admin/user/delete.do")
    public String deleteUser(@RequestParam("userEmail") String userEmail, RedirectAttributes redirectAttributes) {
        int cnt = userSvc.deleteUser(userEmail);

        if(cnt > 0) {
            redirectAttributes.addFlashAttribute("msg", "삭제 완료");
        } else {
            redirectAttributes.addFlashAttribute("msg", "삭제 실패");
        }

        return "redirect:/admin/user/list.do";
    }



}
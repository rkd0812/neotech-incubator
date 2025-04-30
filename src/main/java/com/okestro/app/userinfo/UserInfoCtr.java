package com.okestro.app.userinfo;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class UserInfoCtr {

    @Resource(name="userinfoSvc")
    UserInfoSvc userinfoSvc;

    @GetMapping("/userinfo/userinfoList.do")
    // [타입 변수명]으로 만들어줌.
    public String retrieveUserInfoList(Model model) {
        // 빈 UserInfoVo 객체 생성하여 전달
        UserInfoVo userInfoVo = new UserInfoVo();
        List<UserInfoVo> userinfoList = userinfoSvc.retrieveUserInfoList(userInfoVo);
        model.addAttribute("userinfoList", userinfoList);

        return "userinfo/userinfoList";
    }

    @GetMapping("/userinfo/registForm.do")
    public String registForm() {
        return "userinfo/registForm";  // JSP 파일 경로
    }

    // 회원정보 등록 처리
    @PostMapping("/userinfo/registerUserInfo.do")
    public String registerUserInfo(UserInfoVo userInfoVo, RedirectAttributes redirectAttr) {
        // 서비스를 통해 사용자 정보 저장
        userinfoSvc.insertUserInfo(userInfoVo);

        // 리다이렉트 시 메시지 전달
        redirectAttr.addFlashAttribute("message", "등록이 완료되었습니다.");

        // 등록 후 목록 페이지로 리다이렉트
        return "redirect:/userinfo/userinfoList.do";
    }

    @PostMapping("/userinfo/checkEmailDuplicate.do")
    @ResponseBody
    public boolean checkEmailDuplicate(@RequestParam("userEmail") String userEmail) {
        return userinfoSvc.checkUserDuplicate(userEmail);
    }

    // 사용자 상세 정보 조회
    @PostMapping("/userinfo/userDetail.do")
    public String userDetail(@RequestParam("userEmail") String userEmail, Model model, HttpSession session) {
        session.setAttribute("viewUserEmail", userEmail);
        UserInfoVo userInfo = userinfoSvc.userDetail(userEmail);
        model.addAttribute("userInfo", userInfo);
        return "userinfo/userDetail";
    }

    // 사용자 정보 수정 폼 표시
    @GetMapping("/userinfo/updateForm.do")
    public String updateForm(@RequestParam("userEmail") String userEmail, Model model) {
        UserInfoVo userInfo = userinfoSvc.userDetail(userEmail);

        // userInfo가 null인지 확인
        if(userInfo == null) {
            System.out.println("해당 이메일의 사용자 정보를 찾을 수 없음: " + userEmail);
            return "redirect:/userinfo/userinfoList.do";
        }
        model.addAttribute("userInfo", userInfo);
        return "userinfo/userUpdateForm";
    }

    // 사용자 정보 수정 처리
    @PostMapping("/userinfo/updateUserInfo.do")
    public String updateUserInfo(UserInfoVo userInfoVo, RedirectAttributes redirectAttr) {

        if(userInfoVo.getUserEmail() == null || userInfoVo.getUserEmail().isEmpty()) {
            redirectAttr.addFlashAttribute("message", "사용자 정보가 올바르지 않습니다.");
            return "redirect:/userinfo/userinfoList.do";
        }

        userinfoSvc.updateUserInfo(userInfoVo);
        redirectAttr.addFlashAttribute("message", "사용자 정보가 수정되었습니다.");
        return "redirect:/userinfo/userinfoList.do";
    }
    
    // 사용자 정보 삭제 처리
    @PostMapping("/userinfo/deleteUserInfo.do")
    public String deleteUserInfo(@RequestParam("userEmail") String userEmail, RedirectAttributes redirectAttr) {
        userinfoSvc.deleteUserInfo(userEmail);
        return "redirect:/userinfo/userinfoList.do";
    }

    // 로그인  페이지
    @GetMapping("/userinfo/loginForm.do")
    public String loginForm(
            @RequestParam(value="error", required=false) String error,
            @RequestParam(value="userEmail", required=false) String userEmail,
            Model model) {

        if (error != null) {
            if ("password".equals(error)) {
                model.addAttribute("errorMessage", "비밀번호가 일치하지 않습니다.");
            } else if ("email".equals(error)) {
                model.addAttribute("errorMessage", "존재하지 않는 이메일입니다.");
            } else if ("empty".equals(error)) {
                model.addAttribute("errorMessage", "이메일과 비밀번호를 입력해주세요.");
            } else if ("system".equals(error)) {
                model.addAttribute("errorMessage", "시스템 오류가 발생했습니다.");
            }
        }

        if (userEmail != null) {
            model.addAttribute("userEmail", userEmail);
        }

        return "userinfo/userinfoLogin";
    }

    // 로그인 처리
    @PostMapping("/userinfo/login.do")
    public String login(
            @RequestParam(value="userEmail", required=false) String userEmail,
            @RequestParam(value="userPassword", required=false) String userPassword,
            HttpSession session,
            RedirectAttributes redirectAttr) {


        if(userEmail == null || userEmail.isEmpty() || userPassword == null || userPassword.isEmpty()) {
            redirectAttr.addFlashAttribute("errorMessage", "이메일과 비밀번호를 입력해주세요.");
            return "redirect:/userinfo/loginForm.do?error=empty";
        }

        try {
            int loginResult = userinfoSvc.userLoginCheck(userEmail, userPassword);


            if (loginResult == 0) {

                UserInfoVo userInfo = userinfoSvc.retrieveUserInfoForLogin(userEmail);

                // 세션에 사용자 정보 저장
                session.setAttribute("loginUser", userInfo);
                session.setAttribute("userEmail", userInfo.getUserEmail());
                session.setAttribute("roleCd", userInfo.getRoleCd());

                // 성공 메시지와 함께 목록 페이지로 리다이렉트
                return "redirect:/userinfo/userinfoList.do";
            } else if (loginResult == 1) {
                return "redirect:/userinfo/loginForm.do";
            } else {
                return "redirect:/userinfo/loginForm.do?error=email";
            }
        } catch (Exception e) {

            e.printStackTrace();

            return "redirect:/userinfo/loginForm.do?error=system";
        }
    }
}

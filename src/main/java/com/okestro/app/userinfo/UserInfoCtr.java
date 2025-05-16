package com.okestro.app.userinfo;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class UserInfoCtr {

    @Resource(name = "userinfoSvc")
    UserInfoSvc userinfoSvc;

//    @GetMapping("/userinfo/userinfoList.do")
//    // [타입 변수명]으로 만들어줌.
//    public String retrieveUserInfoList(Model model) {
//        // 빈 UserInfoVo 객체 생성하여 전달
//        UserInfoVo userInfoVo = new UserInfoVo();
//        List<UserInfoVo> userinfoList = userinfoSvc.retrieveUserInfoList(userInfoVo);
//        model.addAttribute("userinfoList", userinfoList);
//
//        return "userinfo/userinfoLidst";
//    }

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
        return "redirect:/userinfo/loginForm.do";
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

    @GetMapping("/userinfo/userDetail.do")
    public String userDetailGet(@RequestParam("userEmail") String userEmail, Model model, HttpSession session) {
        // 기존 메서드 재사용
        return userDetail(userEmail, model, session);
    }

    //  사용자 정보 수정 폼 표시
    @GetMapping("/userinfo/updateForm.do")
    public String updateForm(@RequestParam("userEmail") String userEmail, Model model) {
        UserInfoVo userInfo = userinfoSvc.userDetail(userEmail);
        if (userInfo == null) {
            return "redirect:/userinfo/userinfoList.do";
        }
        model.addAttribute("userInfo", userInfo);
        return "userinfo/userUpdateForm";
    }

    // 사용자 정보 수정 처리
    @PostMapping("/userinfo/updateUserInfo.do")
    public String updateUserInfo(UserInfoVo userInfoVo, RedirectAttributes redirectAttr) {
        if (userInfoVo.getUserEmail() == null || userInfoVo.getUserEmail().isEmpty()) {
            redirectAttr.addFlashAttribute("message", "사용자 정보가 올바르지 않습니다.");
            return "redirect:/userinfo/userinfoList.do";
        }
        try {
            userinfoSvc.updateUserInfo(userInfoVo);
            redirectAttr.addFlashAttribute("message", "사용자 정보가 수정되었습니다.");
            return "redirect:/userinfo/userDetail.do?userEmail=" + userInfoVo.getUserEmail();
        } catch (Exception e) {
            redirectAttr.addFlashAttribute("message", "수정 중 오류가 발생했습니다.");
            return "redirect:/userinfo/userinfoList.do";
        }
    }

    // 사용자 정보 삭제 처리
    @PostMapping("/userinfo/deleteUserInfo.do")
    public String deleteUserInfo(@RequestParam("userEmail") String userEmail, RedirectAttributes redirectAttr) {
        userinfoSvc.deleteUserInfo(userEmail);
        return "redirect:/userinfo/loginForm.do";
    }

    // 로그인  페이지
    @GetMapping("/userinfo/loginForm.do")
    public String loginForm() {
        return "userinfo/userinfoLogin";
    }

    // 로그인 처리
    @PostMapping("/userinfo/login.do")
    public String login(UserInfoVo userInfoVo, HttpSession session, RedirectAttributes redirectAttr,
                        @RequestParam(value = "userEmailId", required = false) String userEmailId,
                        @RequestParam(value = "userDomain", required = false) String userDomain) {
        String userEmail = userInfoVo.getUserEmail();
        String userPassword = userInfoVo.getUserPassword();

        if (userEmail.isBlank() || userPassword.isBlank()) {
            redirectAttr.addFlashAttribute("errorMessage", "이메일과 비밀번호를 입력해주세요.");

            // 이메일 관련 정보 유지
            if (!userEmailId.isBlank()) {
                redirectAttr.addFlashAttribute("userEmailId", userEmailId);
            }
            if (!userDomain.isBlank()) {
                redirectAttr.addFlashAttribute("userDomain", userDomain);
            }
            return "redirect:/userinfo/loginForm.do";

        } else if (userEmail.isBlank()) {
            redirectAttr.addFlashAttribute("errorMessage", "이메일을 입력해주세요.");
            return "redirect:/userinfo/loginForm.do";
        } else if (userPassword.isBlank()) {
            redirectAttr.addFlashAttribute("errorMessage", "비밀번호를 입력해주세요.");
            // 아이디 입력 후 비밀번호 미 입력 시 아이디 초기화 방지
            redirectAttr.addFlashAttribute("userEmailId", userEmailId);
            redirectAttr.addFlashAttribute("userDomain", userDomain);
            return "redirect:/userinfo/loginForm.do";
        } else if (userPassword.length() < 10) {
            redirectAttr.addFlashAttribute("errorMessage", "비밀번호는 최소 10자 이상이어야 합니다.");
            // 아이디 입력 후 비밀번호 잘못 입력시 아이디 초기화 방지
            redirectAttr.addFlashAttribute("userEmailId", userEmailId);
            redirectAttr.addFlashAttribute("userDomain", userDomain);
            return "redirect:/userinfo/loginForm.do";
        }

//
//        String  errorMsg = "";
//
//        if(userEmail.isEmpty()) {
//            errorMsg = "이메일 잘못 옴"
//        }

        try {
            int loginResult = userinfoSvc.userLoginCheck(userEmail, userPassword);
            if (loginResult == 0) {
                UserInfoVo userInfo = userinfoSvc.retrieveUserInfoForLogin(userEmail);
                session.setAttribute("loginUser", userInfo);
                session.setAttribute("userEmail", userInfo.getUserEmail());
                session.setAttribute("roleCd", userInfo.getRoleCd());
                return "redirect:/project/projectList.do";
            } else if (loginResult == 1) {
                redirectAttr.addFlashAttribute("errorMessage", "비밀번호가 일치하지 않습니다.");
                redirectAttr.addFlashAttribute("userEmailId", userEmailId);
                redirectAttr.addFlashAttribute("userDomain", userDomain);
                return "redirect:/userinfo/loginForm.do";
            } else {
                redirectAttr.addFlashAttribute("errorMessage", "존재하지 않는 사용자입니다.");
                return "redirect:/userinfo/loginForm.do";
            }
        } catch (Exception e) {
            redirectAttr.addFlashAttribute("errorMessage", "시스템 오류가 발생했습니다.");
            redirectAttr.addFlashAttribute("userEmailId", userEmailId);
            redirectAttr.addFlashAttribute("userDomain", userDomain);
            return "redirect:/userinfo/loginForm.do";
        }
    }

    // 로그아웃
    @GetMapping("/userinfo/logout.do")
    public String logout(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttr) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            UserInfoVo loginUser = (UserInfoVo) session.getAttribute("loginUser");
            session.invalidate();
        }
            redirectAttr.addFlashAttribute("message", "로그아웃 되었습니다.");
            return "redirect:/userinfo/loginForm.do";

    }
}
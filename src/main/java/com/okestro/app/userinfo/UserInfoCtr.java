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
    @GetMapping("/userinfo/userDetail.do")
    public String userDetail(@RequestParam("userEmail") String userEmail, Model model) {
        UserInfoVo userInfo = userinfoSvc.userDetail(userEmail);
        model.addAttribute("userInfo", userInfo);
        return "userinfo/userDetail";
    }

    // 사용자 정보 수정 폼 표시
    @GetMapping("/userinfo/updateForm.do")
    public String updateForm(@RequestParam("userEmail") String userEmail, Model model) {
        UserInfoVo userInfo = userinfoSvc.userDetail(userEmail);
        model.addAttribute("userInfo", userInfo);
        return "userinfo/userUpdateForm";
    }

    // 사용자 정보 수정 처리
    @PostMapping("/userinfo/updateUserInfo.do")
    public String updateUserInfo(UserInfoVo userInfoVo, RedirectAttributes redirectAttr) {
        userinfoSvc.updateUserInfo(userInfoVo);
        return "redirect:/userinfo/userinfoList.do";
    }
    
    // 사용자 정보 삭제 처리
    @PostMapping("/userinfo/deleteUserInfo.do")
    public String deleteUserInfo(@RequestParam("userEmail") String userEmail, RedirectAttributes redirectAttr) {
        userinfoSvc.deleteUserInfo(userEmail);
        return "redirect:/userinfo/userinfoList.do";
    }

    // 로그인 페이지 표시
    @GetMapping("/userinfo/loginForm.do")
    public String loginForm() {
        return "userinfo/userinfoLogin";  // userinfoLogin.jsp 페이지로 이동
    }

    // 로그인 처리
    @PostMapping("/userinfo/login.do")
    public String login(
            @RequestParam(value="userEmail", required=false) String userEmail,
            @RequestParam(value="userPassword", required=false) String userPassword,
            HttpSession session,
            RedirectAttributes redirectAttr) {

        System.out.println("로그인 시도 - 이메일: " + userEmail); // 디버깅용 로그

        // 파라미터 누락 체크
        if(userEmail == null || userEmail.isEmpty() || userPassword == null || userPassword.isEmpty()) {
            // 파라미터가 없으면 로그인 폼으로 이동
            return "redirect:/userinfo/loginForm.do?empty=true";
        }

        try {
            // 서비스 호출하여 로그인 처리
            UserInfoVo userInfoVo = userinfoSvc.userLogin(userEmail, userPassword);
            // 로그인 성공/실패 처리
            if (userInfoVo != null) {
                // 로그인 성공: 세션에 사용자 정보 저장
                session.setAttribute("loginUser", userInfoVo);
                session.setAttribute("userEmail", userInfoVo.getUserEmail());
                session.setAttribute("roleCd", userInfoVo.getRoleCd());

                // 리다이렉트로 목록 페이지로 이동
                redirectAttr.addFlashAttribute("message", "로그인이 완료되었습니다.");
                return "redirect:/userinfo/userinfoList.do";
            } else {
                // 로그인 실패: 로그인 페이지로 다시 이동하며 오류 파라미터 추가
                return "redirect:/userinfo/loginForm.do?error=true&userEmail=" + userEmail;
            }
        } catch (Exception e) {
            // 예외 발생 시 로그 출력
            System.out.println("로그인 처리 중 오류 발생: " + e.getMessage());
            e.printStackTrace();

            // 오류 메시지와 함께 로그인 페이지로 이동
            return "redirect:/userinfo/loginForm.do?error=system";
        }
    }
}

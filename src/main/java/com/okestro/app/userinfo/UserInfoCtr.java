package com.okestro.app.userinfo;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
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
        redirectAttr.addFlashAttribute("message", "수정이 완료되었습니다.");
        return "redirect:/userinfo/userinfoList.do";
    }
    
    // 사용자 정보 삭제 처리
    @PostMapping("/userinfo/deleteUserInfo.do")
    public String deleteUserInfo(@RequestParam("userEmail") String userEmail, RedirectAttributes redirectAttr) {
        userinfoSvc.deleteUserInfo(userEmail);
        redirectAttr.addFlashAttribute("message", "삭제가 완료되었습니다.");
        return "redirect:/userinfo/userinfoList.do";
    }
}

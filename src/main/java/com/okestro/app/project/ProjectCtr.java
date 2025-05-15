package com.okestro.app.project;

import com.okestro.app.userinfo.UserInfoVo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class ProjectCtr {

    @Resource(name = "projectSvc")
    ProjectSvc projectSvc;


    @GetMapping("/project/projectList.do")
    public String retrieveProjcetList(HttpServletRequest request, HttpServletResponse response, Model model) {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loginUser") == null) {
            System.out.println("세션이 없거나 로그인 정보가 없음 - 로그인 페이지로 리다이렉트");
            return "redirect:/userinfo/loginForm.do";
        }

        UserInfoVo loginUser = (UserInfoVo) session.getAttribute("loginUser");

        List<ProjectVo> projectList = projectSvc.retrieveProjcetList();
        model.addAttribute("projectList", projectList);
        model.addAttribute("loginUser", loginUser);

        return "project/projectList";
    }

    @GetMapping("/project/projectDetail.do")
    public String retrieveProjectDetail(HttpServletRequest request, Model model) {
        HttpSession session = request.getSession();
        UserInfoVo loginUser = (UserInfoVo) session.getAttribute("loginUser");

        if (loginUser == null) {
            return "redirect:/userinfo/loginForm.do";
        }

        String projectId = request.getParameter("projectId");
        ProjectVo param = new ProjectVo();
        param.setProjectId(projectId);

        ProjectVo projectDetail = projectSvc.retrieveProjectDetail(param);
        model.addAttribute("projectDetail", projectDetail);
        model.addAttribute("loginUser", loginUser);

        return "project/projectDetail";
    }

    @PostMapping("/project/updateProject.do")
    public String updateProjectDetail(HttpServletRequest request, ProjectVo projectVo, Model model) {
        HttpSession session = request.getSession();
        if (session.getAttribute("loginUser") == null) {
            return "redirect:/userinfo/loginForm.do";
        }

        int result = projectSvc.updateProjectDetail(projectVo);

        if (result > 0) {
            return "redirect:/project/projectDetail.do?projectId=" + projectVo.getProjectId();
        } else {
            model.addAttribute("message", "프로젝트 수정에 실패했습니다.");
            return "project/projectDetail";
        }
    }



    @PostMapping("/project/delYnConfirmProject.do") // 메서드 이름과 URL 패턴 수정
    public String delYnConfirmProjectDetail(HttpServletRequest request, ProjectVo projectVo, Model model) {
        HttpSession session = request.getSession();
        if (session.getAttribute("loginUser") == null) {
            return "redirect:/userinfo/loginForm.do";
        }

        int result = projectSvc.delYnConfirmProjectDetail(projectVo);

        if (result > 0) {
            return "redirect:/project/projectDetail.do?projectId=" + projectVo.getProjectId();
        } else {
            model.addAttribute("message", "프로젝트 삭제에 실패했습니다.");
            return "project/projectDetail";
        }
    }
    
}



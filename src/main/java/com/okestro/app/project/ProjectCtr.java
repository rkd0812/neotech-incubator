package com.okestro.app.project;

import com.okestro.app.userinfo.UserInfoVo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.time.LocalDate;
import java.util.List;

@Controller
public class ProjectCtr {

    @Resource(name = "projectSvc")
    ProjectSvc projectSvc;

    @GetMapping("/project/projectList.do")
    public String retrieveProjectList(HttpServletRequest request, Model model, ProjectVo projectVo) {

        // 인터셉터 사용 후 세션 체크 제거, 로그인 사용자 정보 가져옴
        HttpSession session = request.getSession();
        UserInfoVo loginUser = (UserInfoVo) session.getAttribute("loginUser");
        String userEmail = loginUser.getUserEmail();

        projectVo.setUserEmail(userEmail);


        // 기본 날짜 설정
        if (projectVo.getSearchStartDate() == null || projectVo.getSearchStartDate().isEmpty()) {
            LocalDate today = LocalDate.now();
            LocalDate oneMonthAgo = today.minusMonths(1);

            projectVo.setSearchStartDate(oneMonthAgo.toString());  // 한 달 전
            projectVo.setSearchEndDate(today.toString());  // 오늘
        }

        // 페이징 설정
        int currentPageNo = projectVo.getCurrentPageNo();
        if (currentPageNo == 0) {
            projectVo.setCurrentPageNo(1);  // 기본 1페이지
        }

        // 페이징 정보 설정
        projectVo.setRecordCountPerPage(10);  // 페이지당 10개 항목
        projectVo.setPageSize(10);  // 페이지 그룹 크기 10

        // 전체 데이터 개수 조회
        int totalCount = projectSvc.countProjectList(projectVo);
        projectVo.setTotalRecordCount(totalCount);

        // 페이징 데이터 조회
        List<ProjectVo> projectList = projectSvc.retrieveProjectList(projectVo);

        model.addAttribute("projectVo", projectVo);
        model.addAttribute("projectList", projectList);
        model.addAttribute("loginUser", loginUser);

        return "project/projectList";
    }

    // 프로젝트 등록
    @GetMapping("/project/projectRegist.do")
    public String registProjectForm(HttpServletRequest request, Model model) {
        HttpSession session = request.getSession();
        UserInfoVo loginUser = (UserInfoVo) session.getAttribute("loginUser");
        model.addAttribute("loginUser", loginUser);
        return "project/projectRegist";
    }



    // 프로젝트 등록될 때
    @PostMapping("/project/insertProject.do")
    public String insertProject(ProjectVo projectVo, HttpServletRequest request, RedirectAttributes redirectAttr) {
        //세션 체크
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loginUser") == null) {
            return "redirect:/userinfo/loginForm.do";
        }

        // 로그인 사용자 정보 가져옴
        UserInfoVo loginUser = (UserInfoVo) session.getAttribute("loginUser");
        String userEmail = loginUser.getUserEmail();

        // 프로젝트 정보 설정
        projectVo.setLastChngId(userEmail);

        try {
            projectSvc.insertUserProject(projectVo);
            redirectAttr.addFlashAttribute("message", "프로젝트가 등록되었습니다.");
            return "redirect:/project/projectDetail.do?projectId=" + projectVo.getProjectId();
        } catch (Exception e) {
            redirectAttr.addFlashAttribute("message", "프로젝트 등록에 실패했습니다.");
            return "redirect:/project/projectList.do";
        }
    }

     // 프로젝트 수정 처리

    @PostMapping("/project/updateProject.do")
    public String updateProject(ProjectVo projectVo, HttpServletRequest request, RedirectAttributes redirectAttr) {
        // 세션 확인
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loginUser") == null) {
            return "redirect:/userinfo/loginForm.do";
        }

        // 로그인 사용자 정보 가져옴
        UserInfoVo loginUser = (UserInfoVo) session.getAttribute("loginUser");
        String userEmail = loginUser.getUserEmail();

        // 프로젝트 정보 설정
        projectVo.setLastChngId(userEmail);

        try {
            // 프로젝트 수정
            projectSvc.updateProject(projectVo);
            redirectAttr.addFlashAttribute("message", "프로젝트가 수정되었습니다.");
        } catch (Exception e) {
            redirectAttr.addFlashAttribute("message", "프로젝트 수정에 실패했습니다.");
        }

        // 프로젝트 상세 페이지로 리다이렉트
        return "redirect:/project/projectDetail.do?projectId=" + projectVo.getProjectId();
    }


     // 프로젝트 삭제 처리

    @PostMapping("/project/deleteProject.do")
    public String deleteProject(@RequestParam("projectId") String projectId, HttpServletRequest request, RedirectAttributes redirectAttr) {
        // 세션 확인
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loginUser") == null) {
            return "redirect:/userinfo/loginForm.do";
        }

        // 로그인 사용자 정보 가져오기
        UserInfoVo loginUser = (UserInfoVo) session.getAttribute("loginUser");
        String userEmail = loginUser.getUserEmail();

        try {
            // 프로젝트 정보 설정
            ProjectVo projectVo = new ProjectVo();
            projectVo.setProjectId(projectId);
            projectVo.setLastChngId(userEmail);

            // 프로젝트 삭제
            projectSvc.deleteProject(projectVo);
            redirectAttr.addFlashAttribute("message", "프로젝트가 삭제되었습니다.");
        } catch (Exception e) {
            redirectAttr.addFlashAttribute("message", "프로젝트 삭제에 실패했습니다.");
        }

        return "redirect:/project/projectList.do";
    }
}



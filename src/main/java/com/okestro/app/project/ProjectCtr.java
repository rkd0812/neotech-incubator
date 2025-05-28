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
    public String retrieveProjectList(HttpServletRequest request, Model model, ProjectPagingVo pagingVo) {

        // 인터셉터 사용 후 세션 체크 제거, 로그인 사용자 정보 가져옴
        HttpSession session = request.getSession();
        UserInfoVo loginUser = (UserInfoVo) session.getAttribute("loginUser");
        String userEmail = loginUser.getUserEmail();

        // 페이징 처리

        // 사용자 이메일 설정
        pagingVo.setUserEmail(userEmail);

        // 페이징 파라미터 처리 =====
        String currentPageNoStr = request.getParameter("currentPageNo");
        if (currentPageNoStr != null && !currentPageNoStr.isEmpty()) {
            try {
                int currentPageNo = Integer.parseInt(currentPageNoStr);
                pagingVo.getPaginationInfo().setCurrentPageNo(currentPageNo);
            } catch (NumberFormatException e) {
                pagingVo.getPaginationInfo().setCurrentPageNo(1);
            }
        }

        // 첫 페이지 로드 시 기본 기간 설정 (1달) =====
        if (pagingVo.getSearchStartDate() == null || pagingVo.getSearchStartDate().isEmpty()) {
            LocalDate today = LocalDate.now();
            LocalDate oneMonthAgo = today.minusMonths(1);

            pagingVo.setSearchStartDate(oneMonthAgo.toString());
            pagingVo.setSearchEndDate(today.toString());
        }

        // 심사 상태 라디오버튼 처리
        String searchEvaCd = request.getParameter("searchEvaCd");
        if (searchEvaCd != null && !searchEvaCd.trim().isEmpty()) {
            pagingVo.setSearchEvaCd(searchEvaCd);
        }

        // 전체 데이터 개수 조회
        int totalCount = projectSvc.countProjectList(pagingVo);
        pagingVo.getPaginationInfo().setTotalRecordCount(totalCount);

        // 페이징된 데이터 조회
        List<ProjectVo> projectList = projectSvc.retrieveProjectListPagiging(pagingVo);

        model.addAttribute("projectList", projectList);
        model.addAttribute("loginUser", loginUser);
        model.addAttribute("paging", pagingVo);  // 페이징 정보 전달

        return "project/projectList";
    }

    // 프로젝트 등록
    @GetMapping("/project/registProjectForm.do")
    public String registProjectForm(HttpServletRequest request, Model model) {
        // 세션 체크
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loginUser") == null) {
            return "redirect:/userinfo/loginForm.do";
        }

        // 로그인 사용자 정보 가져옴
        UserInfoVo loginUser = (UserInfoVo) session.getAttribute("loginUser");
        model.addAttribute("loginUser", loginUser);

        return "project/projectRegistForm";
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

    // 프로젝트 상세 조회
//    @GetMapping("/project/projectDetail.do")
//    public String projectDetail(@RequestParam("projectId") String projectId, HttpServletRequest request, RedirectAttributes redirectAttr, Model model) {
//        // 세션 체크
//        HttpSession session = request.getSession(false);
//        if (session == null || session.getAttribute("loginUser") == null) {
//            return "redirect:/userinfo/loginForm.do";
//        }
//
//        // 로그인 사용자 정보 가져옴
//        UserInfoVo loginUser = (UserInfoVo) session.getAttribute("loginUser");
//
//        // 프로젝트 상세 정보 조회
//        ProjectVo projectDetail = projectSvc.retrieveProjectDetail(projectId);
//
//        // 프로젝트가 없거나 삭제된 경우
//        if (projectDetail == null) {
//            redirectAttr.addFlashAttribute("message", "해당 프로젝트를 찾을 수 없습니다.");
//            return "redirect:/project/projectList.do";
//        }
//
//        // 모델에 데이터 추가
//        model.addAttribute("project", projectDetail);
//        model.addAttribute("loginUser", loginUser);
//
//        // 자신의 프로젝트인지 확인 (수정/삭제 버튼 표시 여부 결정)
//        boolean isMyProject = projectDetail.getLastChngId().equals(loginUser.getUserEmail());
//        model.addAttribute("isMyProject", isMyProject);
//
//        return "project/projectDetail";
//    }

//    // 프로젝트 수정
//    @GetMapping("/project/updateForm.do")
//    public String updateForm(@RequestParam("projectId") String projectId, HttpServletRequest request, Model model) {
//        // 세션 확인
//        HttpSession session = request.getSession(false);
//        if (session == null || session.getAttribute("loginUser") == null) {
//            return "redirect:/userinfo/loginForm.do";
//        }
//
//        // 로그인 사용자 정보 가져옴
//        UserInfoVo loginUser = (UserInfoVo) session.getAttribute("loginUser");
//        String userEmail = loginUser.getUserEmail();
//
//        // 프로젝트 상세 정보 조회
//        ProjectVo projectDetail = projectSvc.retrieveProjectDetail(projectId);
//
//        // 프로젝트가 없거나 삭제된 경우
//        if (projectDetail == null) {
//            model.addAttribute("message", "해당 프로젝트를 찾을 수 없습니다.");
//            return "redirect:/project/projectList.do";
//        }
//
//        // 로그인한 유저의 프로젝트인지 확인
//        if (!projectDetail.getLastChngId().equals(userEmail)) {
//            model.addAttribute("message", "본인의 프로젝트만 수정할 수 있습니다.");
//            return "redirect:/project/projectList.do";
//        }
//
//        // 6모델에 데이터 추가
//        model.addAttribute("project", projectDetail);
//        model.addAttribute("loginUser", loginUser);
//
//        return "project/projectUpdateForm";
//    }

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



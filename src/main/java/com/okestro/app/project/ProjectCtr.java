package com.okestro.app.project;

import com.okestro.app.userinfo.UserInfoVo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.multipart.MultipartFile;

import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
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


    @PostMapping("/project/saveProject.do")
    public String insertProject(ProjectVo projectVo, @RequestParam(value = "uploadFile", required = false) MultipartFile uploadFile, HttpServletRequest request, RedirectAttributes redirectAttr) {
        try {
            // 인터셉터 사용
            HttpSession session = request.getSession();
            UserInfoVo loginUser = (UserInfoVo) session.getAttribute("loginUser");

            String userEmail = loginUser.getUserEmail();
            String userName = loginUser.getUserName();

            // 로그인한 사용자 정보를 Vo에 설정
            projectVo.setUserEmail(userEmail);
            projectVo.setUserName(userName);
            projectVo.setLastChngId(userEmail);
            projectVo.setUploadFile(uploadFile);

            // 프로젝트 등록 상태로 저장
            projectSvc.insertUserProject(projectVo);

            redirectAttr.addFlashAttribute("message", "프로젝트가 저장되었습니다.");
            return "redirect:/project/projectDetail.do?projectId=" + projectVo.getProjectId();

        } catch (Exception e) {
            redirectAttr.addFlashAttribute("message", "프로젝트 저장에 실패했습니다: " + e.getMessage());
            return "redirect:/project/projectRegist.do";
        }
    }

    // 프로젝트 상세 조회
    @GetMapping("/project/projectDetail.do")
    public String retrieveProjectDetail(@RequestParam("projectId") String projectId,
                                        HttpServletRequest request, Model model) {
        // 인터셉터 사용 후 세션 체크 제거, 로그인 사용자 정보 가져옴
        HttpSession session = request.getSession();
        UserInfoVo loginUser = (UserInfoVo) session.getAttribute("loginUser");

        try {
            // 프로젝트 상세 정보 조회
            ProjectVo project = projectSvc.retrieveProjectDetail(projectId);

            if (project == null) {
                model.addAttribute("message", "존재하지 않는 프로젝트입니다.");
                return "redirect:/project/projectList.do";
            }

            // 팀원 목록 조회
            List<ProjectVo> teamMembers = projectSvc.selectProjectTeamMembers(projectId);

            // 팀원 이름들을 콤마로 연결
            if (teamMembers != null && !teamMembers.isEmpty()) {
                StringBuilder names = new StringBuilder();
                for (int i = 0; i < teamMembers.size(); i++) {
                    if (i > 0) names.append(", ");
                    names.append(teamMembers.get(i).getTeamMemberName());
                }
                project.setTeamMemberNames(names.toString()); // 기존 필드 사용
            }

            model.addAttribute("project", project);
            model.addAttribute("loginUser", loginUser);

        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("message", "프로젝트 조회 중 오류가 발생했습니다.");
            return "redirect:/project/projectList.do";
        }

        return "project/projectDetail";
    }

    // 프로젝트 수정 페이지
    @GetMapping("/project/projectUpdate.do")
    public String projectUpdateForm(@RequestParam("projectId") String projectId, HttpServletRequest request, Model model) {
        // 세션에서 로그인 사용자 정보
        HttpSession session = request.getSession();
        UserInfoVo loginUser = (UserInfoVo) session.getAttribute("loginUser");

        try {
            // 기존 프로젝트 정보 조회
            ProjectVo project = projectSvc.retrieveProjectDetail(projectId);

            if (project == null) {
                model.addAttribute("message", "존재하지 않는 프로젝트입니다.");
                return "redirect:/project/projectList.do";
            }

            // 팀원 목록 조회
            List<ProjectVo> teamMembers = projectSvc.selectProjectTeamMembers(projectId);

            // 팀원 이름들과 이메일들을 콤마로 연결
            if (teamMembers != null && !teamMembers.isEmpty()) {
                StringBuilder names = new StringBuilder();
                StringBuilder emails = new StringBuilder();

                for (int i = 0; i < teamMembers.size(); i++) {
                    // 로그인한 사용자는 제외
                    if (!teamMembers.get(i).getTeamMemberEmail().equals(loginUser.getUserEmail())) {
                        if (names.length() > 0) {
                            names.append(", ");
                            emails.append(",");
                        }
                        names.append(teamMembers.get(i).getTeamMemberName());
                        emails.append(teamMembers.get(i).getTeamMemberEmail());
                    }
                }

                project.setTeamMemberNames(names.toString());
                project.setTeamMemberEmails(emails.toString());
            }

            // 모델에 데이터 추가
            model.addAttribute("project", project);
            model.addAttribute("loginUser", loginUser);

        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("message", "프로젝트 조회 중 오류가 발생했습니다.");
            return "redirect:/project/projectList.do";
        }

        return "project/projectUpdateForm";  // JSP 파일명
    }


    // 프로젝트 수정 처리
    @PostMapping("/project/insertProjectUpdate.do")
    public String updateProject(ProjectVo projectVo, @RequestParam(value = "uploadFile", required = false) MultipartFile uploadFile, HttpServletRequest request, RedirectAttributes redirectAttr) {
        // 세션 확인
        HttpSession session = request.getSession();
        UserInfoVo loginUser = (UserInfoVo) session.getAttribute("loginUser");


        try {
            ProjectVo existingProject = projectSvc.retrieveProjectDetail(projectVo.getProjectId());

            if (existingProject == null) {
                redirectAttr.addFlashAttribute("message", "존재하지 않는 프로젝트입니다.");
                return "redirect:/project/projectList.do";
            }

            if (!existingProject.getFrstRgsrId().equals(loginUser.getUserEmail())) {
                redirectAttr.addFlashAttribute("message", "수정 권한이 없습니다.");
                return "redirect:/project/projectDetail.do?projectId=" + projectVo.getProjectId();
            }

            // 수정자 정보 설정
            projectVo.setLastChngId(loginUser.getUserEmail());
            projectVo.setUserEmail(loginUser.getUserEmail());
            projectVo.setUserName(loginUser.getUserName());
            projectVo.setUploadFile(uploadFile);
            // 프로젝트와 팀원 수정
            projectSvc.updateProjectAndTeamMember(projectVo);

            redirectAttr.addFlashAttribute("message", "프로젝트가 수정되었습니다.");

        } catch (Exception e) {
            e.printStackTrace();
            redirectAttr.addFlashAttribute("message", "프로젝트 수정 중 오류가 발생했습니다.");
            return "redirect:/project/projectDetail.do?projectId=" + projectVo.getProjectId();
        }

        return "redirect:/project/projectDetail.do?projectId=" + projectVo.getProjectId();
    }

    // 기존 등록 프로젝트 심사요청으로 상태 변경
    @PostMapping("/project/requestEvaluation.do")
    public String requestEvaluation(@RequestParam("projectId") String projectId, HttpServletRequest request, RedirectAttributes redirectAttr) {
        // 인터셉터 사용
        HttpSession session = request.getSession();
        UserInfoVo loginUser = (UserInfoVo) session.getAttribute("loginUser");
        String userEmail = loginUser.getUserEmail();

        try {
            // 프로젝트 정보 설정
            ProjectVo projectVo = new ProjectVo();
            projectVo.setProjectId(projectId);
            projectVo.setLastChngId(userEmail);

            // 심사요청으로 상태 변경
            projectSvc.requestEvaluation(projectVo);
            redirectAttr.addFlashAttribute("message", "심사요청이 완료되었습니다.");
        } catch (Exception e) {
            redirectAttr.addFlashAttribute("message", "심사요청에 실패했습니다: " + e.getMessage());
        }

        return "redirect:/project/projectDetail.do?projectId=" + projectId;
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

    // 파일 다운로드 25.07.16 현재는 사용 안하므로 주석
    @GetMapping("/project/downloadFile.do")
    public void downloadFile(@RequestParam("projectId") String projectId, HttpServletResponse response) {
        try {
            // 프로젝트 정보 조회
            ProjectVo project = projectSvc.retrieveProjectDetail(projectId);

            if (project.getFilePath() != null && !project.getFilePath().isEmpty()) {
                File file = new File(project.getFilePath());

                if (file.exists()) {
                    // 다운로드 헤더 설정
                    String encodedFileName = URLEncoder.encode(project.getDisplayFileName(), "UTF-8");
                    response.setContentType("application/octet-stream");
                    response.setHeader("Content-Disposition", "attachment; filename=\"" + encodedFileName + "\"");

                    // 파일 전송
                    try (FileInputStream fis = new FileInputStream(file);
                         OutputStream os = response.getOutputStream()) {
                        byte[] buffer = new byte[1024];
                        int bytesRead;
                        while ((bytesRead = fis.read(buffer)) != -1) {
                            os.write(buffer, 0, bytesRead);
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    @GetMapping("/project/popup/teamMemberSelect.do")
    public String teamMemberSelectPopup(HttpServletRequest request, Model model) {
        // 세션에서 로그인 사용자 정보 가져오기
        HttpSession session = request.getSession();
        UserInfoVo loginUser = (UserInfoVo) session.getAttribute("loginUser");

        try {
            List<ProjectVo> userList = projectSvc.retrieveUserList(loginUser.getUserEmail());

            model.addAttribute("loginUser", loginUser);
            model.addAttribute("userList", userList);
        } catch (Exception e) {
            model.addAttribute("message", "사용자 목록을 불러올 수 없습니다.");
        }

        return "project/selectProjectTeam";
    }

    // 팀원 개별 삭제
    @PostMapping("/project/deleteTeamMember.do")
    public String deleteTeamMember(@RequestParam("projectId") String projectId,
                                   @RequestParam("teamMemberEmail") String teamMemberEmail,
                                   HttpServletRequest request,
                                   RedirectAttributes redirectAttr) {
        HttpSession session = request.getSession();
        UserInfoVo loginUser = (UserInfoVo) session.getAttribute("loginUser");

        try {
            // 팀원 삭제를 위한 ProjectVo 설정
            ProjectVo deleteParam = new ProjectVo();
            deleteParam.setProjectId(projectId);
            deleteParam.setTeamMemberEmail(teamMemberEmail);
            deleteParam.setLastChngId(loginUser.getUserEmail());

            // 개별 팀원 삭제
            projectSvc.deleteTeamMember(deleteParam);

            redirectAttr.addFlashAttribute("message", "팀원이 삭제되었습니다.");
        } catch (Exception e) {
            redirectAttr.addFlashAttribute("message", "팀원 삭제에 실패했습니다: " + e.getMessage());
        }

        return "redirect:/project/projectDetail.do?projectId=" + projectId;
    }
}
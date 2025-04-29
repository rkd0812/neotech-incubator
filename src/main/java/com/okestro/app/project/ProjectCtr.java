package com.okestro.app.project;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class ProjectCtr {

    @Resource(name = "projectSvc")
    ProjectSvc projectSvc;

    @GetMapping("/project/projectList.do")
    public String retrieveProjcetList(Model model) {
        List<ProjectVo> projectList = projectSvc.retrieveProjcetList();
        model.addAttribute("projectList", projectList);

        return "project/projectList";
    }

    @GetMapping("/project/projectDetail.do")
    public String retrieveProjectDetail(HttpServletRequest request, Model model) {
        String projectId = request.getParameter("projectId");
        ProjectVo param = new ProjectVo();
        param.setProjectId(projectId);

        ProjectVo projectDetail = projectSvc.retrieveProjectDetail(param);
        model.addAttribute("projectDetail", projectDetail);

        return "project/projectDetail";
    }

    @PostMapping("/project/updateProject.do")
    public String updateProjectDetail(ProjectVo projectVo, Model model) {
        int result = projectSvc.updateProjectDetail(projectVo);

        if (result > 0) {
            // 성공 시
            return "redirect:/project/projectDetail.do?projectId=" + projectVo.getProjectId();
        } else {
            // 실패 시
            model.addAttribute("message", "프로젝트 수정에 실패했습니다.");
            return "project/projectDetail";
        }
    }

//    @PostMapping("/project/deleteProject.do")
//    public String deleteProjectDetail(ProjectVo projectVo) {
//        projectSvc.deleteProjectDetail(projectVo);
//        return "redirect:/project/projectList.do";
//    }
    
    @PostMapping
    public String delYnConfirmProjectDetail(ProjectVo projectVo, Model model) {
        int result = projectSvc.delYnConfirmProjectDetail(projectVo);
        
        if (result > 0) {
            return "redirect:/project/projectDetail.do?projectId=" + projectVo.getProjectId();
        } else {
            model.addAttribute("message", "프로젝트 삭제에 실패했습니다.");
            return "project/projectDetail";
        }
    }
    
}



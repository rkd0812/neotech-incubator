package com.okestro.app.project;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.annotation.Resource;
import java.util.List;

@Controller
public class ProjectCtr {

    @Resource(name="projectSvc")
    ProjectSvc projectSvc;

    @GetMapping("/project/projectList.do")
    public String retrieveProjcetList(Model model) {
        List<ProjectVo> projectList = projectSvc.retrieveProjcetList();
        model.addAttribute("projectList", projectList);

        return "project/projectList";
    }

}

package com.okestro.app.projdectdetail;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.annotation.Resource;
import java.util.List;

@Controller
public class ProjectDetailCtr {

    @Resource(name="projectdetailSvc")
    ProjectDetailSvc projectdetailSvc;

    @GetMapping("/project/projectDetail.do")
    public String retrieveProjectDetail(Model model) {
        List<ProjectDetailVo> projectDetail = projectdetailSvc.retrieveProjectDetail();
        model.addAttribute("projectDetail", projectDetail);

        return "project/projectDetail";
    }
}

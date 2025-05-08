package com.okestro.app.evaProject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import javax.annotation.Resource;
import java.time.LocalDate;
import java.util.List;

@Controller
public class EvaProjectCtr {

    @Resource(name="evaProjectSvc")
    EvaProjectSvc evaProjectSvc;

    // 심사 프로젝트 목록조회
    @GetMapping("/evaProject/list.do")
    public String retrieveEvaProjectList(@ModelAttribute EvaProjectVo evaProjectVo, Model model) {

        if(evaProjectVo.getStartDate() == null && evaProjectVo.getEndDate() == null) {
            LocalDate nowDate = LocalDate.now();
            evaProjectVo.setStartDate(LocalDate.now().minusMonths(1).toString());
            evaProjectVo.setEndDate(nowDate.toString());
        }

        List<EvaProjectVo> eveProjectList = evaProjectSvc.retrieveEvaProjectList(evaProjectVo);
        model.addAttribute("eveProjectList", eveProjectList);

        return "/evaProject/evaProjectList";
    }

    // 심사 프로젝트 상세조회
    @GetMapping("/evaProject/detail.do")
    public String retrieveEvaProjectDetail(@ModelAttribute EvaProjectVo evaProjectVo, Model model) {

        EvaProjectVo evaProjectDetail = evaProjectSvc.retrieveEvaProjectDetail(evaProjectVo);
        model.addAttribute("evaProjectDetail", evaProjectDetail);


        return "/evaProject/evaProjectDetail";

    }

}

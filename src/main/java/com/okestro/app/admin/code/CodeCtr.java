package com.okestro.app.admin.code;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import java.time.LocalDate;
import java.util.List;

@Controller
public class CodeCtr {

    @Resource(name="codeSvc")
    CodeSvc codeSvc;

    // 코드 등록 페이지 오픈
    @GetMapping("/admin/code/openRegist.do")
    public String openRegistCode(@ModelAttribute CodeVo codeVo) {
        return "/admin/code/codeRegist";
    }

    // 코드 등록
    @PostMapping("/admin/code/regist.do")
    public String registCode(@ModelAttribute CodeVo codeVo, RedirectAttributes redirectAttributes) {
        int cnt = codeSvc.registerCode(codeVo);

        if (cnt > 0) {
            redirectAttributes.addFlashAttribute("msg", "등록 완료");
        } else {
            redirectAttributes.addFlashAttribute("msg", "등록 실패");
        }

        return "redirect:/admin/code/list.do";
    }

    // 코드 목록조회
    @GetMapping("/admin/code/list.do")
    public String retrieveCodeList(@ModelAttribute CodeVo codeVo, Model model) {

        if(codeVo.getStartDate() == null && codeVo.getEndDate() == null) {
            LocalDate nowDate = LocalDate.now();
            codeVo.setStartDate(LocalDate.now().minusMonths(1).toString());
            codeVo.setEndDate(nowDate.toString());
        }

        model.addAttribute("codeVo", codeVo);

        List<CodeVo> codeList = codeSvc.retrieveCodeList(codeVo);
        model.addAttribute("codeList", codeList);

        return "/admin/code/codeList";
    }

    // 코드 상세조회
    @GetMapping("/admin/code/detail.do")
    public String retrieveCodeDetail(@ModelAttribute CodeVo codeVo, Model model) {

        CodeVo codeDetail = codeSvc.retrieveCodeDetail(codeVo);
        model.addAttribute("codeDetail", codeDetail);

        List<CodeVo> codeGroupList = codeSvc.retrieveCodeGroupList(codeVo);
        model.addAttribute("codeGroupList", codeGroupList);

        return "/admin/code/codeDetail";
    }

    // 코드 수정
    @PostMapping("/admin/code/update.do")
    public String updateCode(@ModelAttribute CodeVo codeVo, RedirectAttributes redirectAttributes) {

        int cnt = codeSvc.updateCode(codeVo);
        if(cnt > 0) {
            redirectAttributes.addFlashAttribute("msg", "수정 완료");    
        } else {
            redirectAttributes.addFlashAttribute("msg", "수정 실패");
        }
        

        return "redirect:/admin/code/detail.do?upperCodeName=" + codeVo.getUpperCodeName() + "&codeVal=" + codeVo.getCodeVal();
    }

    // 코드 삭제
    @GetMapping("/admin/code/delete.do")
    public String deleteCode(@ModelAttribute CodeVo codeVo, RedirectAttributes redirectAttributes) {

        int cnt = codeSvc.deleteCode(codeVo);

        if(cnt > 0) {
            redirectAttributes.addFlashAttribute("msg", "삭제 완료");
        } else {
            redirectAttributes.addFlashAttribute("msg", "삭제 실패");
        }

        return "redirect:/admin/code/list.do";
    }

}

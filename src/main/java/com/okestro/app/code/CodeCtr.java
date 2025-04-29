package com.okestro.app.code;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import java.util.List;

@Controller
public class CodeCtr {

    @Resource(name="codeSvc")
    CodeSvc codeSvc;

    // 코드 등록 페이지 오픈
    @GetMapping("/code/openRegist.do")
    public String openRegistCode(@ModelAttribute CodeVo codeVo) {
        return "code/codeRegist";
    }

    // 코드 등록
    @PostMapping("/code/regist.do")
    public String registCode(@ModelAttribute CodeVo codeVo) {
        int cnt = codeSvc.registerCode(codeVo);

        return "redirect:/code/list.do";
    }

    // 코드 목록조회
    @GetMapping("/code/list.do")
    public String retrieveCodeList(@ModelAttribute CodeVo codeVo, Model model) {

        model.addAttribute("codeVo", codeVo);

        List<CodeVo> codeList = codeSvc.retrieveCodeList(codeVo);
        model.addAttribute("codeList", codeList);

        return "code/codeList";
    }

    // 코드 상세조회
    @GetMapping("/code/detail.do")
    public String retrieveCodeDetail(@RequestParam String codeName, String codeVal, Model model) {
        CodeVo codeVo = new CodeVo();
        codeVo.setCodeName(codeName);
        codeVo.setCodeVal(codeVal);

        CodeVo codeDetail = codeSvc.retrieveCodeDetail(codeVo);
        model.addAttribute("codeDetail", codeDetail);

        return "code/codeDetail";
    }

    // 코드 수정
    @PostMapping("/code/update.do")
    public String updateCode(@ModelAttribute CodeVo codeVo) {

        int cnt = codeSvc.updateCode(codeVo);

        return "redirect:/code/detail.do?codeName=" + codeVo.getCodeName() + "&codeVal=" + codeVo.getCodeVal();
    }

    // 코드 삭제
    @GetMapping("/code/delete.do")
    public String deleteCode(@RequestParam String codeName, String codeVal) {
        CodeVo codeVo = new CodeVo();
        codeVo.setCodeName(codeName);
        codeVo.setCodeVal(codeVal);

        int cnt = codeSvc.deleteCode(codeVo);

        return "redirect:/code/list.do";
    }

}

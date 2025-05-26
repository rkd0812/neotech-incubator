package com.okestro.app.evaProject;

import com.okestro.app.admin.code.CodeSvc;
import com.okestro.app.admin.code.CodeVo;
import com.okestro.app.attachment.AttachmentSvc;
import com.okestro.app.attachment.AttachmentVo;
import com.okestro.app.comment.CommentSvc;
import com.okestro.app.comment.CommentVo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import javax.annotation.Resource;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Controller
public class EvaProjectCtr {

    @Resource(name="evaProjectSvc")
    EvaProjectSvc evaProjectSvc;

    @Resource(name="codeSvc")
    CodeSvc codeSvc;

    @Resource(name="attachmentSvc")
    AttachmentSvc attachmentSvc;

    @Resource(name="commentSvc")
    CommentSvc commentSvc;

    // 심사 프로젝트 목록조회
    @GetMapping("/evaProject/list.do")
    public String retrieveEvaProjectList(@ModelAttribute EvaProjectVo evaProjectVo, Model model) {

        if(evaProjectVo.getStartDate() == null && evaProjectVo.getEndDate() == null) {
            LocalDate nowDate = LocalDate.now();
//            evaProjectVo.setStartDate(LocalDate.now().minusMonths(1).toString());
//            evaProjectVo.setEndDate(nowDate.toString());
            evaProjectVo.setStartDate(nowDate.minusMonths(3).toString());
            evaProjectVo.setEndDate(nowDate.plusMonths(3).toString());
        }
        
        // 목록 개수 조회
        int evaProjectListCnt = evaProjectSvc.retrieveEvaProjectListCnt(evaProjectVo);

        // 페이징
        int currentPageNo = evaProjectVo.getCurrentPageNo();

        if (currentPageNo == 0) {
            evaProjectVo.setCurrentPageNo(1);       // 현재 페이지
        }

        evaProjectVo.setTotalRecordCount(evaProjectListCnt);    // 총 개수
        evaProjectVo.setRecordCountPerPage(10);                 // 한 페이지당 글 10개
        evaProjectVo.setPageSize(10);                           // 페이지 리스트에 게시되는 페이지 건수

        int totalPageCount = evaProjectVo.getTotalPageCount();                    // 페이지 개수
//        int firstPageNoOnPageList = evaProjectVo.getFirstPageNoOnPageList();      // 시작 페이지
//        int lastPageNoOnPageList = evaProjectVo.getLastPageNoOnPageList();        // 마지막 페이지
//        int firstRecordIndex = evaProjectVo.getFirstRecordIndex();                // 글 시작 번호
//        int lastRecordIndex = evaProjectVo.getLastRecordIndex();                  // 글 마지막 번호

        model.addAttribute("currentPageNo", currentPageNo);
        model.addAttribute("totalPageCount", totalPageCount);

        // 목록조회
        List<EvaProjectVo> evaProjectList = evaProjectSvc.retrieveEvaProjectList(evaProjectVo);
        model.addAttribute("evaProjectList", evaProjectList);

        // 심사 상태 권한 조회 (EVALUATION)
        CodeVo codeVo = new CodeVo();
        codeVo.setUpperCodeName("EVALUATION");
        List<CodeVo> codeList = codeSvc.retrieveCodeList(codeVo);
        model.addAttribute("codeList", codeList);

        return "/evaProject/evaProjectList";
    }

    // 심사 프로젝트 상세조회
    @GetMapping("/evaProject/detail.do")
    public String retrieveEvaProjectDetail(@ModelAttribute EvaProjectVo evaProjectVo, Model model) {

        EvaProjectVo evaProjectDetail = evaProjectSvc.retrieveEvaProjectDetail(evaProjectVo);
        model.addAttribute("evaProjectDetail", evaProjectDetail);

        // 첨부파일 조회
        List<AttachmentVo> attachmentList = attachmentSvc.retrieveAttachmentList(evaProjectVo);
        List<AttachmentVo> attachmentDetailList = new ArrayList<>();

        attachmentList.forEach(attachment -> {
            AttachmentVo attachmentDetail = attachmentSvc.retrieveAttachment(attachment.getAttachmentId());
            attachmentDetailList.add(attachmentDetail);
        });

        model.addAttribute("attachmentDetailList", attachmentDetailList);

        // 댓글 조회
        List<CommentVo> commentList = commentSvc.retrieveCommentList(evaProjectVo.getProjectId());

        model.addAttribute("commentList", commentList);

        return "/evaProject/evaProjectDetail";

    }

}

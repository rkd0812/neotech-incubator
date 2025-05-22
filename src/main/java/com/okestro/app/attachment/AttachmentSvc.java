package com.okestro.app.attachment;

import com.okestro.app.evaProject.EvaProjectVo;

import java.util.List;

public interface AttachmentSvc {
    // 첨부파일 목록조회
    List<AttachmentVo> retrieveAttachmentList(EvaProjectVo evaProjectVo);
    // 첨부파일 조회
    AttachmentVo retrieveAttachment(String attachmentId);
}

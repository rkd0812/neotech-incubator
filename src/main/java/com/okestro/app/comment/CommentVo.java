package com.okestro.app.comment;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class CommentVo {
    private String commentId;
    private String commentContent;
    private String projectId;
    private String delYn;
    private String frstRgsrId;
    private String frstRgsrDtlDttm;
    private String lastChngId;
    private String lastChngDtlDttm;
}

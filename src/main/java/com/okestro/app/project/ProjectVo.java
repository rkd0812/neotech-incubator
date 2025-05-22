package com.okestro.app.project;
import com.okestro.app.cmmn.vo.BaseVo;


import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter @Setter
public class ProjectVo extends BaseVo {
    // 테이블 컬럼 필드 설정
    // project 테이블 필드
    private String projectName;
    private String userGroupId;
    private String evaGroupId;
    private String evaCd;
    private Integer scoreFin;
    private String projectDetail;
    private String url;
    private LocalDateTime evastartDt;
    private LocalDateTime evaendDt;


    // project_detail 테이블 필드
    private String attachmentID;

    public String getEvaStartDtString() {
        return evastartDt != null ? evastartDt.toLocalDate().toString() : "";
    }

    public String getEvaEndDtString() {
        return evaendDt != null ? evaendDt.toLocalDate().toString() : "";
    }

}
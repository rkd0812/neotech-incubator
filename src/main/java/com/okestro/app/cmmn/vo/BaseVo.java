package com.okestro.app.cmmn.vo;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class BaseVo {
    // 프로젝트 ID
    private String projectId;

    private String delYn;
    private String frstRgsrId;
    private String frstRgsrDtlDttm;
    private String lastChngId;
    private String lastChngDtlDttm;
}

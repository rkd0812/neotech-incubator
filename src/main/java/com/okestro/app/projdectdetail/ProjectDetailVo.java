package com.okestro.app.projdectdetail;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter @Setter
public class ProjectDetailVo {
    // 테이블 컬럼 필드 설정
    // project_detail 테이블 필드
    private String projectId;
    private String groupId;
    private String projectDetail;
    private String Url;
    private String attachementId;
    private String delYn;
    private String frstrgsrId;
    private LocalDateTime frstrgsrdtlDttm;
    private String lastchngId;
    private LocalDateTime lastchngdtlDttm;
}

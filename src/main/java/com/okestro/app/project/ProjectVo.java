package com.okestro.app.project;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter @Setter
public class ProjectVo {
    // 테이블 컬럼 필드 설정
    // project 테이블 필드
    private String projectId;
    private String projectName;
    private String evaCd;
    private Integer scoreFin;
    private LocalDateTime evastartDt;
    private LocalDateTime evaendDt;
    private String delYn;
    private String frstrgsrId;
    private LocalDateTime frstrgsrdtlDttm;
    private String lastchngId;
    private LocalDateTime lastchngdtlDttm;
}
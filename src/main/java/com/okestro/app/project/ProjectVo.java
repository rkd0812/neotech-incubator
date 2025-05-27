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
    private LocalDateTime evaStartDt;
    private LocalDateTime evaEndDt;


    // project_detail 테이블 필드
    private String attachmentID;

    // Join 하기 위해 사용할 다른 테이블 필드
    private String userName;         // user 테이블의 사용자 이름
    private String codeName;         // code 테이블의 코드명


    // 검색을 위한 필드
    private String searchProjectName;  // 프로젝트 이름 검색 시 사용하기 위해 만든 필드
    private String searchStartDate;    // 프로젝트 등록 날짜 검색 시 사용하기 위해 만든 필드
    private String searchEndDate;      // 프로젝트 최종 등록 날짜 검색 시 사용하기 위해 만든 필드
    private String searchEvaCd;        // 프로젝트 평가 상태를 검색 시 사용하기 위해 만든 필드




    public String getEvaStartDtString() {
        return evaStartDt != null ? evaStartDt.toLocalDate().toString() : "";
    }

    public String getEvaEndDtString() {
        return evaEndDt != null ? evaEndDt.toLocalDate().toString() : "";
    }

}
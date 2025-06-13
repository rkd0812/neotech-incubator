package com.okestro.app.project;



import lombok.Getter;
import lombok.Setter;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import java.time.LocalDateTime;

@Getter @Setter
public class ProjectVo extends PaginationInfo {
    // 테이블 컬럼 필드 설정
    // project 테이블 필드
    private String projectId;
    private String projectName;
    private String userGroupId;
    private String evaGroupId;
    private String evaCd;
    private Integer scoreFin;
    private String projectDetail;
    private String url;
    private LocalDateTime evaStartDt;
    private LocalDateTime evaEndDt;
    private String delYn;
    private String frstRgsrId;
    private String frstRgsrDtlDttm;
    private String lastChngId;
    private String lastChngDtlDttm;


    // project_detail 테이블 필드
//    private String attachmentID;

    // attachment 테이블 필드
    private String attachmentId;
    private String attachmentName;

    // Join 하기 위해 사용할 다른 테이블 필드
    private String userName;         // user 테이블의 사용자 이름
    private String codeName;         // code 테이블의 코드명


    // 검색을 위한 필드
    private String searchProjectName;  // 프로젝트 이름 검색 시 사용하기 위해 만든 필드
    private String searchStartDate;    // 프로젝트 등록 날짜 검색 시 사용하기 위해 만든 필드
    private String searchEndDate;      // 프로젝트 최종 등록 날짜 검색 시 사용하기 위해 만든 필드
    private String searchEvaCd;        // 프로젝트 평가 상태를 검색 시 사용하기 위해 만든 필드
    private String userEmail;


    // 팀 구성원 필드
    private String teamMembers;  // 팀 구성원 이메일
    private String teamMemberNames;  // 팀 구성원 이름

    // 폼 처리용 임시 필드
    private String actionType;


    public String getEvaStartDtString() {
        return evaStartDt != null ? evaStartDt.toLocalDate().toString() : "";
    }

    public String getEvaEndDtString() {
        return evaEndDt != null ? evaEndDt.toLocalDate().toString() : "";
    }

    // 등록일시 문자열 변환 메서드
    public String getFrstRgsrDtlDttmString() {
        return frstRgsrDtlDttm != null ? frstRgsrDtlDttm.substring(0, 10) : "";
    }

}
package com.okestro.app.project;



import lombok.Getter;
import lombok.Setter;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.web.multipart.MultipartFile;
import java.util.List;

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


    // 파일 경로를 저장하기 위한 컬럼 추가
    private String filePath;

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
    private String teamMemberEmail;  // 팀원 이메일
    private String teamMemberName;  // 팀원 이름

    // 팝업에서 선택한 여러 팀원 받아올 때
    private String teamMemberEmails;  // 팝업에서 선택된 이메일들
    private String teamMemberNames;   // 팝업에서 선택된 이름들

    private String groupId;                 // 그룹 ID
    private String groupCd;                 // 그룹 코드

    private MultipartFile uploadFile;

    private String deleteFile;

    public String getEvaStartDtString() {
        return evaStartDt != null ? evaStartDt.toLocalDate().toString() : "";
    }

    public String getEvaEndDtString() {
        return evaEndDt != null ? evaEndDt.toLocalDate().toString() : "";
    }

    // 등록일시 문자열 변환 메서드
    public String getFrstRgsrDtlDttmString() {
        if (frstRgsrDtlDttm != null && frstRgsrDtlDttm.length() >= 10) {
            return frstRgsrDtlDttm.substring(0, 10);
        }
        return "";
    }

    public String getLastChngDtlDttmString() {
        if (lastChngDtlDttm != null && lastChngDtlDttm.length() >= 10) {
            return lastChngDtlDttm.substring(0, 10);
        }
        return "";
    }

    public String getDisplayFileName() {
        if (filePath == null || filePath.trim().isEmpty()) {
            return "";
        }

        String fileName = filePath.substring(filePath.lastIndexOf("\\") + 1);
        return fileName;
    }
    public boolean hasFile() {
        return filePath != null && !filePath.trim().isEmpty();
    }
}
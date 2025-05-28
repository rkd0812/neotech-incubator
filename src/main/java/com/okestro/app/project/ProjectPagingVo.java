package com.okestro.app.project;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ProjectPagingVo {


    //  페이징 정보
//    private int pageNum = 1;    // 현재 페이지 번호 (기본값 : 1페이지)
//    private int pageSize = 10;   // 페이지당 항목 수 (기본값 : 10개)
//    private int totalCount = 0; // 전체 건수
//    private int totalPages = 0; // 전체 페이지 수

    // paginationInfo 사용
    private PaginationInfo paginationInfo;

    // 검색 조건
    private String searchProjectName;  // 프로젝트 이름 검색 시 사용하기 위해 만든 필드
    private String searchStartDate;    // 프로젝트 등록 날짜 검색 시 사용하기 위해 만든 필드
    private String searchEndDate;      // 프로젝트 최종 등록 날짜 검색 시 사용하기 위해 만든 필드
    private String searchEvaCd;        // 프로젝트 평가 상태를 검색 시 사용하기 위해 만든 필드
    private String userEmail;          // 로그인한 사용자 이메일

//    // DB에서 OFFSET 계산 → 몇 번째 데이터 부터 가져올것인지
//    public int getOffset() {
//        return (pageNum - 1) * pageSize;
//    }
//
//    // 전체 데이터 개수 설정 후 전체 페이지 수 자동 계산
//    public void setTotalCount(int totalCount) {
//        this.totalCount = totalCount;
//        if (pageSize > 0) {
//            this.totalPages = (int) Math.ceil((double) totalCount / pageSize);
//        }
//    }

    // 생성자  PaginationInfo 초기화
    public ProjectPagingVo() {
        this.paginationInfo = new PaginationInfo();       // 기본값 설정
        this.paginationInfo.setCurrentPageNo(1);          // 기본 1페이지
        this.paginationInfo.setRecordCountPerPage(10);    // 페이지당 10개 항목
        this.paginationInfo.setPageSize(10);              // 페이지 그룹 크기 10
    }
    public int getPageSize() {
        return this.paginationInfo.getRecordCountPerPage();
    }

    // SQL에서 사용할 OFFSET용
    public int getOffset() {
        return this.paginationInfo.getFirstRecordIndex();
    }
}

package com.okestro.app.project;


import java.util.List;

public interface ProjectSvc {
    // 전체 프로젝트 개수 조회 (페이징)
    int countProjectList(ProjectPagingVo pagingVo);

    //  프로젝트 목록 조회 (검색과 페이징 둘 다)
    List<ProjectVo> retrieveProjectListPagiging(ProjectPagingVo pagingVo);

    // 프로젝트 등록
    void insertUserProject(ProjectVo projectVo);

    // 프로젝트 수정
    void updateProject(ProjectVo projectVo);

    // 프로젝트 삭제
    void deleteProject(ProjectVo projectVo);
}
